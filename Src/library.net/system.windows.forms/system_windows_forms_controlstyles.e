indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ControlStyles"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_CONTROLSTYLES

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

	frozen double_buffer: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"65536"
		end

	frozen container_control: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"1"
		end

	frozen supports_transparent_back_color: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"2048"
		end

	frozen enable_notify_message: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"32768"
		end

	frozen all_painting_in_wm_paint: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"8192"
		end

	frozen user_mouse: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"1024"
		end

	frozen standard_double_click: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"4096"
		end

	frozen user_paint: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"2"
		end

	frozen fixed_height: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"64"
		end

	frozen resize_redraw: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"16"
		end

	frozen cache_text: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"16384"
		end

	frozen opaque: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"4"
		end

	frozen fixed_width: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"32"
		end

	frozen selectable: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"512"
		end

	frozen standard_click: SYSTEM_WINDOWS_FORMS_CONTROLSTYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"256"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTROLSTYLES
