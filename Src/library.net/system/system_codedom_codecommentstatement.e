indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeCommentStatement"

external class
	SYSTEM_CODEDOM_CODECOMMENTSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codecommentstatement,
	make_codecommentstatement_3,
	make_codecommentstatement_2,
	make_codecommentstatement_1

feature {NONE} -- Initialization

	frozen make_codecommentstatement is
		external
			"IL creator use System.CodeDom.CodeCommentStatement"
		end

	frozen make_codecommentstatement_3 (text: STRING; doc_comment: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.CodeDom.CodeCommentStatement"
		end

	frozen make_codecommentstatement_2 (text: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeCommentStatement"
		end

	frozen make_codecommentstatement_1 (comment: SYSTEM_CODEDOM_CODECOMMENT) is
		external
			"IL creator signature (System.CodeDom.CodeComment) use System.CodeDom.CodeCommentStatement"
		end

feature -- Access

	frozen get_comment: SYSTEM_CODEDOM_CODECOMMENT is
		external
			"IL signature (): System.CodeDom.CodeComment use System.CodeDom.CodeCommentStatement"
		alias
			"get_Comment"
		end

feature -- Element Change

	frozen set_comment (value: SYSTEM_CODEDOM_CODECOMMENT) is
		external
			"IL signature (System.CodeDom.CodeComment): System.Void use System.CodeDom.CodeCommentStatement"
		alias
			"set_Comment"
		end

end -- class SYSTEM_CODEDOM_CODECOMMENTSTATEMENT
