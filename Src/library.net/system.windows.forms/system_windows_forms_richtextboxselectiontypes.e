indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.RichTextBoxSelectionTypes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES

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

	frozen empty: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"0"
		end

	frozen text: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"1"
		end

	frozen object: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"2"
		end

	frozen multi_char: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxSelectionTypes use System.Windows.Forms.RichTextBoxSelectionTypes"
		alias
			"4"
		end

	frozen multi_object: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES is
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

end -- class SYSTEM_WINDOWS_FORMS_RICHTEXTBOXSELECTIONTYPES
