indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeReference"

external class
	SYSTEM_CODEDOM_CODETYPEREFERENCE

inherit
	SYSTEM_CODEDOM_CODEOBJECT

create
	make_codetypereference,
	make_codetypereference_3,
	make_codetypereference_1,
	make_codetypereference_2

feature {NONE} -- Initialization

	frozen make_codetypereference (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.CodeDom.CodeTypeReference"
		end

	frozen make_codetypereference_3 (array_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; rank: INTEGER) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.Int32) use System.CodeDom.CodeTypeReference"
		end

	frozen make_codetypereference_1 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeReference"
		end

	frozen make_codetypereference_2 (base_type: STRING; rank: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.CodeDom.CodeTypeReference"
		end

feature -- Access

	frozen get_base_type: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeTypeReference"
		alias
			"get_BaseType"
		end

	frozen get_array_element_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeReference"
		alias
			"get_ArrayElementType"
		end

	frozen get_array_rank: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeTypeReference"
		alias
			"get_ArrayRank"
		end

feature -- Element Change

	frozen set_array_rank (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_ArrayRank"
		end

	frozen set_base_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_BaseType"
		end

	frozen set_array_element_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReference"
		alias
			"set_ArrayElementType"
		end

end -- class SYSTEM_CODEDOM_CODETYPEREFERENCE
