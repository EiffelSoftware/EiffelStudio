indexing
	description:
		"Class Demo item, ancestor of all the items of the tree.%
		% This items have the memory of the system.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DEMO_ITEM

inherit
	EV_TREE_ITEM
		rename
			make as wel_make
		end

feature {NONE} -- Initialization

	make_with_title (par:EV_TREE_ITEM_HOLDER; txt: STRING) is
			-- Create the item and the demo that
			-- goes with it.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			make_with_text (par, txt)
			!! cmd.make (~activate)
			add_activate_command (cmd, Void)
		end

	create_demo is
			-- Create the demo_window.
		deferred
		end

feature -- Access

	demo_page: EV_VERTICAL_BOX is
			-- A HOLDER for the demo of the widget.
		once
			!! Result.make (Void)
		end

	text_page: EV_RICH_TEXT is
			-- The documentation about the widget
		once
			!! Result.make (Void)
		end

	class_page: EV_RICH_TEXT is
			-- The class text of the widget (short_form)
		once
			!! Result.make (Void)
		end

	event_box: EV_LIST is
			-- A list to display the events that occurs
		once
			!! Result.make (Void)
		end

	current_demo: CELL [EV_WIDGET] is
			-- Demo currently in action
		once
			!! Result.put (Void)
		end

	demo_window: EV_WIDGET
		-- Demo window associated to the item

feature {DEMO_ITEM} -- Execution commands

	activate (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		local
			cur: EV_WIDGET
		do
			-- First, we set the demo on the first page.
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

end -- class DEMO_ITEM

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
