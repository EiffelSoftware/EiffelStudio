indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ComponentModel.Com2Interop.ICom2PropertyPageDisplayService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_ICOM2_PROPERTY_PAGE_DISPLAY_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	show_property_page (title: SYSTEM_STRING; component: SYSTEM_OBJECT; dispid: INTEGER; page_guid: GUID; parent_handle: POINTER) is
		external
			"IL deferred signature (System.String, System.Object, System.Int32, System.Guid, System.IntPtr): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.ICom2PropertyPageDisplayService"
		alias
			"ShowPropertyPage"
		end

end -- class WINFORMS_ICOM2_PROPERTY_PAGE_DISPLAY_SERVICE
