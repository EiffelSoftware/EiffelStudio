indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.EditorBrowsableAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_EDITORBROWSABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_editorbrowsableattribute_1,
	make_editorbrowsableattribute

feature {NONE} -- Initialization

	frozen make_editorbrowsableattribute_1 is
		external
			"IL creator use System.ComponentModel.EditorBrowsableAttribute"
		end

	frozen make_editorbrowsableattribute (state: SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE) is
		external
			"IL creator signature (System.ComponentModel.EditorBrowsableState) use System.ComponentModel.EditorBrowsableAttribute"
		end

feature -- Access

	frozen get_state: SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE is
		external
			"IL signature (): System.ComponentModel.EditorBrowsableState use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"get_State"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_EDITORBROWSABLEATTRIBUTE
