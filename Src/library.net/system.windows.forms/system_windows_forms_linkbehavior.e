indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkBehavior"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR

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

	frozen hover_underline: SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR is
		external
			"IL enum signature :System.Windows.Forms.LinkBehavior use System.Windows.Forms.LinkBehavior"
		alias
			"2"
		end

	frozen always_underline: SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR is
		external
			"IL enum signature :System.Windows.Forms.LinkBehavior use System.Windows.Forms.LinkBehavior"
		alias
			"1"
		end

	frozen system_default: SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR is
		external
			"IL enum signature :System.Windows.Forms.LinkBehavior use System.Windows.Forms.LinkBehavior"
		alias
			"0"
		end

	frozen never_underline: SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR is
		external
			"IL enum signature :System.Windows.Forms.LinkBehavior use System.Windows.Forms.LinkBehavior"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_LINKBEHAVIOR
