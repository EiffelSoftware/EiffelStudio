indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.Header"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (a_Name: STRING; a_Value: ANY; a_MustUnderstand: BOOLEAN; a_HeaderNamespace: STRING) is
		external
			"IL creator signature (System.String, System.Object, System.Boolean, System.String) use System.Runtime.Remoting.Messaging.Header"
		end

	frozen make (a_Name: STRING; a_Value: ANY) is
		external
			"IL creator signature (System.String, System.Object) use System.Runtime.Remoting.Messaging.Header"
		end

	frozen make_1 (a_Name: STRING; a_Value: ANY; a_MustUnderstand: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Object, System.Boolean) use System.Runtime.Remoting.Messaging.Header"
		end

feature -- Access

	frozen name: STRING is
		external
			"IL field signature :System.String use System.Runtime.Remoting.Messaging.Header"
		alias
			"Name"
		end

	frozen header_namespace: STRING is
		external
			"IL field signature :System.String use System.Runtime.Remoting.Messaging.Header"
		alias
			"HeaderNamespace"
		end

	frozen value: ANY is
		external
			"IL field signature :System.Object use System.Runtime.Remoting.Messaging.Header"
		alias
			"Value"
		end

	frozen must_understand: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.Remoting.Messaging.Header"
		alias
			"MustUnderstand"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER
