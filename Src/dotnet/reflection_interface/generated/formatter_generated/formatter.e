indexing
	Generator: "Eiffel Emitter 2.4b2"
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

feature -- Basic Operations

	frozen FormatArgumentTypeName (ArgumentType: SYSTEM_TYPE): STRING is
		external
			"IL signature (System.Type): System.String use Formatter"
		alias
			"FormatArgumentTypeName"
		end

	frozen FormatStrongName (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatStrongName"
		end

	frozen FormatTypeName (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatTypeName"
		end

	frozen SetEnums (SomeEnums: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Formatter"
		alias
			"SetEnums"
		end

	frozen IsEnum (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use Formatter"
		alias
			"IsEnum"
		end

	frozen FormatVariableName (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatVariableName"
		end

feature -- Specials

	frozen set_EiffelFormatting (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Formatter"
		alias
			"set_EiffelFormatting"
		end

	frozen get_EiffelFormatting: BOOLEAN is
		external
			"IL signature (): System.Boolean use Formatter"
		alias
			"get_EiffelFormatting"
		end

feature {NONE} -- Implementation

	frozen FormatToEiffel (Value: STRING): STRING is
		external
			"IL signature (System.String): System.String use Formatter"
		alias
			"FormatToEiffel"
		end

end -- class FORMATTER
