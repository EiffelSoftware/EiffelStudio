indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CHOOSE_ACE_CALLBACK

feature {EB_CHOOSE_ACE_DIALOG} -- Callbacks

	load_chosen is deferred end
	load_default_ace is deferred end

	associated_window: EV_WINDOW is deferred end
end -- class EB_CHOOSE_ACE_CALLBACK
