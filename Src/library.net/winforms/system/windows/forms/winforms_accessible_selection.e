indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AccessibleSelection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_ACCESSIBLE_SELECTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen take_focus: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"1"
		end

	frozen take_selection: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"2"
		end

	frozen remove_selection: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"16"
		end

	frozen none: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"0"
		end

	frozen add_selection: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"8"
		end

	frozen extend_selection: WINFORMS_ACCESSIBLE_SELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"4"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_ACCESSIBLE_SELECTION
