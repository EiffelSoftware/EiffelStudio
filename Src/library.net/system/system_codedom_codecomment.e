indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeComment"

external class
	SYSTEM_CODEDOM_CODECOMMENT

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codecomment_1,
	make_codecomment,
	make_codecomment_2

feature {NONE} -- Initialization

	frozen make_codecomment_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeComment"
		end

	frozen make_codecomment is
		external
			"IL creator use System.CodeDom.CodeComment"
		end

	frozen make_codecomment_2 (text: STRING; doc_comment: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.CodeDom.CodeComment"
		end

feature -- Access

	frozen get_doc_comment: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeComment"
		alias
			"get_DocComment"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeComment"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeComment"
		alias
			"set_Text"
		end

	frozen set_doc_comment (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeComment"
		alias
			"set_DocComment"
		end

end -- class SYSTEM_CODEDOM_CODECOMMENT
