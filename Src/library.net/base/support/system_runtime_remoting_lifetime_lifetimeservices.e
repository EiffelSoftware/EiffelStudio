indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Lifetime.LifetimeServices"

external class
	SYSTEM_RUNTIME_REMOTING_LIFETIME_LIFETIMESERVICES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Lifetime.LifetimeServices"
		end

feature -- Access

	frozen get_renew_on_call_time: SYSTEM_TIMESPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_RenewOnCallTime"
		end

	frozen get_sponsorship_timeout: SYSTEM_TIMESPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_SponsorshipTimeout"
		end

	frozen get_lease_manager_poll_time: SYSTEM_TIMESPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_LeaseManagerPollTime"
		end

	frozen get_lease_time: SYSTEM_TIMESPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_LeaseTime"
		end

feature -- Element Change

	frozen set_lease_manager_poll_time (value: SYSTEM_TIMESPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_LeaseManagerPollTime"
		end

	frozen set_renew_on_call_time (value: SYSTEM_TIMESPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_RenewOnCallTime"
		end

	frozen set_sponsorship_timeout (value: SYSTEM_TIMESPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_SponsorshipTimeout"
		end

	frozen set_lease_time (value: SYSTEM_TIMESPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_LeaseTime"
		end

end -- class SYSTEM_RUNTIME_REMOTING_LIFETIME_LIFETIMESERVICES
