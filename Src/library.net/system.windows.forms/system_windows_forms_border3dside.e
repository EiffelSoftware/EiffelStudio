indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Border3DSide"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_BORDER3DSIDE

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

	frozen All_: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2063"
		end

	frozen right: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"4"
		end

	frozen top: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2"
		end

	frozen bottom: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"8"
		end

	frozen left: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"1"
		end

	frozen middle: SYSTEM_WINDOWS_FORMS_BORDER3DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2048"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_BORDER3DSIDE
