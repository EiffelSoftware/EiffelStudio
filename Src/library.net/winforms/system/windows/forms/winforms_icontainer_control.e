indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IContainerControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_ICONTAINER_CONTROL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_active_control: WINFORMS_CONTROL is
		external
			"IL deferred signature (): System.Windows.Forms.Control use System.Windows.Forms.IContainerControl"
		alias
			"get_ActiveControl"
		end

feature -- Element Change

	set_active_control (value: WINFORMS_CONTROL) is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.IContainerControl"
		alias
			"set_ActiveControl"
		end

feature -- Basic Operations

	activate_control (active: WINFORMS_CONTROL): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.IContainerControl"
		alias
			"ActivateControl"
		end

end -- class WINFORMS_ICONTAINER_CONTROL
