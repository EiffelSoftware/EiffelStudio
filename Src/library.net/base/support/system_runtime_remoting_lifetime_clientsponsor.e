indexing
	Generator: "Eiffel Emitter 2.7b2"
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
	make_clientsponsor,
	make_clientsponsor_1

feature {NONE} -- Initialization

	frozen make_clientsponsor is
		external
			"IL creator use System.Runtime.Remoting.Lifetime.ClientSponsor"
		end

	frozen make_clientsponsor_1 (renewal_time: SYSTEM_TIMESPAN) is
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

end -- class SYSTEM_RUNTIME_REMOTING_LIFETIME_CLIENTSPONSOR
