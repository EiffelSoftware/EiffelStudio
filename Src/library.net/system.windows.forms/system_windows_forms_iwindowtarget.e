indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IWindowTarget"

deferred external class
	SYSTEM_WINDOWS_FORMS_IWINDOWTARGET

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	on_message (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
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

end -- class SYSTEM_WINDOWS_FORMS_IWINDOWTARGET
