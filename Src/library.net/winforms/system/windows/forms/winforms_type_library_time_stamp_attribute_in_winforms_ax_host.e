indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_TYPE_LIBRARY_TIME_STAMP_ATTRIBUTE_IN_WINFORMS_AX_HOST

inherit
	ATTRIBUTE

create
	make_winforms_type_library_time_stamp_attribute_in_winforms_ax_host

feature {NONE} -- Initialization

	frozen make_winforms_type_library_time_stamp_attribute_in_winforms_ax_host (timestamp: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.AxHost+TypeLibraryTimeStampAttribute"
		alias
			"get_Value"
		end

end -- class WINFORMS_TYPE_LIBRARY_TIME_STAMP_ATTRIBUTE_IN_WINFORMS_AX_HOST
