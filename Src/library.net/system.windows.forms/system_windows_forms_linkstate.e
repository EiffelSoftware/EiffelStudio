indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_LINKSTATE

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

	frozen visited: SYSTEM_WINDOWS_FORMS_LINKSTATE is
		external
			"IL enum signature :System.Windows.Forms.LinkState use System.Windows.Forms.LinkState"
		alias
			"4"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_LINKSTATE is
		external
			"IL enum signature :System.Windows.Forms.LinkState use System.Windows.Forms.LinkState"
		alias
			"0"
		end

	frozen hover: SYSTEM_WINDOWS_FORMS_LINKSTATE is
		external
			"IL enum signature :System.Windows.Forms.LinkState use System.Windows.Forms.LinkState"
		alias
			"1"
		end

	frozen active: SYSTEM_WINDOWS_FORMS_LINKSTATE is
		external
			"IL enum signature :System.Windows.Forms.LinkState use System.Windows.Forms.LinkState"
		alias
			"2"
		end

end -- class SYSTEM_WINDOWS_FORMS_LINKSTATE
