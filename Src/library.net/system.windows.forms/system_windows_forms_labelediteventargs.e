indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LabelEditEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_LABELEDITEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_labelediteventargs_1,
	make_labelediteventargs

feature {NONE} -- Initialization

	frozen make_labelediteventargs_1 (item: INTEGER; label: STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Windows.Forms.LabelEditEventArgs"
		end

	frozen make_labelediteventargs (item: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.LabelEditEventArgs"
		end

feature -- Access

	frozen get_cancel_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_CancelEdit"
		end

	frozen get_item: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_Item"
		end

	frozen get_label: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LabelEditEventArgs"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_cancel_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LabelEditEventArgs"
		alias
			"set_CancelEdit"
		end

end -- class SYSTEM_WINDOWS_FORMS_LABELEDITEVENTARGS
