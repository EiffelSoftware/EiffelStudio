indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BASIC_STATUS_BAR

inherit
	EB_STATUS_BAR

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			f: EV_FRAME
			vp: EV_VIEWPORT
		do
			create widget
			create vp
			create f
			f.set_style (feature {EV_FRAME_CONSTANTS}.ev_frame_lowered)
			create label
			vp.extend (label)
			f.extend (vp)
			widget.extend (f)
		end

feature -- Status setting

	display_message (mess: STRING) is
			-- Display `mess'.
		do
			label.set_text (mess)
		end

feature -- Status report

	message: STRING is
			-- Return the currently displayed message.
		do
			Result := label.text
		end

feature -- Access

	widget: EV_STATUS_BAR
			-- Widget representing `Current'.

feature {NONE} -- Implementation

	label: EV_LABEL
			-- Label where messages are displayed.

end -- class EB_BASIC_STATUS_BAR
