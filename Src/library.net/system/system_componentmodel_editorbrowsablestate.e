indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.EditorBrowsableState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen always: SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE is
		external
			"IL enum signature :System.ComponentModel.EditorBrowsableState use System.ComponentModel.EditorBrowsableState"
		alias
			"0"
		end

	frozen never: SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE is
		external
			"IL enum signature :System.ComponentModel.EditorBrowsableState use System.ComponentModel.EditorBrowsableState"
		alias
			"1"
		end

	frozen advanced: SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE is
		external
			"IL enum signature :System.ComponentModel.EditorBrowsableState use System.ComponentModel.EditorBrowsableState"
		alias
			"2"
		end

end -- class SYSTEM_COMPONENTMODEL_EDITORBROWSABLESTATE
