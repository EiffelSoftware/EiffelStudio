indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Lifetime.ISponsor"

deferred external class
	SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	renewal (lease: SYSTEM_RUNTIME_REMOTING_LIFETIME_ILEASE): SYSTEM_TIMESPAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ILease): System.TimeSpan use System.Runtime.Remoting.Lifetime.ISponsor"
		alias
			"Renewal"
		end

end -- class SYSTEM_RUNTIME_REMOTING_LIFETIME_ISPONSOR
