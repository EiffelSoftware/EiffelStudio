indexing
	description: "Dummy interface for DV_RADIO_BUTTON for type checking purposes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_RADIO_BUTTON_I
	
inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: DV_RADIO_BUTTON

end -- class DV_RADIO_BUTTON_I
