indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DragDropEffects"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_DRAG_DROP_EFFECTS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen scroll: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"-2147483648"
		end

	frozen all_: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"-2147483645"
		end

	frozen link: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"4"
		end

	frozen move: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"2"
		end

	frozen none: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"0"
		end

	frozen copy_: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_DRAG_DROP_EFFECTS
