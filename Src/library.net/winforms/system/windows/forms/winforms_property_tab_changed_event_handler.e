indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyTabChangedEventHandler"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_PROPERTY_TAB_CHANGED_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_winforms_property_tab_changed_event_handler

feature {NONE} -- Initialization

	frozen make_winforms_property_tab_changed_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Windows.Forms.PropertyTabChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (s: SYSTEM_OBJECT; e: WINFORMS_PROPERTY_TAB_CHANGED_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyTabChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (s: SYSTEM_OBJECT; e: WINFORMS_PROPERTY_TAB_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyTabChangedEventArgs): System.Void use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"Invoke"
		end

end -- class WINFORMS_PROPERTY_TAB_CHANGED_EVENT_HANDLER
