indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Lifetime.ISponsor"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISPONSOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	renewal (lease: ILEASE): TIME_SPAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Lifetime.ILease): System.TimeSpan use System.Runtime.Remoting.Lifetime.ISponsor"
		alias
			"Renewal"
		end

end -- class ISPONSOR
