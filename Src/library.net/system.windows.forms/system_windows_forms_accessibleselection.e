indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AccessibleSelection"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION

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

	frozen take_focus: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"1"
		end

	frozen take_selection: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"2"
		end

	frozen remove_selection: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"16"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"0"
		end

	frozen add_selection: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
		external
			"IL enum signature :System.Windows.Forms.AccessibleSelection use System.Windows.Forms.AccessibleSelection"
		alias
			"8"
		end

	frozen extend_selection: SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION is
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

end -- class SYSTEM_WINDOWS_FORMS_ACCESSIBLESELECTION
