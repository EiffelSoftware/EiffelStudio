indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Lifetime.ILease"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ILEASE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_current_state: LEASE_STATE is
		external
			"IL deferred signature (): System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_CurrentState"
		end

	get_current_lease_time: TIME_SPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_CurrentLeaseTime"
		end

	get_sponsorship_timeout: TIME_SPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_SponsorshipTimeout"
		end

	get_renew_on_call_time: TIME_SPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_RenewOnCallTime"
		end

	get_initial_lease_time: TIME_SPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_InitialLeaseTime"
		end

feature -- Element Change

	set_initial_lease_time (value: TIME_SPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_InitialLeaseTime"
		end

	set_renew_on_call_time (value: TIME_SPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_RenewOnCallTime"
		end

	set_sponsorship_timeout (value: TIME_SPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_SponsorshipTimeout"
		end

feature -- Basic Operations

	register (obj: ISPONSOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Register"
		end

	register_isponsor_time_span (obj: ISPONSOR; renewal_time: TIME_SPAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor, System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Register"
		end

	renew (renewal_time: TIME_SPAN): TIME_SPAN is
		external
			"IL deferred signature (System.TimeSpan): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Renew"
		end

	unregister (obj: ISPONSOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Unregister"
		end

end -- class ILEASE
