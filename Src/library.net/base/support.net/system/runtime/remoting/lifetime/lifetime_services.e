indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Lifetime.LifetimeServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	LIFETIME_SERVICES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Lifetime.LifetimeServices"
		end

feature -- Access

	frozen get_renew_on_call_time: TIME_SPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_RenewOnCallTime"
		end

	frozen get_sponsorship_timeout: TIME_SPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_SponsorshipTimeout"
		end

	frozen get_lease_time: TIME_SPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_LeaseTime"
		end

	frozen get_lease_manager_poll_time: TIME_SPAN is
		external
			"IL static signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"get_LeaseManagerPollTime"
		end

feature -- Element Change

	frozen set_lease_manager_poll_time (value: TIME_SPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_LeaseManagerPollTime"
		end

	frozen set_renew_on_call_time (value: TIME_SPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_RenewOnCallTime"
		end

	frozen set_sponsorship_timeout (value: TIME_SPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_SponsorshipTimeout"
		end

	frozen set_lease_time (value: TIME_SPAN) is
		external
			"IL static signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.LifetimeServices"
		alias
			"set_LeaseTime"
		end

end -- class LIFETIME_SERVICES
