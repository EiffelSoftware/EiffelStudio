indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IWindowTarget"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IWINDOW_TARGET

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	on_message (m: WINFORMS_MESSAGE) is
		external
			"IL deferred signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.IWindowTarget"
		alias
			"OnMessage"
		end

	on_handle_change (new_handle: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Windows.Forms.IWindowTarget"
		alias
			"OnHandleChange"
		end

end -- class WINFORMS_IWINDOW_TARGET
