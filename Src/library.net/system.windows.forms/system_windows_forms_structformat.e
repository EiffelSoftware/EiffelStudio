indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StructFormat"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_STRUCTFORMAT

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

	frozen ansi: SYSTEM_WINDOWS_FORMS_STRUCTFORMAT is
		external
			"IL enum signature :System.Windows.Forms.StructFormat use System.Windows.Forms.StructFormat"
		alias
			"1"
		end

	frozen unicode: SYSTEM_WINDOWS_FORMS_STRUCTFORMAT is
		external
			"IL enum signature :System.Windows.Forms.StructFormat use System.Windows.Forms.StructFormat"
		alias
			"2"
		end

	frozen auto: SYSTEM_WINDOWS_FORMS_STRUCTFORMAT is
		external
			"IL enum signature :System.Windows.Forms.StructFormat use System.Windows.Forms.StructFormat"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_STRUCTFORMAT
