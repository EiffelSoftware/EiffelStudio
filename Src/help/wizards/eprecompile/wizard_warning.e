indexing
	description: "warning dialog for the dialog"
	author: "david_s"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WARNING

inherit
	EV_WARNING_DIALOG


create
	make

feature -- Initialization

	make (s: STRING) is
		local
			ok_button: EV_BUTTON
			cancel_button: EV_BUTTON
		do
			default_create
			
			set_buttons_and_actions (<<"Ok", "Cancel">>, <<~ok, ~cancel>>)
			ok_button:= button ("Ok")
			cancel_button:= button ("Cancel")
			set_default_push_button(ok_button)
			set_default_cancel_button(cancel_button)

			set_text (s)
		end

feature -- Actions

	ok is
		do
			ok_pushed:= True
		end

	cancel is
		do
			ok_pushed:= False
		end

feature -- Access

	ok_pushed: BOOLEAN

end -- class WIZARD_WARNING
