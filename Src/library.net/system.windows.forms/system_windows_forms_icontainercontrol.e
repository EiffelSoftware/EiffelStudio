indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IContainerControl"

deferred external class
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_active_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL deferred signature (): System.Windows.Forms.Control use System.Windows.Forms.IContainerControl"
		alias
			"get_ActiveControl"
		end

feature -- Element Change

	set_active_control (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.IContainerControl"
		alias
			"set_ActiveControl"
		end

feature -- Basic Operations

	activate_control (active: SYSTEM_WINDOWS_FORMS_CONTROL): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.IContainerControl"
		alias
			"ActivateControl"
		end

end -- class SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
