indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.RichTextBoxSelectionTypes"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen empty: WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"0"
		end

	frozen text: WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"1"
		end

	frozen object: WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"2"
		end

	frozen multi_char: WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"4"
		end

	frozen multi_object: WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_RICH_TEXT_BOX_SELECTION_TYPES
