indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyFlagsAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYFLAGSATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create {NONE}

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.UInt32 use System.Reflection.AssemblyFlagsAttribute"
		alias
			"get_Flags"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYFLAGSATTRIBUTE
