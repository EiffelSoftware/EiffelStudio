indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Formatter"

external class
	FORMATTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Formatter"
		end

feature -- Access

	frozen get_eiffel_formatting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Formatter"
		alias
			"get_EiffelFormatting"
		end

feature -- Element Change

	frozen set_eiffel_formatting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Formatter"
		alias
			"set_EiffelFormatting"
		end

feature -- Basic Operations

	frozen format_variable_name (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatVariableName"
		end

	frozen format_type_name (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatTypeName"
		end

	frozen is_enum (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use Formatter"
		alias
			"IsEnum"
		end

	frozen format_argument_type_name (argument_type: SYSTEM_TYPE): STRING is
		external
			"IL signature (System.Type): System.String use Formatter"
		alias
			"FormatArgumentTypeName"
		end

	frozen format_strong_name (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatStrongName"
		end

feature {NONE} -- Implementation

	frozen format_to_eiffel (value: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatToEiffel"
		end

end -- class FORMATTER
