indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+ClsidAttribute"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_CLSID_ATTRIBUTE_IN_WINFORMS_AX_HOST

inherit
	ATTRIBUTE

create
	make_winforms_clsid_attribute_in_winforms_ax_host

feature {NONE} -- Initialization

	frozen make_winforms_clsid_attribute_in_winforms_ax_host (clsid: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.AxHost+ClsidAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost+ClsidAttribute"
		alias
			"get_Value"
		end

end -- class WINFORMS_CLSID_ATTRIBUTE_IN_WINFORMS_AX_HOST
