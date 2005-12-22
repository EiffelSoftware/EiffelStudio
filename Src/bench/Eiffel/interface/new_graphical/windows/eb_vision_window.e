indexing
	description	: "Vision window (with access to hidden feature enabled)"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_VISION_WINDOW

inherit
	EV_TITLED_WINDOW
		export
			{EV_ANY, EV_ANY_I, EIFNET_DEBUGGER_SYNCHRO} implementation
		end

create
	default_create,
	make_with_title

feature -- Status setting

end -- class EB_VISION_WINDOW
