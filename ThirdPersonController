using System.Collections;
using UnityEngine;

public class ThirdPersonController : MonoBehaviour
{
    [Tooltip("Speed at which the character moves. It is not affected by gravity or jumping.")]
    public float velocity = 5f;
    [Tooltip("This value is added to the speed value while the character is sprinting.")]
    public float sprintAdittion = 3.5f;
    [Tooltip("The higher the value, the higher the character will jump.")]
    public float jumpForce = 18f;
    [Tooltip("Stay in the air. The higher the value, the longer the character floats before falling.")]
    public float jumpTime = 0.85f;
    [Space]
    [Tooltip("Force that pulls the player down. Changing this value causes all movement, jumping and falling to be changed as well.")]
    public float gravity = 9.8f;

    float jumpElapsedTime = 0;

    // Player states
    bool isJumping = false;
    bool isSprinting = false;
    bool isCrouching = false;

    // Inputs
    float inputHorizontal;
    float inputVertical;
    bool inputJump;
    bool inputCrouch;
    bool inputSprint;

    Animator animator;
    CharacterController cc;

	public bool isGrounded;

	[SerializeField]
	private GameObject[] CharacterSkins;

	public Transform ChainHolder;

	private Joystick _Joystick;

	[SerializeField]
	private AudioSource FootSteps;

	[SerializeField]
	private AudioSource Jump;

	public float stepInterval;

	private float stepTimer;

	public float groundCheckDistance;

    void Start()
    {
        cc = GetComponent<CharacterController>();
        animator = GetComponent<Animator>();

        if (animator == null)
            Debug.LogWarning("Animator component not found.");

        if (ball == null)
            Debug.LogWarning("Ball Rigidbody is not assigned to the script.");
    }

    void Update()
    {
        HandleInputs();
        HandleMovement();
        HandleAnimations();
        HeadHittingDetect();
    }

    public void JumpButton()
    {
    }

    private void CheckSteps()
    {
    }

    private void HandleJump(float directionY)
    {
    }

    private void HandleRotation()
    {
    }

    public bool IsGrounded()
    {
        bool grounded = false;
        Vector3 raycastOrigin = transform.position;
        Vector3 raycastDirection = Vector3.down * groundCheckDistance;
        if (Physics.Raycast(raycastOrigin, raycastDirection, out RaycastHit hitInfo, groundCheckDistance, groundLayer))
        {
            grounded = true;
        }

        Debug.DrawRay(raycastOrigin, raycastDirection, Color.green);
        return grounded;
    }

    void HandleInputs()
    {
        inputHorizontal = Input.GetAxis("Horizontal");
        inputVertical = Input.GetAxis("Vertical");
        inputJump = Input.GetAxis("Jump") == 1f;
        inputSprint = Input.GetAxis("Fire3") == 1f;
        inputCrouch = Input.GetKeyDown(KeyCode.LeftControl) || Input.GetKeyDown(KeyCode.JoystickButton1);

        if (inputCrouch)
            isCrouching = !isCrouching;

        if (inputJump && cc.isGrounded)
        {
            isJumping = true;
            // Uncomment to disable crouching when jumping
            // isCrouching = false;
        }
    }

    void HandleMovement()
    {
        float velocityAdittion = 0;
        if (isSprinting)
            velocityAdittion = sprintAdittion;
        if (isCrouching)
            velocityAdittion = -(velocity * 0.50f);

        float directionX = inputHorizontal * (velocity + velocityAdittion) * Time.deltaTime;
        float directionZ = inputVertical * (velocity + velocityAdittion) * Time.deltaTime;
        float directionY = 0;

        if (isJumping)
        {
            directionY = Mathf.SmoothStep(jumpForce, jumpForce * 0.30f, jumpElapsedTime / jumpTime) * Time.deltaTime;
            jumpElapsedTime += Time.deltaTime;
            if (jumpElapsedTime >= jumpTime)
            {
                isJumping = false;
                jumpElapsedTime = 0;
            }
        }

        directionY = directionY - gravity * Time.deltaTime;

        Vector3 forward = Camera.main.transform.forward;
        Vector3 right = Camera.main.transform.right;
        forward.y = 0;
        right.y = 0;
        forward.Normalize();
        right.Normalize();

        forward = forward * directionZ;
        right = right * directionX;

        if (directionX != 0 || directionZ != 0)
        {
            float angle = Mathf.Atan2(forward.x + right.x, forward.z + right.z) * Mathf.Rad2Deg;
            Quaternion rotation = Quaternion.Euler(0, angle, 0);
            transform.rotation = Quaternion.Slerp(transform.rotation, rotation, 0.15f);
        }

        Vector3 verticalDirection = Vector3.up * directionY;
        Vector3 horizontalDirection = forward + right;

        Vector3 movement = verticalDirection + horizontalDirection;
        cc.Move(movement);
    }

    void HandleAnimations()
    {
        if (cc.isGrounded && animator != null)
        {
            animator.SetBool("crouch", isCrouching);
            float minimumSpeed = 0.9f;
            animator.SetBool("run", cc.velocity.magnitude > minimumSpeed);
            isSprinting = cc.velocity.magnitude > minimumSpeed && inputSprint;
            animator.SetBool("sprint", isSprinting);
        }

        if (animator != null)
            animator.SetBool("air", !cc.isGrounded);
    }

    void HeadHittingDetect()
    {
        float headHitDistance = 1.1f;
        Vector3 ccCenter = transform.TransformPoint(cc.center);
        float hitCalc = cc.height / 2f * headHitDistance;

        if (Physics.Raycast(ccCenter, Vector3.up, hitCalc))
        {
            jumpElapsedTime = 0;
            isJumping = false;
        }
    }

    void OnTriggerEnter(Collider other)
    {
        Debug.Log("OnTriggerEnter called."); // Added to check if the method is called at all
        if (other.CompareTag("ball"))
        {
            Debug.Log("Ball entered the trigger.");
        }
    }
}
