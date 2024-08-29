using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Cpp2IlInjected;
using UnityEngine;
using UnityEngine.AI;

[Cpp2IlInjected.Token(Token = "0x2000038")]
[RequireComponent(typeof(NavMeshAgent))]
public class AgentLinkMover : MonoBehaviour
{
	[Cpp2IlInjected.Token(Token = "0x2000039")]
	[CompilerGenerated]
	private sealed class _003CCurve_003Ed__5 : IEnumerator<object>, IEnumerator, IDisposable
	{
		[Cpp2IlInjected.FieldOffset(Offset = "0x10")]
		[Cpp2IlInjected.Token(Token = "0x400010E")]
		private int _003C_003E1__state;

		[Cpp2IlInjected.FieldOffset(Offset = "0x18")]
		[Cpp2IlInjected.Token(Token = "0x400010F")]
		private object _003C_003E2__current;

		[Cpp2IlInjected.FieldOffset(Offset = "0x20")]
		[Cpp2IlInjected.Token(Token = "0x4000110")]
		public NavMeshAgent agent;

		[Cpp2IlInjected.FieldOffset(Offset = "0x28")]
		[Cpp2IlInjected.Token(Token = "0x4000111")]
		public AgentLinkMover _003C_003E4__this;

		[Cpp2IlInjected.FieldOffset(Offset = "0x30")]
		[Cpp2IlInjected.Token(Token = "0x4000112")]
		public float duration;

		[Cpp2IlInjected.FieldOffset(Offset = "0x34")]
		[Cpp2IlInjected.Token(Token = "0x4000113")]
		private Vector3 _003CstartPos_003E5__2;

		[Cpp2IlInjected.FieldOffset(Offset = "0x40")]
		[Cpp2IlInjected.Token(Token = "0x4000114")]
		private Vector3 _003CendPos_003E5__3;

		[Cpp2IlInjected.FieldOffset(Offset = "0x4C")]
		[Cpp2IlInjected.Token(Token = "0x4000115")]
		private float _003CnormalizedTime_003E5__4;

