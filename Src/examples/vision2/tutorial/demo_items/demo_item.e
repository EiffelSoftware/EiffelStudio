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

	FILE_PATHS

feature {NONE} -- Initialization

	make_with_title (par:EV_TREE_ITEM_HOLDER; txt: STRING) is
			-- Create the item and the demo that
			-- goes with it.
		local
			cmd: EV_ROUTINE_COMMAND
			type: EV_PND_TYPE
		do
			make_with_text (par, txt)
			!! cmd.make (~activate)
			add_select_command (cmd, Void)
			activate_pick_and_drop (Void, Void)
			create type.make
			set_data_type (type)
			set_transported_data ("Bonjour")
		end

	create_demo is
			-- Create the demo_window.
		deferred
		end

feature -- Access


	
	read_text (path: STRING) : STRING is
			-- reads text information from file for use in text area
		local
			
			file: PLAIN_TEXT_FILE
		do
			!!file.make(path)
			file.open_read
			file.start
			file.readstream(file.count)
			result:=file.laststring
		end

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

	example_page: EV_RICH_TEXT is
			-- The class text of the current demo window
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

	control_window: CONTROL_WINDOW
		-- Window to control the options of the widgets.

feature {DEMO_ITEM} -- Execution commands

	activate (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		local
			cur: EV_WIDGET

			dem_win: DEMO_WINDOW
		do
			-- First, we set the demo on the first page.
			cur := current_demo.item

			if cur /= Void then
				cur.set_parent (Void)
				dem_win ?= cur
--				dem_win.clear_notebook
				dem_win.hide_action_window
			end
			if demo_window = Void then
				create_demo
			else
				demo_window.set_parent (demo_page)

				dem_win ?= demo_window
				dem_win.show_action_window
				

			end
			current_demo.put (demo_window)
			example_page.set_text(clone(read_text(example_path)))
			class_page.set_text(clone(read_text(class_path)))	
			text_page.set_text(clone(read_text(docs_path)))
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
