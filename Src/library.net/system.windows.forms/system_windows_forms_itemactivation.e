indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ItemActivation"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_ITEMACTIVATION

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

	frozen two_click: SYSTEM_WINDOWS_FORMS_ITEMACTIVATION is
		external
			"IL enum signature :System.Windows.Forms.ItemActivation use System.Windows.Forms.ItemActivation"
		alias
			"2"
		end

	frozen standard: SYSTEM_WINDOWS_FORMS_ITEMACTIVATION is
		external
			"IL enum signature :System.Windows.Forms.ItemActivation use System.Windows.Forms.ItemActivation"
		alias
			"0"
		end

	frozen one_click: SYSTEM_WINDOWS_FORMS_ITEMACTIVATION is
		external
			"IL enum signature :System.Windows.Forms.ItemActivation use System.Windows.Forms.ItemActivation"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_ITEMACTIVATION
