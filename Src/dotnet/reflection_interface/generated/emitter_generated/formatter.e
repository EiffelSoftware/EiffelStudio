indexing
	Generator: "Eiffel Emitter beta 2"

external class
	FORMATTER
alias
	"Formatter"

inherit
	GLOBALS

create
	make_formatter

feature {NONE} -- Initialization

	frozen make_formatter is
		external
			"IL creator use Formatter"
		end

feature -- Basic Operations

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

end -- class FORMATTER
