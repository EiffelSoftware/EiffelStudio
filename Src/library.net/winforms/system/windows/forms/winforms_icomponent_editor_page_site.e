indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IComponentEditorPageSite"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_ICOMPONENT_EDITOR_PAGE_SITE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_control: WINFORMS_CONTROL is
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

end -- class WINFORMS_ICOMPONENT_EDITOR_PAGE_SITE
