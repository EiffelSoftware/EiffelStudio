indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.Dictionary"

external class
	ISE_REFLECTION_DICTIONARY

create
	make_dictionary

feature {NONE} -- Initialization

	frozen make_dictionary is
		external
			"IL creator use ISE.Reflection.Dictionary"
		end

feature -- Basic Operations

	dtdextension: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"DtdExtension"
		end

	space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"Space"
		end

	truestring: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"TrueString"
		end

	falsestring: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"FalseString"
		end

	dtdassemblyfilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"DtdAssemblyFilename"
		end

	indexfilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"IndexFilename"
		end

	xmlextension: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"XmlExtension"
		end

	emptystring: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"EmptyString"
		end

	dash: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"Dash"
		end

	dtdtypefilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"DtdTypeFilename"
		end

	comma: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"Comma"
		end

	dotstring: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Dictionary"
		alias
			"DotString"
		end

end -- class ISE_REFLECTION_DICTIONARY
