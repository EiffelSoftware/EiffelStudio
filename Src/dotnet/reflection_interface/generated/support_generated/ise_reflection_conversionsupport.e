indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.ConversionSupport"

external class
	ISE_REFLECTION_CONVERSIONSUPPORT

inherit
	ISE_REFLECTION_CONVERT
		redefine
			NeutralCulture
		end

create
	make_conversionsupport

feature {NONE} -- Initialization

	frozen make_conversionsupport is
		external
			"IL creator use ISE.Reflection.ConversionSupport"
		end

feature -- Basic Operations

	AssemblyDescriptorFromName (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Reflection.AssemblyName): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyDescriptorFromName"
		end

	AssemblyNameFromDescriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Reflection.AssemblyName use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyNameFromDescriptor"
		end

	NeutralCulture: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"NeutralCulture"
		end

	EmptyString: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"EmptyString"
		end

end -- class ISE_REFLECTION_CONVERSIONSUPPORT
