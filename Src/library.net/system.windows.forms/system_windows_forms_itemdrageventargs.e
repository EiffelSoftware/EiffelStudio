indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ItemDragEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_itemdrageventargs_1,
	make_itemdrageventargs

feature {NONE} -- Initialization

	frozen make_itemdrageventargs_1 (button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS; item: ANY) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons, System.Object) use System.Windows.Forms.ItemDragEventArgs"
		end

	frozen make_itemdrageventargs (button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons) use System.Windows.Forms.ItemDragEventArgs"
		end

feature -- Access

	frozen get_item: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ItemDragEventArgs"
		alias
			"get_Item"
		end

	frozen get_button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL signature (): System.Windows.Forms.MouseButtons use System.Windows.Forms.ItemDragEventArgs"
		alias
			"get_Button"
		end

end -- class SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTARGS
