indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ListSortDirection"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION

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

	frozen descending: SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION is
		external
			"IL enum signature :System.ComponentModel.ListSortDirection use System.ComponentModel.ListSortDirection"
		alias
			"1"
		end

	frozen ascending: SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION is
		external
			"IL enum signature :System.ComponentModel.ListSortDirection use System.ComponentModel.ListSortDirection"
		alias
			"0"
		end

end -- class SYSTEM_COMPONENTMODEL_LISTSORTDIRECTION
