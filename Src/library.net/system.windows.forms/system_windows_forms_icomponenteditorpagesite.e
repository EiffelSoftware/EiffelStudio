indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IComponentEditorPageSite"

deferred external class
	SYSTEM_WINDOWS_FORMS_ICOMPONENTEDITORPAGESITE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL deferred signature (): System.Windows.Forms.Control use System.Windows.Forms.IComponentEditorPageSite"
		alias
			"GetControl"
		end

	set_dirty is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.IComponentEditorPageSite"
		alias
			"SetDirty"
		end

end -- class SYSTEM_WINDOWS_FORMS_ICOMPONENTEDITORPAGESITE
