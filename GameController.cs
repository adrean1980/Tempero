using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Security.Principal;
using UnityEngine;

public class ToolControllerBehaviour : MonoBehaviour
{
    private static ToolControllerBehaviour instance;

    public class ToolChangeEventArgs : EventArgs
    {
        public int Index;

        public ToolChangeEventArgs(int index)
        {
            Index = index;
        }
    }

    private readonly Type[] tools = new Type[]
    {
        typeof(DragTool),
        typeof(EnergyWireTool),
        typeof(RigidWireTool),
        typeof(UseWireTool),
        typeof(WoodStrutTool),
        typeof(SteelBindingTool),
        typeof(FixedCableTool),
        typeof(LightningTool)
    };

    public ToolBehaviour CurrentTool;

    public CameraControlBehaviour controlBehaviour;

    private readonly SelectionController selectionController = new SelectionController();

    public ContextMenuBehaviour contextMenu;

    private bool isSelecting;

    private Vector2 selectionDragStart;

    public LayerMask SelectionLayer;

    private bool isCurrentlyHolding;

    public PhysicalBehaviour currentlyHovering;

    private bool blockSelection;

    public GameObject selectionIcon;

    public event EventHandler<ToolChangeEventArgs> ToolChanged;

    private float touchStartTime;

    public static ToolControllerBehaviour Main
    {
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<ToolControllerBehaviour>();

            }
            return instance;
        }
    }



















    private void Start()
    {
        SetTool(0);
        blockSelection = false;
        selectionIcon.SetActive(false);
    }

    public void BlockSelectionTool()
    {
        blockSelection = !blockSelection;
        selectionIcon.SetActive(blockSelection);
    }

    public void SetTool(int index)
    {
        if (CurrentTool)
        {
            CurrentTool.OnToolUnchosen();
            isCurrentlyHolding = false;
            CurrentTool.OnDeselect();
            CurrentTool.ActiveSingleSelected = null;
        }
        CurrentTool = GetComponent(tools[index]) as ToolBehaviour;
        if (!CurrentTool)
        {
            CurrentTool = gameObject.AddComponent(tools[index]) as ToolBehaviour;
        }
        CurrentTool.Rigidbody = GetComponent<Rigidbody2D>();
        CurrentTool.OnToolChosen();
        if (ToolChanged != null)
        {
            ToolChanged(this, new ToolChangeEventArgs(index));
        }
    }

    public void SetToolByName(string name)
    {
        for (int i = 0; i < tools.Length; i++)
        {
            if (name.Equals(tools[i].Name))
            {
                SetTool(i);
            }
        }
    }

    public void ShowContextMenu()
    {
        contextMenu.Show(Global.main.TouchPosition);
    }

    private void Update()
    {
        currentlyHovering = null;
        if (!Global.main.GetPausedMenu() && !DialogBox.IsAnyDialogboxOpen && !Global.ActiveUiBlock)
        {
            DetermineHovering();
            HandleTools();
            UpdateSelectionBox();
        }
    }

    private void FixedUpdate()
    {
        if (CurrentTool.ActiveSingleSelected && Input.touchCount > 0 )
        {
            Touch touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Stationary || touch.phase == TouchPhase.Moved)
            {
                CurrentTool.OnFixedHold();
            }
        }
    }

    private void HandleTools()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Began && !Global.main.UILock)
            {
                if (currentlyHovering)
                {
                    selectionController.Select(currentlyHovering, selectionController.SelectedObjects.Contains(currentlyHovering));
                    if (CurrentTool.ActiveSingleSelected)
                    {
                        CurrentTool.OnDeselect();
                    }
                    CurrentTool.ActiveSingleSelected = currentlyHovering;
                }
                else
                {
                    EscapeAndDeselect();
                }
                isCurrentlyHolding = true;
                CurrentTool.OnSelect();
            }
            if (touch.phase == TouchPhase.Stationary || touch.phase == TouchPhase.Moved)
            {
                touchStartTime += Time.deltaTime;
                bool canSelect = !CurrentTool.UsesEmptyDrag && !Global.main.UILock;
                if (CurrentTool.ActiveSingleSelected && isCurrentlyHolding)
                {
                    CurrentTool.OnHold();
                    controlBehaviour.CheckMidleButtons(true);
                }
                if (!CurrentTool.ActiveSingleSelected && touchStartTime >= 0.5f && canSelect)
                {
                    StartSelectionDrag();
                }
            }
            if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled)
            {
                EscapeAndDeselect();
                StopSelectionDrag();
                touchStartTime = 0f;
                controlBehaviour.CheckMidleButtons(false);
            }
        }
    }

    private void DetermineHovering()
    {
        currentlyHovering = null;
        Collider2D collider2D;
        if (Input.touchCount > 0)
        {
            collider2D = Physics2D.OverlapPoint(Global.main.TouchPositionPoint, SelectionLayer);
        }
        else
        {
            collider2D = Physics2D.OverlapPoint(Global.main.MousePosition, SelectionLayer);
        }
        if (collider2D)
        {
            PhysicalBehaviour component = collider2D.GetComponent<PhysicalBehaviour>();
            if (component)
            {
                selectionController.SetHovering(component);
                currentlyHovering = component;
            }
            else
            {
                selectionController.SetHovering(null);
            }
        }
        else
        {
            selectionController.SetHovering(null);
        }
    }

    private void EscapeAndDeselect()
    {
        CurrentTool.OnDeselect();
        CurrentTool.ActiveSingleSelected = null;
        isCurrentlyHolding = false;
        if (!selectionController.SelectedObjects.Contains(currentlyHovering))
        {
            selectionController.ClearSelection();
        }
    }

    private void UpdateSelectionBox()
    {
        if (!blockSelection && isSelecting && Input.touchCount > 0)
        {
            Vector2 vector = (Vector2)Global.main.TouchPosition - selectionDragStart;
            Vector3 position = SelectionBoxBehaviour.Main.transform.position;
            Vector2 zero = Vector2.zero;
            if (vector.sqrMagnitude > 200f)
            {
                SelectionBoxBehaviour.Main.Show();
                if (vector.x < 0f)
                {
                    position.x = Global.main.TouchPosition.x;
                    zero.x = Mathf.Abs(position.x - selectionDragStart.x);
                }
                else
                {
                    position.x = selectionDragStart.x;
                    zero.x = Mathf.Abs(vector.x);
                }
                if (vector.y > 0f)
                {
                    position.y = Global.main.TouchPosition.y;
                    zero.y = Mathf.Abs(position.y - selectionDragStart.y);
                }
                else
                {
                    position.y = selectionDragStart.y;
                    zero.y = Mathf.Abs(vector.y);
                }
                SelectionBoxBehaviour.Main.transform.position = position;
                float num = Mathf.Lerp(Screen.width / Global.main.CanvasScaler.referenceResolution.x, Screen.height / Global.main.CanvasScaler.referenceResolution.y, Global.main.CanvasScaler.matchWidthOrHeight);
                zero.x /= num;
                zero.y /= num;
                SelectionBoxBehaviour.Main.SetSize(zero.x, zero.y);
                Vector3 vector2 = Global.main.camera.ScreenToWorldPoint(selectionDragStart);
                SelectionBoxBehaviour.Main.SetSizeDisplay((Global.main.TouchPositionPoint.x - vector2.x) * 0.82397f, (Global.main.TouchPositionPoint.y - vector2.y) * 0.82397f);
            }
            else
            {
                SelectionBoxBehaviour.Main.Hide();
            }
        }
    }

    private void StartSelectionDrag()
    {
        if (!blockSelection && !isSelecting && Input.touchCount > 0)
        {
            isSelecting = true;
            selectionDragStart = Global.main.TouchPosition;
            SelectionBoxBehaviour.Main.transform.position = selectionDragStart;
        }
    }

    private void StopSelectionDrag()
    {
        if (!blockSelection && isSelecting)
        {
            isSelecting = false;
            SelectionBoxBehaviour.Main.Hide();
            Vector3 vector = Global.main.camera.ScreenToWorldPoint(selectionDragStart);
            Vector3 inputPosition = Vector3.zero;
            Vector3 inputPosition2 = Vector3.zero;
            if (Input.touchCount > 0)
            {
                inputPosition = Global.main.TouchPositionPoint;
                inputPosition2 = Global.main.TouchPosition;
            }
            else
            {
                inputPosition = Global.main.MousePosition;
                inputPosition2 = Input.mousePosition;
            }
            if ((selectionDragStart - (Vector2)inputPosition2).sqrMagnitude >= 200f)
            {
                Debug.DrawLine(vector, inputPosition, Color.green, 5f);
                selectionController.ClearSelection();
                Collider2D[] source = Physics2D.OverlapAreaAll(vector, inputPosition, SelectionLayer);
                selectionController.Select(from c in source
                                           where Global.main.PhysicalObjectsInWorldByTransform.ContainsKey(c.transform)
                                           select c.GetComponent<PhysicalBehaviour>());
            }
        }
    }
}

