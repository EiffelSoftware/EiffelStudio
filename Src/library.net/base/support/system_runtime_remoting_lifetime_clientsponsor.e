indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Lifetime.ClientSponsor"

external class
	SYSTEM_RUNTIME_REMOTING_LIFETIME_CLIENTSPONSOR

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			initialize_lifetime_service,
			finalize
		end
	SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR

create
	make_client_sponsor,
	make_client_sponsor_1

feature {NONE} -- Initialization

	frozen make_client_sponsor is
		external
			"IL creator use System.Runtime.Remoting.Lifetime.ClientSponsor"
		end

	frozen make_client_sponsor_1 (renewalTime2: SYSTEM_TIMESPAN) is
		external
			"IL creator signature (System.TimeSpan) use System.Runtime.Remoting.Lifetime.ClientSponsor"
		end

feature -- Access

	frozen get_renewal_time: SYSTEM_TIMESPAN is
		external
			"IL signature (): System.TimeSpan use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"get_RenewalTime"
		end

feature -- Element Change

	frozen set_renewal_time (value: SYSTEM_TIMESPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"set_RenewalTime"
		end

feature -- Basic Operations

	frozen close is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Close"
		end

	frozen renewal (lease: SYSTEM_RUNTIME_REMOTING_LIFETIME_ILEASE): SYSTEM_TIMESPAN is
		external
			"IL signature (System.Runtime.Remoting.Lifetime.ILease): System.TimeSpan use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Renewal"
		end

	frozen unregister (obj: SYSTEM_MARSHALBYREFOBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Unregister"
		end

	initialize_lifetime_service: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"InitializeLifetimeService"
		end

	frozen register (obj: SYSTEM_MARSHALBYREFOBJECT): BOOLEAN is
		external
			"IL signature (System.MarshalByRefObject): System.Boolean use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Register"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Lifetime.ClientSponsor"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_LIFETIME_CLIENTSPONSOR
