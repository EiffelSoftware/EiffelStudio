indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ControlStyles"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_CONTROL_STYLES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen double_buffer: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"65536"
		end

	frozen container_control: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"1"
		end

	frozen supports_transparent_back_color: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"2048"
		end

	frozen enable_notify_message: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"32768"
		end

	frozen all_painting_in_wm_paint: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"8192"
		end

	frozen user_mouse: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"1024"
		end

	frozen standard_double_click: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"4096"
		end

	frozen user_paint: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"2"
		end

	frozen fixed_height: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"64"
		end

	frozen resize_redraw: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"16"
		end

	frozen cache_text: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"16384"
		end

	frozen opaque: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"4"
		end

	frozen fixed_width: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"32"
		end

	frozen selectable: WINFORMS_CONTROL_STYLES is
		external
			"IL enum signature :System.Windows.Forms.ControlStyles use System.Windows.Forms.ControlStyles"
		alias
			"512"
		end

	frozen standard_click: WINFORMS_CONTROL_STYLES is
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

end -- class WINFORMS_CONTROL_STYLES
