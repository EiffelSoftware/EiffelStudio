indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DragEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_drageventargs

feature {NONE} -- Initialization

	frozen make_drageventargs (data: SYSTEM_WINDOWS_FORMS_IDATAOBJECT; key_state: INTEGER; x: INTEGER; y: INTEGER; allowed_effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS; effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS) is
		external
			"IL creator signature (System.Windows.Forms.IDataObject, System.Int32, System.Int32, System.Int32, System.Windows.Forms.DragDropEffects, System.Windows.Forms.DragDropEffects) use System.Windows.Forms.DragEventArgs"
		end

feature -- Access

	frozen get_allowed_effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragEventArgs"
		alias
			"get_AllowedEffect"
		end

	frozen get_key_state: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_KeyState"
		end

	frozen get_effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragEventArgs"
		alias
			"get_Effect"
		end

	frozen get_data: SYSTEM_WINDOWS_FORMS_IDATAOBJECT is
		external
			"IL signature (): System.Windows.Forms.IDataObject use System.Windows.Forms.DragEventArgs"
		alias
			"get_Data"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_effect (value: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS) is
		external
			"IL signature (System.Windows.Forms.DragDropEffects): System.Void use System.Windows.Forms.DragEventArgs"
		alias
			"set_Effect"
		end

end -- class SYSTEM_WINDOWS_FORMS_DRAGEVENTARGS
