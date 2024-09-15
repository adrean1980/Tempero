using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ChainGenerator : MonoBehaviour
{
	[Range(3f, 100f)]
	[SerializeField]
	[Space(10f)]
	private int count = 15;

    [Range(0f, 0.05f)]
	[SerializeField]
	private float offset = 0.035f;

    [Space(10f)]
	[SerializeField]
	private bool rotateMidChains = true;

    [SerializeField]
	private bool offsetAffectJoint = true;

    [SerializeField]
	private bool startIsKinematic = true;

    [SerializeField]
	private bool endIsKinematic;

	[Space(10f)]
	[SerializeField]
	private GameObject[] prefabs;

	[SerializeField]
	[HideInInspector]
	private List<GameObject> chains;

	[HideInInspector]
	[SerializeField]
	private bool prevBool_rotation;

	[HideInInspector]
	[SerializeField]
	private bool prevBool_offset;

	[HideInInspector]
	[SerializeField]
	private bool prevBool_kinematicStart = true;

    [HideInInspector]
	[SerializeField]
	private bool prevBool_kinematicEnd = true;

    [HideInInspector]
	[SerializeField]
	private GameObject prevPrefab_1;

	[HideInInspector]
	[SerializeField]
	private GameObject prevPrefab_2;

	[SerializeField]
	[HideInInspector]
	private int prevPrefabCount;

















    private void Update()
    {

    }

    private void UpdatePrefabChange()
	{
        if (prefabs != null && prefabs.Length > 0)
		{
            if (prefabs.Length < 3)
            {
                if (prefabs[0] != prevPrefab_1)
                {
                    prevPrefab_1 = prefabs[0];
                    DeleteAllJoints();
                }
                if (prefabs.Length == 2 && prefabs[1] != prevPrefab_2)
                {
                    prevPrefab_2 = prefabs[1];
                    DeleteAllJoints();
                }
            }
            else
            {
                prefabs = new GameObject[0];
            }
            if (prefabs.Length != prevPrefabCount)
            {
                prevPrefabCount = prefabs.Length;
                DeleteAllJoints();
            }
        }
    }

	private void UpdateBoolChanges(bool countChanged)
	{
        if (rotateMidChains != prevBool_rotation)
        {
            prevBool_rotation = rotateMidChains;
            DeleteAllJoints();
        }
        if (offsetAffectJoint != prevBool_offset)
        {
            prevBool_offset = offsetAffectJoint;
            DeleteAllJoints();
        }
        if (countChanged)
        {
            prevBool_kinematicStart = startIsKinematic;
            if (chains != null && chains.Count > 0)
            {
                GameObject firstChain = chains[0];
                if (firstChain != null)
                {
                    Rigidbody firstChainRigidbody = firstChain.GetComponent<Rigidbody>();
                    if (firstChainRigidbody != null)
                    {
                        firstChainRigidbody.isKinematic = startIsKinematic;
                    }
                }
            }
            prevBool_kinematicEnd = endIsKinematic;
            if (chains != null && chains.Count > 0)
            {
                GameObject lastChain = chains[chains.Count - 1];
                if (lastChain != null)
                {
                    Rigidbody lastChainRigidbody = lastChain.GetComponent<Rigidbody>();
                    if (lastChainRigidbody != null)
                    {
                        lastChainRigidbody.isKinematic = endIsKinematic;
                    }
                }
            }
        }
    }

	private void DeleteAllJoints()
	{
        if (chains != null && chains.Count > 0)
        {
            for (int i = 0; i < chains.Count; i++)
            {
                DestroyImmediate(chains[i]);
            }
            chains.Clear();
        }
    }

	private void UpdateAngles()
	{
        if (chains != null && chains.Count > 0)
        {
            for (int i = 0; i < chains.Count; i++)
            {
                GameObject chainObject = chains[i];
                if (chainObject != null)
                {
                    Transform chainTransform = chainObject.transform;
                    chainTransform.localEulerAngles = new Vector3(0f, 90f, 90f);
                }
            }
        }
    }

	private void UpdateJoint(GameObject go, int index)
	{
        if (go != null)
        {
            Rigidbody rigid = go.GetComponent<Rigidbody>();
            if (rigid != null)
            {
                rigid.isKinematic = false;
                if (chains != null && chains.Count >= 1)
                {
                    if (index == 0)
                    {
                        GameObject firstGo = chains[0];
                        if (firstGo != null)
                        {
                            DestroyImmediate(firstGo);
                        }
                    }
                    else if (index < 1)
                    {
                        ConfigurableJoint configJoin = go.GetComponent<ConfigurableJoint>();
                        if (configJoin != null)
                        {
                            GameObject connectedGo = chains[index];
                            if (connectedGo != null)
                            {
                                Rigidbody connectedRb = connectedGo.GetComponent<Rigidbody>();
                                if (connectedRb != null)
                                {
                                    configJoin.connectedBody = connectedRb;
                                    if (offsetAffectJoint)
                                    {
                                        configJoin.anchor = new Vector3(connectedRb.transform.position.x, 0f, 0f);
                                        if (configJoin.autoConfigureConnectedAnchor)
                                        {
                                            return;
                                        }
                                    }
                                    configJoin.connectedAnchor = Vector3.zero;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private void UpdateNames()
	{
        if (chains != null && chains.Count > 0)
        {
            for (int i = 0; i < chains.Count; i++)
            {
                GameObject chainObject = chains[i];
                if (chainObject != null)
                {
                    if (i == 0)
                    {
                        chainObject.name = "Start";
                    }
                    else
                    {
                        chainObject.name = string.Format("Chain{0}", i);
                    }
                }
            }
            if (endIsKinematic && chains.Count > 0)
            {
                GameObject lastChainObject = chains[chains.Count - 1];
                if (lastChainObject != null)
                {
                    lastChainObject.name = "End";
                }
            }
        }
    }

	private GameObject CreateChain(GameObject prefab)
	{
        if (prefab != null)
        {
            GameObject chain = Instantiate(prefab);
            Transform chainTransform = chain.transform;
            chainTransform.parent = transform;
            chainTransform.localPosition = new Vector3(chainTransform.localPosition.x, 0f);
            return chain;
        }
        else
        {
            return null;
        }
    }
}
