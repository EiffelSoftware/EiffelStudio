indexing
	Generator: "Eiffel Emitter 2.4b2"
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

	ExportClauseFromText (a_text: STRING): ISE_REFLECTION_EXPORTCLAUSE is
		external
			"IL signature (System.String): ISE.Reflection.ExportClause use ISE.Reflection.ConversionSupport"
		alias
			"ExportClauseFromText"
		end

	AssemblyNameFromDescriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Reflection.AssemblyName use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyNameFromDescriptor"
		end

	RenameClauseFromText (a_text: STRING): ISE_REFLECTION_RENAMECLAUSE is
		external
			"IL signature (System.String): ISE.Reflection.RenameClause use ISE.Reflection.ConversionSupport"
		alias
			"RenameClauseFromText"
		end

	ClosingCurlBracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"ClosingCurlBracket"
		end

	SourceFromText (a_text: STRING): STRING is
		external
			"IL signature (System.String): System.String use ISE.Reflection.ConversionSupport"
		alias
			"SourceFromText"
		end

	Space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"Space"
		end

	OpeningCurlBracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"OpeningCurlBracket"
		end

	AssemblyDescriptorFromName (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Reflection.AssemblyName): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyDescriptorFromName"
		end

	TargetFromText (a_text: STRING): STRING is
		external
			"IL signature (System.String): System.String use ISE.Reflection.ConversionSupport"
		alias
			"TargetFromText"
		end

	AsKeyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"AsKeyword"
		end

end -- class ISE_REFLECTION_CONVERSIONSUPPORT