public abstract class ToolBehaviour : MonoBehaviour
{
    public PhysicalBehaviour ActiveSingleSelected;

    public Rigidbody2D Rigidbody;

    public virtual bool UsesEmptyDrag
    {
        get
        {
            return true;
        }
    }

    public abstract void OnToolChosen();

    public abstract void OnToolUnchosen();

    public abstract void OnSelect();

    public abstract void OnHold();

    public abstract void OnFixedHold();

    public abstract void OnDeselect();
}


public class DragTool : ToolBehaviour
{
    private Vector2 offset;

    private HingeJoint2D dragJoint;

    private bool controlRotation;

    private Rigidbody2D selectedRigidbody;

    private float rotationSpeed = 1f;

    private float rotationAngle = 0f;

    private JointMotor2D motor;

    private static DragTool main;

    private bool rotateRight;

    private bool rotateLeft;

    public static DragTool Main
    {
        get
        {
            if (main == null)
            {
                main = FindObjectOfType<DragTool>();
            }
            return main;
        }
    }

    public override bool UsesEmptyDrag
    {
        get
        {
            return false;
        }
    }
















    public override void OnToolChosen()
    {
        main = this;
        rotateRight = false;
        rotateLeft = false;
    }

    public override void OnToolUnchosen()
    {

    }

