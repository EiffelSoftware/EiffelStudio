indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CLSCompliantAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CLSCOMPLIANT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_clscompliant_attribute

feature {NONE} -- Initialization

	frozen make_clscompliant_attribute (is_compliant: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.CLSCompliantAttribute"
		end

feature -- Access

	frozen get_is_compliant: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CLSCompliantAttribute"
		alias
			"get_IsCompliant"
		end

end -- class CLSCOMPLIANT_ATTRIBUTE
