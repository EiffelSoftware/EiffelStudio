indexing
	description: "EiffelVision scrollable area. %
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit

	EV_SCROLLABLE_AREA_I

	EV_CONTAINER_IMP

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			!! wel_window.make (par_imp.wel_window)
			wel_window.show_scroll_bars
		end

feature {NONE} -- Implementation

	wel_window: EV_WEL_CONTROL_WINDOW

end -- class EV_SCROLLABLE_AREA_IMP
