indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ViewTechnology"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY

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

	frozen windows_forms: SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY is
		external
			"IL enum signature :System.ComponentModel.Design.ViewTechnology use System.ComponentModel.Design.ViewTechnology"
		alias
			"1"
		end

	frozen passthrough: SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY is
		external
			"IL enum signature :System.ComponentModel.Design.ViewTechnology use System.ComponentModel.Design.ViewTechnology"
		alias
			"0"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY
