indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.EditorAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_EDITORATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			is_equal
		end

create
	make_editorattribute_1,
	make_editorattribute_3,
	make_editorattribute,
	make_editorattribute_2

feature {NONE} -- Initialization

	frozen make_editorattribute_1 (type_name: STRING; base_type_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.EditorAttribute"
		end

	frozen make_editorattribute_3 (type: SYSTEM_TYPE; base_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.EditorAttribute"
		end

	frozen make_editorattribute is
		external
			"IL creator use System.ComponentModel.EditorAttribute"
		end

	frozen make_editorattribute_2 (type_name: STRING; base_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.EditorAttribute"
		end

feature -- Access

	frozen get_editor_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.EditorAttribute"
		alias
			"get_EditorTypeName"
		end

	frozen get_editor_base_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.EditorAttribute"
		alias
			"get_EditorBaseTypeName"
		end

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.EditorAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.EditorAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.EditorAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_EDITORATTRIBUTE