    public static PhysicalBehaviour GetHeldObject()
    {
        return main?.ActiveSingleSelected ?? null;
    }

    public override void OnSelect()
    {
        if ((bool)ActiveSingleSelected && !ActiveSingleSelected.GetComponentInChildren<Undraggable>())
        {
            controlRotation = true;
            transform.position = Global.main.TouchPositionPoint;
            Rigidbody.position = Global.main.TouchPositionPoint;
            Rigidbody.velocity = Vector2.zero;
            offset = ActiveSingleSelected.transform.InverseTransformPoint(Global.main.TouchPositionPoint);
            if (!Global.main.Paused)
            {
                Destroy(dragJoint);
                dragJoint = gameObject.AddComponent<HingeJoint2D>();
                dragJoint.useMotor = false;
                dragJoint.autoConfigureConnectedAnchor = false;
                dragJoint.connectedAnchor = offset;
                dragJoint.connectedBody = ActiveSingleSelected.GetComponent<Rigidbody2D>();
            }
            selectedRigidbody = ActiveSingleSelected.GetComponent<Rigidbody2D>();
        }
    }

    public static bool IsAnyParentSelected(PhysicalBehaviour phys)
    {
        foreach (PhysicalBehaviour current in SelectionController.Main.SelectedObjects)
        {
            if (phys != current && phys.transform.IsChildOf(current.transform))
            {
                return true;
            }
        }
        return false;
    }

    public void RotateRight()
    {
        rotationSpeed = 1f;
        rotationAngle -= 250f;
        rotateRight = true;
    }

    public void RotateLeft()
    {
        rotationSpeed = 1f;
        rotationAngle += 250f;
        rotateLeft = true;
    }

    public void DisableRotate(int buttonIndex)
    {
        switch(buttonIndex)
        {
            case 1:
                rotateRight = false;
                break;
            case 2:
                rotateLeft = false;
                break;
        }
    }

    public void ShootGun()
    {
        foreach (PhysicalBehaviour selectedObject in SelectionController.Main.SelectedObjects)
        {
            selectedObject.gameObject.BroadcastMessage("Use", default(ActivationPropagation), SendMessageOptions.DontRequireReceiver);
        }
    }

    public void ShootGunCallback()
    {
        foreach (PhysicalBehaviour selectedObject3 in SelectionController.Main.SelectedObjects)
        {
            selectedObject3.gameObject.BroadcastMessage("UseStop", default(ActivationPropagation), SendMessageOptions.DontRequireReceiver);
        }
    }

