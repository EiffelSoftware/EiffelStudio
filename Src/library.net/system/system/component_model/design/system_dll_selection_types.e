indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.SelectionTypes"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_SELECTION_TYPES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen replace: SYSTEM_DLL_SELECTION_TYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"2"
		end

	frozen valid: SYSTEM_DLL_SELECTION_TYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"31"
		end

	frozen mouse_down: SYSTEM_DLL_SELECTION_TYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"4"
		end

	frozen normal: SYSTEM_DLL_SELECTION_TYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"1"
		end

	frozen click: SYSTEM_DLL_SELECTION_TYPES is
		external
			"IL enum signature :System.ComponentModel.Design.SelectionTypes use System.ComponentModel.Design.SelectionTypes"
		alias
			"16"
		end

	frozen mouse_up: SYSTEM_DLL_SELECTION_TYPES is
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

end -- class SYSTEM_DLL_SELECTION_TYPES
