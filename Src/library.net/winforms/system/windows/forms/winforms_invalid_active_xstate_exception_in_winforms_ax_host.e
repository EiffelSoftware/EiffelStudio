indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+InvalidActiveXStateException"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_INVALID_ACTIVE_XSTATE_EXCEPTION_IN_WINFORMS_AX_HOST

inherit
	EXCEPTION
		redefine
			to_string
		end
	ISERIALIZABLE

create
	make_winforms_invalid_active_xstate_exception_in_winforms_ax_host

feature {NONE} -- Initialization

	frozen make_winforms_invalid_active_xstate_exception_in_winforms_ax_host (name: SYSTEM_STRING; kind: WINFORMS_ACTIVE_XINVOKE_KIND_IN_WINFORMS_AX_HOST) is
		external
			"IL creator signature (System.String, System.Windows.Forms.AxHost+ActiveXInvokeKind) use System.Windows.Forms.AxHost+InvalidActiveXStateException"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.AxHost+InvalidActiveXStateException"
		alias
			"ToString"
		end

end -- class WINFORMS_INVALID_ACTIVE_XSTATE_EXCEPTION_IN_WINFORMS_AX_HOST
