indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.RichTextBoxFinds"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS

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

	frozen reverse: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"16"
		end

	frozen match_case: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"4"
		end

	frozen whole_word: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"2"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS is
		external
			"IL enum signature :System.Windows.Forms.RichTextBoxFinds use System.Windows.Forms.RichTextBoxFinds"
		alias
			"0"
		end

	frozen no_highlight: SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS is
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

end -- class SYSTEM_WINDOWS_FORMS_RICHTEXTBOXFINDS
