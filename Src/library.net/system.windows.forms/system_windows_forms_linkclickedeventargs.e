indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkClickedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_LINKCLICKEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_linkclickedeventargs

feature {NONE} -- Initialization

	frozen make_linkclickedeventargs (link_text: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.LinkClickedEventArgs"
		end

feature -- Access

	frozen get_link_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LinkClickedEventArgs"
		alias
			"get_LinkText"
		end

end -- class SYSTEM_WINDOWS_FORMS_LINKCLICKEDEVENTARGS
