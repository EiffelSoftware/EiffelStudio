indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ConvertEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_CONVERTEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_converteventargs

feature {NONE} -- Initialization

	frozen make_converteventargs (value: ANY; desired_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Object, System.Type) use System.Windows.Forms.ConvertEventArgs"
		end

feature -- Access

	frozen get_desired_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Windows.Forms.ConvertEventArgs"
		alias
			"get_DesiredType"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ConvertEventArgs"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ConvertEventArgs"
		alias
			"set_Value"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONVERTEVENTARGS
