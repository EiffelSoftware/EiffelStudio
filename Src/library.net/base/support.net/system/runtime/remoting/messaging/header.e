indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.Header"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	HEADER

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (a_name: SYSTEM_STRING; a_value: SYSTEM_OBJECT; a_must_understand: BOOLEAN; a_header_namespace: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Object, System.Boolean, System.String) use System.Runtime.Remoting.Messaging.Header"
		end

	frozen make (a_name: SYSTEM_STRING; a_value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.String, System.Object) use System.Runtime.Remoting.Messaging.Header"
		end

	frozen make_1 (a_name: SYSTEM_STRING; a_value: SYSTEM_OBJECT; a_must_understand: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Object, System.Boolean) use System.Runtime.Remoting.Messaging.Header"
		end

feature -- Access

	frozen header_namespace: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.Remoting.Messaging.Header"
		alias
			"HeaderNamespace"
		end

	frozen value: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use System.Runtime.Remoting.Messaging.Header"
		alias
			"Value"
		end

	frozen name: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.Remoting.Messaging.Header"
		alias
			"Name"
		end

	frozen must_understand: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.Remoting.Messaging.Header"
		alias
			"MustUnderstand"
		end

end -- class HEADER
