indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewFormatter"

external class
	NEWFORMATTER

inherit
	NEWGLOBALS

create
	make_newformatter

feature {NONE} -- Initialization

	frozen make_newformatter is
		external
			"IL creator use NewFormatter"
		end

feature -- Basic Operations

	frozen FormatStrongName (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use NewFormatter"
		alias
			"FormatStrongName"
		end

	frozen FormatTypeName (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use NewFormatter"
		alias
			"FormatTypeName"
		end

end -- class NEWFORMATTER
