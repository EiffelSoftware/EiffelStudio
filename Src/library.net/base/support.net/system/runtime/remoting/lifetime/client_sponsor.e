indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Lifetime.ClientSponsor"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CLIENT_SPONSOR

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			initialize_lifetime_service,
			finalize
		end
	ISPONSOR

create
	make_client_sponsor,
	make_client_sponsor_1

feature {NONE} -- Initialization

	frozen make_client_sponsor is
		external
			"IL creator use System.Runtime.Remoting.Lifetime.ClientSponsor"
		end

	frozen make_client_sponsor_1 (renewal_time: TIME_SPAN) is
		external
			"IL creator signature (System.TimeSpan) use System.Runtime.Remoting.Lifetime.ClientSponsor"
		end

feature -- Access

	frozen get_renewal_time: TIME_SPAN is
		external
			"IL signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"get_RenewalTime"
		end

feature -- Element Change

	frozen set_renewal_time (value: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"set_RenewalTime"
		end

feature -- Basic Operations

	initialize_lifetime_service: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"InitializeLifetimeService"
		end

	frozen register (obj: MARSHAL_BY_REF_OBJECT): BOOLEAN is
		external
			"IL signature (System.MarshalByRefObject): System.Boolean use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Register"
		end

	frozen renewal (lease: ILEASE): TIME_SPAN is
		external
			"IL signature (System.Runtime.Remoting.Lifetime.ILease): System.TimeSpan use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Renewal"
		end

	frozen unregister (obj: MARSHAL_BY_REF_OBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Unregister"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Finalize"
		end

end -- class CLIENT_SPONSOR