    public override void OnHold()
    {
        if (!ActiveSingleSelected || !selectedRigidbody || SelectionController.Main.SelectedObjects.Any((PhysicalBehaviour b) => b.GetComponentInChildren<Undraggable>()))
        {
            return;
        }
        selectedRigidbody.SendMessage("Suspended", SendMessageOptions.DontRequireReceiver);
        if (Global.main.Paused)
        {
            rotationAngle *= Time.unscaledDeltaTime;
            rotationAngle *= rotationSpeed * 0.1f;
            foreach (PhysicalBehaviour item in SelectionController.Main.SelectedObjects.Where((PhysicalBehaviour mBehaviour) => !IsAnyParentSelected(mBehaviour)))
            {
                item.gameObject.transform.position += (Vector3)Global.MouseDelta;
                Vector3 inputPosition = Vector3.zero;
                if (Input.touchCount > 0)
                {
                    item.gameObject.transform.RotateAround(Global.main.TouchPositionPoint, Vector3.forward, rotationAngle);
                }
                else
                {
                    item.gameObject.transform.RotateAround(Global.main.MousePosition, Vector3.forward, rotationAngle);
                }
            }
        }
        else
        {
            MoveToMouse();
        }
    }

    private void Rotate()
    {
        if (dragJoint)
        {
            motor = dragJoint.motor;
            if (controlRotation)
            {
                motor.maxMotorTorque = 1000f;
                motor.motorSpeed = 0f;
            }
            if (rotateRight)
            {
                float num2 = -250;
                dragJoint.useMotor = true;
                num2 *= rotationSpeed * 0.1f;
                motor.motorSpeed = num2;
            }
            if (rotateLeft)
            {
                float num = 250;
                dragJoint.useMotor = true;
                num *= rotationSpeed * 0.1f;
                motor.motorSpeed = num;
            }
            dragJoint.motor = motor;
            if (!controlRotation)
            {
                dragJoint.useMotor = false;
            }
        }
    }

    private void MoveToMouse()
    {
        Vector3 inputPosition = Global.main.TouchPositionPoint - transform.position;
        Rigidbody.AddForce(inputPosition * 1950f * (Time.deltaTime * 60f) * Rigidbody.mass);
    }

    public override void OnDeselect()
    {
        if (dragJoint)
        {
            Destroy(dragJoint);
        }
    }

    public override void OnFixedHold()
    {
        if (!Global.main.Paused && (bool)ActiveSingleSelected && !ActiveSingleSelected.GetComponentInChildren<Undraggable>() && (bool)selectedRigidbody)
        {
            Rotate();
        }
    }
}

public class Global : MonoBehaviour
{
    public AudioMixerGroup SoundEffects;

    public AudioMixerGroup Ambience;

    public AudioMixerGroup UserInterface;

    public Material SelectionOutlineMaterial;

    public Material FrozenOutlineMaterial;

    public List<PhysicalBehaviour> PhysicalObjectsInWorld = new List<PhysicalBehaviour>();

    public Dictionary<Transform, PhysicalBehaviour> PhysicalObjectsInWorldByTransform = new Dictionary<Transform, PhysicalBehaviour>();

    public CameraControlBehaviour CameraControlBehaviour;

    public Camera camera;

    public FireLoopSoundControllerBehaviour FireLoopSoundControllerBehaviour;

    public EventSystem eventSystem;

    public GameObject PauseMenu;

    public bool ShowLimbStatus;

    public static Global main;

    private readonly Dictionary<Vector2Int, List<PhysicalBehaviour>> physicalBehaviourChunks = new Dictionary<Vector2Int, List<PhysicalBehaviour>>();

    public MixerControllerBehaviour MixerControllerBehaviour;

    public ResizeHandles ResizeHandles;

    public float SlowmotionTimescale = 0.5f;

    private float timeScaleTarget = 1f;

    private bool chunksUpToDate;

    public int ActiveUiBlockers;

    public const float MetricMultiplier = 0.82397f;

    private HashSet<AudioSource> audioSources = new HashSet<AudioSource>();

    private bool paused;

    private bool pausedMenu;

    private bool hasBeenPausedByOverlay;

    private Vector3 oldMousePos;

    public CanvasScaler CanvasScaler;

    public Color BloodColor;

