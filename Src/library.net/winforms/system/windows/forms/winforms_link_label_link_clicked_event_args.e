indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkLabelLinkClickedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LINK_LABEL_LINK_CLICKED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_link_label_link_clicked_event_args

feature {NONE} -- Initialization

	frozen make_winforms_link_label_link_clicked_event_args (link: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL) is
		external
			"IL creator signature (System.Windows.Forms.LinkLabel+Link) use System.Windows.Forms.LinkLabelLinkClickedEventArgs"
		end

feature -- Access

	frozen get_link: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabelLinkClickedEventArgs"
		alias
			"get_Link"
		end

end -- class WINFORMS_LINK_LABEL_LINK_CLICKED_EVENT_ARGS
