indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MessageBoxDefaultButton"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON

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

	frozen button1: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxDefaultButton use System.Windows.Forms.MessageBoxDefaultButton"
		alias
			"0"
		end

	frozen button2: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxDefaultButton use System.Windows.Forms.MessageBoxDefaultButton"
		alias
			"256"
		end

	frozen button3: SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxDefaultButton use System.Windows.Forms.MessageBoxDefaultButton"
		alias
			"512"
		end

end -- class SYSTEM_WINDOWS_FORMS_MESSAGEBOXDEFAULTBUTTON
