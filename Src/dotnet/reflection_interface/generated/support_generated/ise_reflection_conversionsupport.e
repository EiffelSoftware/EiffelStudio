indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.ConversionSupport"

external class
	ISE_REFLECTION_CONVERSIONSUPPORT

inherit
	ISE_REFLECTION_CONVERT

create
	make_conversionsupport

feature {NONE} -- Initialization

	frozen make_conversionsupport is
		external
			"IL creator use ISE.Reflection.ConversionSupport"
		end

feature -- Basic Operations

	closing_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"ClosingCurlBracket"
		end

	space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"Space"
		end

	target_from_text (a_text: STRING): STRING is
		external
			"IL signature (System.String): System.String use ISE.Reflection.ConversionSupport"
		alias
			"TargetFromText"
		end

	opening_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"OpeningCurlBracket"
		end

	assembly_name_from_descriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Reflection.AssemblyName use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyNameFromDescriptor"
		end

	rename_clause_from_text (a_text: STRING): ISE_REFLECTION_RENAMECLAUSE is
		external
			"IL signature (System.String): ISE.Reflection.RenameClause use ISE.Reflection.ConversionSupport"
		alias
			"RenameClauseFromText"
		end

	as_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ConversionSupport"
		alias
			"AsKeyword"
		end

	source_from_text (a_text: STRING): STRING is
		external
			"IL signature (System.String): System.String use ISE.Reflection.ConversionSupport"
		alias
			"SourceFromText"
		end

	export_clause_from_text (a_text: STRING): ISE_REFLECTION_EXPORTCLAUSE is
		external
			"IL signature (System.String): ISE.Reflection.ExportClause use ISE.Reflection.ConversionSupport"
		alias
			"ExportClauseFromText"
		end

	assembly_descriptor_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Reflection.AssemblyName): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ConversionSupport"
		alias
			"AssemblyDescriptorFromName"
		end

end -- class ISE_REFLECTION_CONVERSIONSUPPORT