    public event EventHandler<bool> LimbStatusToggled;

    private Vector3 mousePosLocal;

    private Vector3 touchPosLocal;

    public bool UILock
    {
        get
        {
            return IsPointerOverUIElement() || ResizeHandles.IsHovering;
        }
    }

    private bool IsPointerOverUIElement()
    {
        return IsPointerOverUIElement(GetEventSystemRaycastResults());
    }

    private bool IsPointerOverUIElement(List<RaycastResult> eventSystemRaysastResults)
    {
        int layerIndex = LayerMask.NameToLayer("UI");
        if (eventSystemRaysastResults.Count > 0)
        {
            if (eventSystemRaysastResults[0].gameObject.layer == layerIndex && !eventSystemRaysastResults[0].gameObject.CompareTag("Tools"))
            {
                return true;
            }
            return false;
        }
        return false;
    }

    private List<RaycastResult> GetEventSystemRaycastResults()
    {
        PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
        pointerEventData.position = TouchPosition;
        List<RaycastResult> list = new List<RaycastResult>();
        EventSystem.current.RaycastAll(pointerEventData, list);
        return list;
    }

    public static bool ActiveUiBlock
    {
        get
        {
            return main.ActiveUiBlockers > 0;
        }
    }

    public bool SlowMotion
    {
        get;
        private set;
    }

    public bool Paused
    {
        get
        {
            return paused;
        }
        private set
        {
            paused = value;
            Rigidbody2D[] array = FindObjectsOfType<Rigidbody2D>();
            for (int i = 0; i < array.Length; i++)
            {
                array[i].interpolation = CurrentInterpolationMode;
            }
        }
    }

    public static RigidbodyInterpolation2D CurrentInterpolationMode
    {
        get
        {
            if (!main.paused)
            {
                return RigidbodyInterpolation2D.Interpolate;
            }
            return RigidbodyInterpolation2D.None;
        }
    }

    public static Vector3 CameraPosition
    {
        get
        {
            return main.camera.transform.position;
        }
        set
        {
            main.camera.transform.position = value;
        }
    }

    public static Vector2 MouseDelta
    {
        get;
        private set;
    }

    public bool GetPausedMenu()
    {
        return pausedMenu;
    }

    public Vector3 TouchPosition
    {
        get
        {
            if (Input.touchCount > 0)
            {
                return Input.GetTouch(0).position;
            }
            else
            {
                return Input.mousePosition;
            }
        }
    }

    public Vector3 TouchPositionPoint
    {
        get
        {
            return touchPosLocal;
        }
    }

    public Vector3 MousePosition
    {
        get
        {
            return mousePosLocal;
        }
    }




















    public void Awake()
    {
        main = this;
        ContraptionSerialiser.Initialise();
        camera = Camera.main;
        CameraControlBehaviour = FindObjectOfType<CameraControlBehaviour>();
    }

    private void Start()
    {
        ActiveUiBlockers = 0;
        SetPausedMenu(false, "Pause");
        eventSystem = EventSystem.current;
        CanvasScaler = FindObjectOfType<CanvasScaler>();
        FireLoopSoundControllerBehaviour = GetComponent<FireLoopSoundControllerBehaviour>();
        StartCoroutine(UpdatePitchRoutine());
    }

    public void SetPausedMenu(bool value, string page = "Pause")
    {
        if (!MixerControllerBehaviour || !PauseMenu)
        {
            Debug.LogError(string.Format("Those Items not initialized correctly.\n<i>{0},{1}</i>", MixerControllerBehaviour, PauseMenu));
        }
        else
        {
            pausedMenu = value;
            MixerControllerBehaviour?.Sync();
            PauseMenu.SetActive(pausedMenu);
            MenuController.SetPage(page);
            StartCoroutine(UpdatePitchRoutine());
        }
    }

    public void ClosePauseMenu()
    {
        SetPausedMenu(false, "Pause");
    }

    public void OpenPauseMenu()
    {
        SetPausedMenu(true, "Pause");
    }

    public void ToggleLimbStatus()
    {
        ShowLimbStatus = !ShowLimbStatus;
        LimbStatusToggled?.Invoke(this, ShowLimbStatus);
    }