		[Cpp2IlInjected.Token(Token = "0x17000019")]
		object IEnumerator<object>.Current
		{
			[Cpp2IlInjected.Token(Token = "0x6000106")]
			[Cpp2IlInjected.Address(RVA = "0x10925C8", Offset = "0x10925C8", VA = "0x10935C8", Slot = "4")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x1700001A")]
		object IEnumerator.Current
		{
			[Cpp2IlInjected.Token(Token = "0x6000108")]
			[Cpp2IlInjected.Address(RVA = "0x1092608", Offset = "0x1092608", VA = "0x1093608", Slot = "7")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x6000103")]
		[Cpp2IlInjected.Address(RVA = "0x10922D4", Offset = "0x10922D4", VA = "0x10932D4")]
		[DebuggerHidden]
		public _003CCurve_003Ed__5(int _003C_003E1__state)
		{
			this._003C_003E1__state = _003C_003E1__state;
		}

		[Cpp2IlInjected.Token(Token = "0x6000104")]
		[Cpp2IlInjected.Address(RVA = "0x1092370", Offset = "0x1092370", VA = "0x1093370", Slot = "5")]
		[DebuggerHidden]
		void IDisposable.Dispose()
		{
		}

		[Cpp2IlInjected.Token(Token = "0x6000105")]
		[Cpp2IlInjected.Address(RVA = "0x1092374", Offset = "0x1092374", VA = "0x1093374", Slot = "6")]
		private bool MoveNext()
		{
			//IL_00da: Expected I8, but got I4
			int num = _003C_003E1__state;
			AgentLinkMover agentLinkMover = _003C_003E4__this;
			if (num == 0)
			{
				NavMeshAgent navMeshAgent = agent;
				_003C_003E1__state = num;
				OffMeshLinkData currentOffMeshLinkData = navMeshAgent.currentOffMeshLinkData;
				Vector3 position = agent.transform.position;
				float baseOffset = agent.baseOffset;
				float num2 = _003CnormalizedTime_003E5__4;
				float num3 = agentLinkMover.m_Curve.Evaluate(baseOffset);
				Transform transform = agent.transform;
				float z = _003CendPos_003E5__3.z;
				float num4 = _003CnormalizedTime_003E5__4;
				float z2 = _003CstartPos_003E5__2.z;
				float x = _003CendPos_003E5__3.x;
				Transform transform2 = agent.transform;
				float x2 = _003CendPos_003E5__3.x;
				float y = _003CendPos_003E5__3.y;
				float z3 = _003CendPos_003E5__3.z;
				float num5 = _003CnormalizedTime_003E5__4;
				long num6 = 0L;
				float deltaTime = Time.deltaTime;
				object obj = _003C_003E2__current;
				_003CnormalizedTime_003E5__4 = x2;
				return true;
			}
			return true;
		}

		[Cpp2IlInjected.Token(Token = "0x6000107")]
		[Cpp2IlInjected.Address(RVA = "0x10925D0", Offset = "0x10925D0", VA = "0x10935D0", Slot = "8")]
		[DebuggerHidden]
		void IEnumerator.Reset()
		{
			NotSupportedException ex = new NotSupportedException();
			/*Error: End of method reached without returning.*/;
		}
	}

	[Cpp2IlInjected.Token(Token = "0x200003A")]
	[CompilerGenerated]
	private sealed class _003CNormalSpeed_003Ed__3 : IEnumerator<object>, IEnumerator, IDisposable
	{
		[Cpp2IlInjected.FieldOffset(Offset = "0x10")]
		[Cpp2IlInjected.Token(Token = "0x4000116")]
		private int _003C_003E1__state;

		[Cpp2IlInjected.FieldOffset(Offset = "0x18")]
		[Cpp2IlInjected.Token(Token = "0x4000117")]
		private object _003C_003E2__current;

		[Cpp2IlInjected.FieldOffset(Offset = "0x20")]
		[Cpp2IlInjected.Token(Token = "0x4000118")]
		public NavMeshAgent agent;

		[Cpp2IlInjected.FieldOffset(Offset = "0x28")]
		[Cpp2IlInjected.Token(Token = "0x4000119")]
		private Vector3 _003CendPos_003E5__2;

		[Cpp2IlInjected.Token(Token = "0x1700001B")]
		object IEnumerator<object>.Current
		{
			[Cpp2IlInjected.Token(Token = "0x600010C")]
			[Cpp2IlInjected.Address(RVA = "0x10928B4", Offset = "0x10928B4", VA = "0x10938B4", Slot = "4")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x1700001C")]
		object IEnumerator.Current
		{
			[Cpp2IlInjected.Token(Token = "0x600010E")]
			[Cpp2IlInjected.Address(RVA = "0x10928F4", Offset = "0x10928F4", VA = "0x10938F4", Slot = "7")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x6000109")]
		[Cpp2IlInjected.Address(RVA = "0x109216C", Offset = "0x109216C", VA = "0x109316C")]
		[DebuggerHidden]
		public _003CNormalSpeed_003Ed__3(int _003C_003E1__state)
		{
			this._003C_003E1__state = _003C_003E1__state;
		}

		[Cpp2IlInjected.Token(Token = "0x600010A")]
		[Cpp2IlInjected.Address(RVA = "0x1092610", Offset = "0x1092610", VA = "0x1093610", Slot = "5")]
		[DebuggerHidden]
		void IDisposable.Dispose()
		{
		}

		[Cpp2IlInjected.Token(Token = "0x600010B")]
		[Cpp2IlInjected.Address(RVA = "0x1092614", Offset = "0x1092614", VA = "0x1093614", Slot = "6")]
		private bool MoveNext()
		{
			//IL_00d2: Expected I8, but got I4
			//IL_00c1: Expected I8, but got I4
			int num = _003C_003E1__state;
			if (num == 0)
			{
				NavMeshAgent navMeshAgent = agent;
				_003C_003E1__state = num;
				OffMeshLinkData currentOffMeshLinkData = navMeshAgent.currentOffMeshLinkData;
				float baseOffset = agent.baseOffset;
				Vector3 position = agent.transform.position;
				float x = _003CendPos_003E5__2.x;
				float y = _003CendPos_003E5__2.y;
				float z = _003CendPos_003E5__2.z;
				Transform transform = agent.transform;
				Vector3 position2 = agent.transform.position;
				NavMeshAgent navMeshAgent2 = agent;
				float x2 = _003CendPos_003E5__2.x;
				float y2 = _003CendPos_003E5__2.y;
				float z2 = _003CendPos_003E5__2.z;
				float speed = navMeshAgent2.speed;
				long num2 = 0L;
				float deltaTime = Time.deltaTime;
				if ((object)typeof(Math).TypeHandle != null)
				{
				}
			}
			long num3 = 0L;
			throw new NullReferenceException();
		}

		[Cpp2IlInjected.Token(Token = "0x600010D")]
		[Cpp2IlInjected.Address(RVA = "0x10928BC", Offset = "0x10928BC", VA = "0x10938BC", Slot = "8")]
		[DebuggerHidden]
		void IEnumerator.Reset()
		{
			NotSupportedException ex = new NotSupportedException();
			/*Error: End of method reached without returning.*/;
		}
	}

	[Cpp2IlInjected.Token(Token = "0x200003B")]
	[CompilerGenerated]
	private sealed class _003CParabola_003Ed__4 : IEnumerator<object>, IEnumerator, IDisposable
	{
		[Cpp2IlInjected.FieldOffset(Offset = "0x10")]
		[Cpp2IlInjected.Token(Token = "0x400011A")]
		private int _003C_003E1__state;

		[Cpp2IlInjected.FieldOffset(Offset = "0x18")]
		[Cpp2IlInjected.Token(Token = "0x400011B")]
		private object _003C_003E2__current;

		[Cpp2IlInjected.FieldOffset(Offset = "0x20")]
		[Cpp2IlInjected.Token(Token = "0x400011C")]
		public NavMeshAgent agent;

		[Cpp2IlInjected.FieldOffset(Offset = "0x28")]
		[Cpp2IlInjected.Token(Token = "0x400011D")]
		public float height;

		[Cpp2IlInjected.FieldOffset(Offset = "0x2C")]
		[Cpp2IlInjected.Token(Token = "0x400011E")]
		public float duration;

		[Cpp2IlInjected.FieldOffset(Offset = "0x30")]
		[Cpp2IlInjected.Token(Token = "0x400011F")]
		private Vector3 _003CstartPos_003E5__2;

		[Cpp2IlInjected.FieldOffset(Offset = "0x3C")]
		[Cpp2IlInjected.Token(Token = "0x4000120")]
		private Vector3 _003CendPos_003E5__3;

		[Cpp2IlInjected.FieldOffset(Offset = "0x48")]
		[Cpp2IlInjected.Token(Token = "0x4000121")]
		private float _003CnormalizedTime_003E5__4;

		[Cpp2IlInjected.Token(Token = "0x1700001D")]
		object IEnumerator<object>.Current
		{
			[Cpp2IlInjected.Token(Token = "0x6000112")]
			[Cpp2IlInjected.Address(RVA = "0x1092B24", Offset = "0x1092B24", VA = "0x1093B24", Slot = "4")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x1700001E")]
		object IEnumerator.Current
		{
			[Cpp2IlInjected.Token(Token = "0x6000114")]
			[Cpp2IlInjected.Address(RVA = "0x1092B64", Offset = "0x1092B64", VA = "0x1093B64", Slot = "7")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x600010F")]
		[Cpp2IlInjected.Address(RVA = "0x1092214", Offset = "0x1092214", VA = "0x1093214")]
		[DebuggerHidden]
		public _003CParabola_003Ed__4(int _003C_003E1__state)
		{
			this._003C_003E1__state = _003C_003E1__state;
		}

		[Cpp2IlInjected.Token(Token = "0x6000110")]
		[Cpp2IlInjected.Address(RVA = "0x10928FC", Offset = "0x10928FC", VA = "0x10938FC", Slot = "5")]
		[DebuggerHidden]
		void IDisposable.Dispose()
		{
		}

		[Cpp2IlInjected.Token(Token = "0x6000111")]
		[Cpp2IlInjected.Address(RVA = "0x1092900", Offset = "0x1092900", VA = "0x1093900", Slot = "6")]
		private bool MoveNext()
		{
			//IL_0098: Expected I8, but got I4
			int num = _003C_003E1__state;
			NavMeshAgent navMeshAgent = agent;
			_003C_003E1__state = num;
			OffMeshLinkData currentOffMeshLinkData = navMeshAgent.currentOffMeshLinkData;
			Vector3 position = agent.transform.position;
			if (num == 0)
			{
			}
			float baseOffset = agent.baseOffset;
			float num2 = _003CnormalizedTime_003E5__4;
			NavMeshAgent navMeshAgent2 = agent;
			float num3 = height;
			Transform transform = navMeshAgent2.transform;
			float z = _003CendPos_003E5__3.z;
			float num4 = _003CnormalizedTime_003E5__4;
			float x = _003CstartPos_003E5__2.x;
			float z2 = _003CstartPos_003E5__2.z;
			float num5 = _003CnormalizedTime_003E5__4;
			long num6 = 0L;
			float deltaTime = Time.deltaTime;
			_003CnormalizedTime_003E5__4 = num4;
			return true;
		}

		[Cpp2IlInjected.Token(Token = "0x6000113")]
		[Cpp2IlInjected.Address(RVA = "0x1092B2C", Offset = "0x1092B2C", VA = "0x1093B2C", Slot = "8")]
		[DebuggerHidden]
		void IEnumerator.Reset()
		{
			NotSupportedException ex = new NotSupportedException();
			/*Error: End of method reached without returning.*/;
		}
	}

	[Cpp2IlInjected.Token(Token = "0x200003C")]
	[CompilerGenerated]
	private sealed class 
	 : IEnumerator<object>, IEnumerator, IDisposable
	{
		[Cpp2IlInjected.FieldOffset(Offset = "0x10")]
		[Cpp2IlInjected.Token(Token = "0x4000122")]
		private int _003C_003E1__state;

		[Cpp2IlInjected.FieldOffset(Offset = "0x18")]
		[Cpp2IlInjected.Token(Token = "0x4000123")]
		private object _003C_003E2__current;

		[Cpp2IlInjected.FieldOffset(Offset = "0x20")]
		[Cpp2IlInjected.Token(Token = "0x4000124")]
		public AgentLinkMover _003C_003E4__this;

		[Cpp2IlInjected.FieldOffset(Offset = "0x28")]
		[Cpp2IlInjected.Token(Token = "0x4000125")]
		private NavMeshAgent _003Cagent_003E5__2;

		[Cpp2IlInjected.Token(Token = "0x1700001F")]
		object IEnumerator<object>.Current
		{
			[Cpp2IlInjected.Token(Token = "0x6000118")]
			[Cpp2IlInjected.Address(RVA = "0x1092D34", Offset = "0x1092D34", VA = "0x1093D34", Slot = "4")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x17000020")]
		object IEnumerator.Current
		{
			[Cpp2IlInjected.Token(Token = "0x600011A")]
			[Cpp2IlInjected.Address(RVA = "0x1092D74", Offset = "0x1092D74", VA = "0x1093D74", Slot = "7")]
			[DebuggerHidden]
			get
			{
				return _003C_003E2__current;
			}
		}

		[Cpp2IlInjected.Token(Token = "0x6000115")]
		[Cpp2IlInjected.Address(RVA = "0x10920D8", Offset = "0x10920D8", VA = "0x10930D8")]
		[DebuggerHidden]
		public _003CStart_003Ed__2(int _003C_003E1__state)
		{
			this._003C_003E1__state = _003C_003E1__state;
		}

		[Cpp2IlInjected.Token(Token = "0x6000116")]
		[Cpp2IlInjected.Address(RVA = "0x1092B6C", Offset = "0x1092B6C", VA = "0x1093B6C", Slot = "5")]
		[DebuggerHidden]
		void IDisposable.Dispose()
		{
		}

		[Cpp2IlInjected.Token(Token = "0x6000117")]
		[Cpp2IlInjected.Address(RVA = "0x1092B70", Offset = "0x1092B70", VA = "0x1093B70", Slot = "6")]
		private bool MoveNext()
		{
			//IL_007a: Expected I8, but got I4
			//IL_003a: Expected I8, but got I4
			int num = (_003C_003E1__state = _003C_003E1__state);
			_003Cagent_003E5__2.CompleteOffMeshLink();
			AgentLinkMover agentLinkMover = _003C_003E4__this;
			if (num == 0)
			{
				_003C_003E1__state = num;
				NavMeshAgent component = agentLinkMover.GetComponent<NavMeshAgent>();
				_003Cagent_003E5__2 = component;
				long num2 = 0L;
				bool isOnOffMeshLink = _003Cagent_003E5__2.isOnOffMeshLink;
				OffMeshLinkMoveMethod method = agentLinkMover.m_Method;
				NavMeshAgent navMeshAgent = _003Cagent_003E5__2;
				IEnumerator routine = default(IEnumerator);
				Coroutine coroutine = agentLinkMover.StartCoroutine(routine);
				_003C_003E2__current = coroutine;
				int num3 = 4;
				int num4 = 1;
				_003C_003E1__state = num3;
			}
			long num5 = 0L;
			NavMeshAgent navMeshAgent2 = _003Cagent_003E5__2;
			IEnumerator routine2 = default(IEnumerator);
			Coroutine coroutine2 = agentLinkMover.StartCoroutine(routine2);
			_003C_003E2__current = coroutine2;
			NavMeshAgent navMeshAgent3 = _003Cagent_003E5__2;
			IEnumerator routine3 = default(IEnumerator);
			Coroutine coroutine3 = agentLinkMover.StartCoroutine(routine3);
			_003C_003E2__current = coroutine3;
			throw new NullReferenceException();
		}

		[Cpp2IlInjected.Token(Token = "0x6000119")]
		[Cpp2IlInjected.Address(RVA = "0x1092D3C", Offset = "0x1092D3C", VA = "0x1093D3C", Slot = "8")]
		[DebuggerHidden]
		void IEnumerator.Reset()
		{
			NotSupportedException ex = new NotSupportedException();
			/*Error: End of method reached without returning.*/;
		}
	}

	[Cpp2IlInjected.FieldOffset(Offset = "0x20")]
	[Cpp2IlInjected.Token(Token = "0x400010C")]
	public OffMeshLinkMoveMethod m_Method = OffMeshLinkMoveMethod.Parabola;

	[Cpp2IlInjected.FieldOffset(Offset = "0x28")]
	[Cpp2IlInjected.Token(Token = "0x400010D")]
	public AnimationCurve m_Curve = new AnimationCurve();

	[Cpp2IlInjected.Token(Token = "0x60000FE")]
	[Cpp2IlInjected.Address(RVA = "0x109206C", Offset = "0x109206C", VA = "0x109306C")]
	[IteratorStateMachine(typeof(_003CStart_003Ed__2))]
	private IEnumerator Start()
	{
		_003CStart_003Ed__2 _003CStart_003Ed__ = default(_003CStart_003Ed__2);
		_003CStart_003Ed__._003C_003E4__this = this;
		/*Error: End of method reached without returning.*/;
	}

	[Cpp2IlInjected.Token(Token = "0x60000FF")]
	[Cpp2IlInjected.Address(RVA = "0x1092100", Offset = "0x1092100", VA = "0x1093100")]
	[IteratorStateMachine(typeof(_003CNormalSpeed_003Ed__3))]
	private IEnumerator NormalSpeed(NavMeshAgent agent)
	{
		throw new Cpp2IlInjected.AnalysisFailedException("CPP2IL failed to recover any usable IL for this method.");
	}

	[Cpp2IlInjected.Token(Token = "0x6000100")]
	[Cpp2IlInjected.Address(RVA = "0x1092194", Offset = "0x1092194", VA = "0x1093194")]
	[IteratorStateMachine(typeof(_003CParabola_003Ed__4))]
	private IEnumerator Parabola(NavMeshAgent agent, float height, float duration)
	{
		_003CParabola_003Ed__4 _003CParabola_003Ed__ = default(_003CParabola_003Ed__4);
		_003CParabola_003Ed__.agent = agent;
		/*Error: End of method reached without returning.*/;
	}

	[Cpp2IlInjected.Token(Token = "0x6000101")]
	[Cpp2IlInjected.Address(RVA = "0x109223C", Offset = "0x109223C", VA = "0x109323C")]
	[IteratorStateMachine(typeof(_003CCurve_003Ed__5))]
	private IEnumerator Curve(NavMeshAgent agent, float duration)
	{
		_003CCurve_003Ed__5 _003CCurve_003Ed__ = default(_003CCurve_003Ed__5);
		_003CCurve_003Ed__._003C_003E4__this = this;
		_003CCurve_003Ed__.agent = agent;
		/*Error: End of method reached without returning.*/;
	}

	[Cpp2IlInjected.Token(Token = "0x6000102")]
	[Cpp2IlInjected.Address(RVA = "0x10922FC", Offset = "0x10922FC", VA = "0x10932FC")]
	public AgentLinkMover()
	{
	}
}
