indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DrawItemState"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_DRAW_ITEM_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen no_accelerator: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"256"
		end

	frozen grayed: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"2"
		end

	frozen focus: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"16"
		end

	frozen no_focus_rect: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"512"
		end

	frozen hot_light: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"64"
		end

	frozen selected: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"1"
		end

	frozen default_: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"32"
		end

	frozen none: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"0"
		end

	frozen disabled: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"4"
		end

	frozen combo_box_edit: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"4096"
		end

	frozen inactive: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"128"
		end

	frozen checked: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_DRAW_ITEM_STATE
