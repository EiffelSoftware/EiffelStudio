indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyDelaySignAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYDELAYSIGNATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_assemblydelaysignattribute

feature {NONE} -- Initialization

	frozen make_assemblydelaysignattribute (delay_sign: BOOLEAN) is
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

end -- class SYSTEM_REFLECTION_ASSEMBLYDELAYSIGNATTRIBUTE
