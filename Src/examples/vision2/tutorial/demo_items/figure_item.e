indexing
	description: "A Demo for figures."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FIGURE_ITEM

inherit
	DEMO_ITEM
		redefine
			demo_window, activate
		end

feature {NONE} -- Initialization

	create_demo is
			-- Create the demo_window.
		do
			if demo_window = Void then
				!! demo_window.make (demo_page)
			end
		end

feature -- Access

	demo_window: FIGURE_WINDOW
			-- Demo window associated to the item

	figure: EV_FIGURE is
			-- Current figure associated tothe item.
		deferred
		end

feature {DEMO_ITEM} -- Execution commands

	activate (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		local
			cur: EV_WIDGET
		do
			-- First, we set the demo on the first page.
			if current_demo.item = Void or else current_demo.item /= demo_window then
				cur := current_demo.item
				if cur /= Void then
					cur.set_parent (Void)
				end
				if demo_window = Void then
					create_demo
				else
					demo_window.set_parent (demo_page)
				end
				current_demo.put (demo_window)
			end
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

