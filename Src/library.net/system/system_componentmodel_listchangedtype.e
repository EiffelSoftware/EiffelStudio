indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ListChangedType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE

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

	frozen item_moved: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"3"
		end

	frozen item_added: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"1"
		end

	frozen item_changed: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"4"
		end

	frozen property_descriptor_deleted: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"6"
		end

	frozen item_deleted: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"2"
		end

	frozen property_descriptor_added: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"5"
		end

	frozen reset: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"0"
		end

	frozen property_descriptor_changed: SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE is
		external
			"IL enum signature :System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedType"
		alias
			"7"
		end

end -- class SYSTEM_COMPONENTMODEL_LISTCHANGEDTYPE
