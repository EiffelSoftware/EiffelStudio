indexing
	description: "Dummy implementation for DV_RADIO_BUTTON for type checking purposes."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_RADIO_BUTTON_IMP

inherit
	DV_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_RADIO_BUTTON_IMP
		redefine
			interface
		end
	
create
	make

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: DV_RADIO_BUTTON

end -- class DV_RADIO_BUTTON_IMP
