indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.HelpContextType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE

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

	frozen tool_window_selection: SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE is
		external
			"IL enum signature :System.ComponentModel.Design.HelpContextType use System.ComponentModel.Design.HelpContextType"
		alias
			"3"
		end

	frozen ambient: SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE is
		external
			"IL enum signature :System.ComponentModel.Design.HelpContextType use System.ComponentModel.Design.HelpContextType"
		alias
			"0"
		end

	frozen selection: SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE is
		external
			"IL enum signature :System.ComponentModel.Design.HelpContextType use System.ComponentModel.Design.HelpContextType"
		alias
			"2"
		end

	frozen window: SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE is
		external
			"IL enum signature :System.ComponentModel.Design.HelpContextType use System.ComponentModel.Design.HelpContextType"
		alias
			"1"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE
