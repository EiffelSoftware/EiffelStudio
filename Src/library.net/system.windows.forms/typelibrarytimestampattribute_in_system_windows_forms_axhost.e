indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"

frozen external class
	TYPELIBRARYTIMESTAMPATTRIBUTE_IN_SYSTEM_WINDOWS_FORMS_AXHOST

inherit
	SYSTEM_ATTRIBUTE

create
	make_typelibrarytimestampattribute

feature {NONE} -- Initialization

	frozen make_typelibrarytimestampattribute (timestamp: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"
		alias
			"get_Value"
		end

end -- class TYPELIBRARYTIMESTAMPATTRIBUTE_IN_SYSTEM_WINDOWS_FORMS_AXHOST
