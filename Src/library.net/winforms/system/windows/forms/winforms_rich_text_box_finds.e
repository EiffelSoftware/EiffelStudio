indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.RichTextBoxFinds"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_RICH_TEXT_BOX_FINDS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen reverse: WINFORMS_RICH_TEXT_BOX_FINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"16"
		end

	frozen match_case: WINFORMS_RICH_TEXT_BOX_FINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"4"
		end

	frozen whole_word: WINFORMS_RICH_TEXT_BOX_FINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"2"
		end

	frozen none: WINFORMS_RICH_TEXT_BOX_FINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"0"
		end

	frozen no_highlight: WINFORMS_RICH_TEXT_BOX_FINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_RICH_TEXT_BOX_FINDS
