indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DateTimePickerFormat"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT

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

	frozen time: SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT is
		external
			"IL enum signature :System.Windows.Forms.DateTimePickerFormat use System.Windows.Forms.DateTimePickerFormat"
		alias
			"4"
		end

	frozen custom: SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT is
		external
			"IL enum signature :System.Windows.Forms.DateTimePickerFormat use System.Windows.Forms.DateTimePickerFormat"
		alias
			"8"
		end

	frozen short: SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT is
		external
			"IL enum signature :System.Windows.Forms.DateTimePickerFormat use System.Windows.Forms.DateTimePickerFormat"
		alias
			"2"
		end

	frozen long: SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT is
		external
			"IL enum signature :System.Windows.Forms.DateTimePickerFormat use System.Windows.Forms.DateTimePickerFormat"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATETIMEPICKERFORMAT
