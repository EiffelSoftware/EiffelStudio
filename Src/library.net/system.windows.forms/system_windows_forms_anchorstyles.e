indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AnchorStyles"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_ANCHORSTYLES

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

	frozen right: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"8"
		end

	frozen top: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"1"
		end

	frozen left: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"4"
		end

	frozen bottom: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"2"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_ANCHORSTYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_ANCHORSTYLES
