indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Formatter"
	assembly: "ISE.Reflection.Formatter", "5.0.0.1", "neutral", "6ce2d06b17bd8359"

external class
	FORMATTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Formatter"
		end

feature -- Access

	frozen get_xml_generation: BOOLEAN is
		external
			"IL signature (): System.Boolean use Formatter"
		alias
			"get_XmlGeneration"
		end

	frozen get_eiffel_formatting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Formatter"
		alias
			"get_EiffelFormatting"
		end

feature -- Element Change

	frozen set_xml_generation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Formatter"
		alias
			"set_XmlGeneration"
		end

	frozen set_eiffel_formatting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Formatter"
		alias
			"set_EiffelFormatting"
		end

feature -- Basic Operations

	frozen set_class_prefix (prefix_: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Formatter"
		alias
			"SetClassPrefix"
		end

	frozen format_type_name (type: TYPE): SYSTEM_STRING is
		external
			"IL signature (System.Type): System.String use Formatter"
		alias
			"FormatTypeName"
		end

	frozen set_assembly (ass: ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use Formatter"
		alias
			"SetAssembly"
		end

	frozen format_to_eiffel (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatToEiffel"
		end

	frozen format_strong_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatStrongName"
		end

	frozen format_argument_type_name (argument_type: TYPE): SYSTEM_STRING is
		external
			"IL signature (System.Type): System.String use Formatter"
		alias
			"FormatArgumentTypeName"
		end

	frozen generate_prefix (type: TYPE; name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Type, System.String): System.String use Formatter"
		alias
			"GeneratePrefix"
		end

	frozen is_enum (type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use Formatter"
		alias
			"IsEnum"
		end

	frozen format_variable_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatVariableName"
		end

end -- class FORMATTER