    public void AddAudioSource(AudioSource mSource, bool isAmbience = false)
    {
        audioSources.Add(mSource);
        mSource.pitch = Time.timeScale;
        if (!mSource.outputAudioMixerGroup)
        {
            mSource.outputAudioMixerGroup = (isAmbience ? Ambience : SoundEffects);
        }
    }

    private void Update()
    {
        float unscaledDeltaTime = Time.unscaledDeltaTime;
        if (Input.touchCount > 0)
        {
            oldMousePos = touchPosLocal;
        }
        else
        {
            oldMousePos = mousePosLocal;
        }
        UpdateMousePosition();
        float num = (Paused || GetPausedMenu()) ? 0f : timeScaleTarget;
        float timeScale = Time.timeScale;
        Time.timeScale = Mathf.Lerp(timeScale, num, unscaledDeltaTime * 8.5f);
        if (Mathf.Abs(num - timeScale) > 0.001f)
        {
            UpdatePitch(timeScale);
        }
    }

    private void UpdateMousePosition()
    {
        Vector3 mousePosition = Vector3.zero;
        if (Input.touchCount > 0)
        {
            mousePosition = Input.GetTouch(0).position;
        }
        else
        {
            mousePosition = Input.mousePosition;
        }
        mousePosition.z = -camera.transform.position.z;
        Vector3 finalPosition = camera.ScreenToWorldPoint(mousePosition);
        touchPosLocal = finalPosition;
    }

    public void LimbStatusClicked()
    {
        ToggleLimbStatus();
    }

    public void SlowmotionClicked()
    {
        ToggleSlowmotion();
    }

    public void TimeStatusClicked()
    {
        TogglePaused();
    }

    public void AddUiBlocker()
    {
        ActiveUiBlockers++;
    }

    public void RemoveUiBlocker()
    {
        ActiveUiBlockers--;
    }

    private IEnumerator UpdatePitchRoutine()
    {
        float timer = 0f;
        while (timer < 1f)
        {
            timer += Time.unscaledDeltaTime;
            UpdatePitch(Time.timeScale);
            yield return new WaitForEndOfFrame();
        }
        yield break;
    }

    private void UpdatePitch(float timeScale)
    {
        audioSources.RemoveWhere((AudioSource mSource) => !mSource);
        foreach (AudioSource audioSource in audioSources)
        {
            audioSource.pitch = timeScale;
        }
    }

    private void LateUpdate()
    {
        chunksUpToDate = false;
        if (Input.touchCount > 0)
        {
            MouseDelta = touchPosLocal - oldMousePos;
        }
        else
        {
            MouseDelta = mousePosLocal - oldMousePos;
        }
    }

    public void TogglePaused()
    {
        Paused = !Paused;
        NotificationControllerBehaviour.Show(Paused ? "Paused" : "Unpaused");
    }

    public void ToggleSlowmotion()
    {
        SlowMotion = !SlowMotion;
        NotificationControllerBehaviour.Show(SlowMotion ? "Slow motion enabled" : "Slow motion disabled");
        timeScaleTarget = SlowMotion ? (PlayerPrefs.GetFloat("slowMoSpeed", 20f) / 100f) : 1f;
    }

    private void UpdatePhysicalBehaviourChunks()
    {
        physicalBehaviourChunks.Clear();
        foreach (PhysicalBehaviour current in PhysicalObjectsInWorld)
        {
            if (current)
            {
                Vector2Int chunkOf = GetChunkOf(current.transform);
                if (physicalBehaviourChunks.ContainsKey(chunkOf))
                {
                    physicalBehaviourChunks[chunkOf].Add(current);
                }
                else
                {
                    physicalBehaviourChunks.Add(chunkOf, new List<PhysicalBehaviour> { current });
                }
            }
        }
        chunksUpToDate = true;
    }

    private Vector2Int GetChunkOf(Transform trans)
    {
        Vector3 vector = trans.position * 0.2f;
        return new Vector2Int(Mathf.RoundToInt(vector.x), Mathf.RoundToInt(vector.y));
    }

    public IEnumerable<PhysicalBehaviour> GetPhysicsObjectsNear(PhysicalBehaviour me)
    {
        if (!chunksUpToDate)
        {
            UpdatePhysicalBehaviourChunks();
        }
        Vector2Int chunkOf = GetChunkOf(me.transform);
        return physicalBehaviourChunks[chunkOf];
    }
}
