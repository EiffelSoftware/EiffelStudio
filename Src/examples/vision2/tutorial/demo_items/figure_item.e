indexing
	description: "A Demo for figures."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FIGURE_ITEM

inherit
	DEMO_ITEM [FIGURE_WINDOW]
		redefine
			execute
		end

feature -- Access

	figure: EV_FIGURE is
			-- Current figure associated tothe item.
		deferred
		end
		

feature {DEMO_ITEM} -- Execution commands

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		do
			{DEMO_ITEM} Precursor (arg, ev_data)
			demo_window.set_figure (figure)
		end

end -- class FIGURE_ITEM

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

