indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IButtonControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IBUTTON_CONTROL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_dialog_result: WINFORMS_DIALOG_RESULT is
		external
			"IL deferred signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.IButtonControl"
		alias
			"get_DialogResult"
		end

feature -- Element Change

	set_dialog_result (value: WINFORMS_DIALOG_RESULT) is
		external
			"IL deferred signature (System.Windows.Forms.DialogResult): System.Void use System.Windows.Forms.IButtonControl"
		alias
			"set_DialogResult"
		end

feature -- Basic Operations

	notify_default (value: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Windows.Forms.IButtonControl"
		alias
			"NotifyDefault"
		end

	perform_click is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.IButtonControl"
		alias
			"PerformClick"
		end

end -- class WINFORMS_IBUTTON_CONTROL
