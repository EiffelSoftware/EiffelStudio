indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DragAction"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DRAGACTION

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

	frozen drop: SYSTEM_WINDOWS_FORMS_DRAGACTION is
		external
			"IL enum signature :System.Windows.Forms.DragAction use System.Windows.Forms.DragAction"
		alias
			"1"
		end

	frozen cancel: SYSTEM_WINDOWS_FORMS_DRAGACTION is
		external
			"IL enum signature :System.Windows.Forms.DragAction use System.Windows.Forms.DragAction"
		alias
			"2"
		end

	frozen continue: SYSTEM_WINDOWS_FORMS_DRAGACTION is
		external
			"IL enum signature :System.Windows.Forms.DragAction use System.Windows.Forms.DragAction"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_DRAGACTION
