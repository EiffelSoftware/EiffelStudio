indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.QueryContinueDragEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_querycontinuedrageventargs

feature {NONE} -- Initialization

	frozen make_querycontinuedrageventargs (key_state: INTEGER; escape_pressed: BOOLEAN; action: SYSTEM_WINDOWS_FORMS_DRAGACTION) is
		external
			"IL creator signature (System.Int32, System.Boolean, System.Windows.Forms.DragAction) use System.Windows.Forms.QueryContinueDragEventArgs"
		end

feature -- Access

	frozen get_escape_pressed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_EscapePressed"
		end

	frozen get_key_state: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_KeyState"
		end

	frozen get_action: SYSTEM_WINDOWS_FORMS_DRAGACTION is
		external
			"IL signature (): System.Windows.Forms.DragAction use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"get_Action"
		end

feature -- Element Change

	frozen set_action (value: SYSTEM_WINDOWS_FORMS_DRAGACTION) is
		external
			"IL signature (System.Windows.Forms.DragAction): System.Void use System.Windows.Forms.QueryContinueDragEventArgs"
		alias
			"set_Action"
		end

end -- class SYSTEM_WINDOWS_FORMS_QUERYCONTINUEDRAGEVENTARGS
