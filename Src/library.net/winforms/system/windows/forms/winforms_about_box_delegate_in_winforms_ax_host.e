indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AxHost+AboutBoxDelegate"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_ABOUT_BOX_DELEGATE_IN_WINFORMS_AX_HOST

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_winforms_about_box_delegate_in_winforms_ax_host

feature {NONE} -- Initialization

	frozen make_winforms_about_box_delegate_in_winforms_ax_host (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Windows.Forms.AxHost+AboutBoxDelegate"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"Invoke"
		end

end -- class WINFORMS_ABOUT_BOX_DELEGATE_IN_WINFORMS_AX_HOST
