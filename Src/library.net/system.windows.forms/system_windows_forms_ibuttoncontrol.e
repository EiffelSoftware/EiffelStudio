indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IButtonControl"

deferred external class
	SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_dialog_result: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL deferred signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.IButtonControl"
		alias
			"get_DialogResult"
		end

feature -- Element Change

	set_dialog_result (value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT) is
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

end -- class SYSTEM_WINDOWS_FORMS_IBUTTONCONTROL
