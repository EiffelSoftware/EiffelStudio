indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AssemblyOperatingSystemAttribute"

frozen external class
	SYSTEM_REFLECTION_ASSEMBLYOPERATINGSYSTEMATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create {NONE}

feature -- Access

	frozen get_platform: INTEGER is
		external
			"IL signature (): enum System.PlatformID use System.Reflection.AssemblyOperatingSystemAttribute"
		alias
			"get_Platform"
		ensure
			valid_platform_id: Result = 0 or Result = 1 or Result = 2
		end

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Reflection.AssemblyOperatingSystemAttribute"
		alias
			"get_Version"
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYOPERATINGSYSTEMATTRIBUTE
