indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ComponentModel.Com2Interop.ICom2PropertyPageDisplayService"

deferred external class
	SYSTEM_WINDOWS_FORMS_COMPONENTMODEL_COM2INTEROP_ICOM2PROPERTYPAGEDISPLAYSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	show_property_page (title: STRING; component: ANY; dispid: INTEGER; page_guid: SYSTEM_GUID; parent_handle: POINTER) is
		external
			"IL deferred signature (System.String, System.Object, System.Int32, System.Guid, System.IntPtr): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.ICom2PropertyPageDisplayService"
		alias
			"ShowPropertyPage"
		end

end -- class SYSTEM_WINDOWS_FORMS_COMPONENTMODEL_COM2INTEROP_ICOM2PROPERTYPAGEDISPLAYSERVICE
