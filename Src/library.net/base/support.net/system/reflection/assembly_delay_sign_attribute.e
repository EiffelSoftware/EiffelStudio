indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyDelaySignAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_DELAY_SIGN_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_assembly_delay_sign_attribute

feature {NONE} -- Initialization

	frozen make_assembly_delay_sign_attribute (delay_sign: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Reflection.AssemblyDelaySignAttribute"
		end

feature -- Access

	frozen get_delay_sign: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.AssemblyDelaySignAttribute"
		alias
			"get_DelaySign"
		end

end -- class ASSEMBLY_DELAY_SIGN_ATTRIBUTE
