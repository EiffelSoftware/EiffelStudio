indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.SelectionTypes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES

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

	frozen replace: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"2"
		end

	frozen valid: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"31"
		end

	frozen mouse_down: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"4"
		end

	frozen normal: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"1"
		end

	frozen click: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"16"
		end

	frozen mouse_up: SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SELECTIONTYPES
