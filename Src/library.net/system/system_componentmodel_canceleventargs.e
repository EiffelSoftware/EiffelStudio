indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.CancelEventArgs"

external class
	SYSTEM_COMPONENTMODEL_CANCELEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_canceleventargs_1,
	make_canceleventargs

feature {NONE} -- Initialization

	frozen make_canceleventargs_1 (cancel: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.CancelEventArgs"
		end

	frozen make_canceleventargs is
		external
			"IL creator use System.ComponentModel.CancelEventArgs"
		end

feature -- Access

	frozen get_cancel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.CancelEventArgs"
		alias
			"get_Cancel"
		end

feature -- Element Change

	frozen set_cancel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.CancelEventArgs"
		alias
			"set_Cancel"
		end

end -- class SYSTEM_COMPONENTMODEL_CANCELEVENTARGS
