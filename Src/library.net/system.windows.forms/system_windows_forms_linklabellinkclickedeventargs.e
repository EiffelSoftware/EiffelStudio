indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkLabelLinkClickedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_LINKLABELLINKCLICKEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_linklabellinkclickedeventargs

feature {NONE} -- Initialization

	frozen make_linklabellinkclickedeventargs (link: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL) is
		external
			"IL creator signature (System.Windows.Forms.LinkLabel+Link) use System.Windows.Forms.LinkLabelLinkClickedEventArgs"
		end

feature -- Access

	frozen get_link: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL is
		external
			"IL signature (): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabelLinkClickedEventArgs"
		alias
			"get_Link"
		end

end -- class SYSTEM_WINDOWS_FORMS_LINKLABELLINKCLICKEDEVENTARGS
