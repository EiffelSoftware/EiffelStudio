indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ComboBoxStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_COMBOBOXSTYLE

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

	frozen drop_down_list: SYSTEM_WINDOWS_FORMS_COMBOBOXSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ComboBoxStyle use System.Windows.Forms.ComboBoxStyle"
		alias
			"2"
		end

	frozen drop_down: SYSTEM_WINDOWS_FORMS_COMBOBOXSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ComboBoxStyle use System.Windows.Forms.ComboBoxStyle"
		alias
			"1"
		end

	frozen simple: SYSTEM_WINDOWS_FORMS_COMBOBOXSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ComboBoxStyle use System.Windows.Forms.ComboBoxStyle"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_COMBOBOXSTYLE
