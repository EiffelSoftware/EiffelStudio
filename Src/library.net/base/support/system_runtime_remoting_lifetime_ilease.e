indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Lifetime.ILease"

deferred external class
	SYSTEM_RUNTIME_REMOTING_LIFETIME_ILEASE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_current_state: SYSTEM_RUNTIME_REMOTING_LIFETIME_LEASESTATE is
		external
			"IL deferred signature (): System.Runtime.Remoting.Lifetime.LeaseState use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_CurrentState"
		end

	get_current_lease_time: SYSTEM_TIMESPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_CurrentLeaseTime"
		end

	get_sponsorship_timeout: SYSTEM_TIMESPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_SponsorshipTimeout"
		end

	get_renew_on_call_time: SYSTEM_TIMESPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_RenewOnCallTime"
		end

	get_initial_lease_time: SYSTEM_TIMESPAN is
		external
			"IL deferred signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"get_InitialLeaseTime"
		end

feature -- Element Change

	set_initial_lease_time (value: SYSTEM_TIMESPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_InitialLeaseTime"
		end

	set_renew_on_call_time (value: SYSTEM_TIMESPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_RenewOnCallTime"
		end

	set_sponsorship_timeout (value: SYSTEM_TIMESPAN) is
		external
			"IL deferred signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"set_SponsorshipTimeout"
		end

feature -- Basic Operations

	register (obj: SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Register"
		end

	register_isponsor_time_span (obj: SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR; renewal_time: SYSTEM_TIMESPAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor, System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Register"
		end

	renew (renewal_time: SYSTEM_TIMESPAN): SYSTEM_TIMESPAN is
		external
			"IL deferred signature (System.TimeSpan): System.TimeSpan use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Renew"
		end

	unregister (obj: SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ISponsor): System.Void use System.Runtime.Remoting.Lifetime.ILease"
		alias
			"Unregister"
		end

end -- class SYSTEM_RUNTIME_REMOTING_LIFETIME_ILEASE
