indexing
	description:
		"Class Demo item, ancestor of all the items of the tree.%
		% This items have the memory of the system.";
	date: "$Date$";
	revision: "$Revision$"

class
	DEMO_ITEM [G -> DEMO_WINDOW create make end]

inherit
	EV_TREE_ITEM
		rename
			make as wel_make
		end

	FILE_PATHS

	EV_COMMAND

creation
	make_with_title

feature {NONE} -- Initialization

	make_with_title (par:EV_TREE_ITEM_HOLDER; classs, example: STRING) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_text (par, classs)
			add_select_command (Current, Void)
			class_name := classs
			example_name := example
		end

	create_demo is
			-- Create the demo_window.
		do
			if demo_window = Void then
				create demo_window.make (demo_page)
			end
		end

feature -- Access

	demo_window: G
		-- Demo window associated to the item

	action_button: EV_BUTTON is
			-- An action button to display the action window.
		local
			cmd: EV_ROUTINE_COMMAND
		once
			create Result.make_with_text (Void, "Actions")
			create cmd.make (~action_activate)
			Result.add_click_command (cmd, Void)
			create cmd.make (~event_activate)
			Result.add_click_command (cmd, Void)
		end

	event_button: EV_BUTTON is
			-- An event button to display the event window.
		local
			cmd: EV_ROUTINE_COMMAND
		once
			create Result.make_with_text (Void, "Events")
			create cmd.make (~event_activate)
			Result.add_click_command (cmd, Void)
		end
	
	demo_page: EV_VERTICAL_BOX is
			-- A HOLDER for the demo of the widget.
		once
			create Result.make (Void)
		end

	text_page: EV_RICH_TEXT is
			-- The documentation about the widget
		local
			color: EV_BASIC_COLORS
		once
			create Result.make (Void)
			Result.set_editable (False)
			create color
			Result.set_background_color (color.white)
		end

	class_page: EV_RICH_TEXT is
			-- The class text of the widget (short_form)
		local
			color: EV_BASIC_COLORS
		once
			create Result.make (Void)
			Result.set_editable (False)
			create color
			Result.set_background_color (color.white)
		end

	example_page: EV_RICH_TEXT is
			-- The class text of the current demo window
		local
			color: EV_BASIC_COLORS
		once
			create Result.make (Void)
			Result.set_editable (False)
			create color
			Result.set_background_color (color.white)
		end

	current_demo: CELL [DEMO_WINDOW] is
			-- Demo currently in action
		once
			!! Result.put (Void)
		end

feature -- Basic operation

	display_text (window: EV_RICH_TEXT; path: STRING) is
			-- reads text information from file for use in text area
		local
			file: PLAIN_TEXT_FILE
			warning: EV_WARNING_DIALOG
			str: STRING
		do
			create file.make (path)
			if not file.exists then
				str := "Could not open file : "
				str.append (path)
			--	create warning.make_default (demo_page, "File not found", str)
			else
				file.open_read
				file.start
				file.readstream (file.count)
				window.set_text(file.laststring)
			end
		end

	display_rtf_text (window: EV_RICH_TEXT; path: STRING) is
			-- reads text information from file for use in text area
		local
			str: STRING
			file: RAW_FILE
			warning: EV_WARNING_DIALOG
			window_imp: EV_RICH_TEXT_IMP
		do
			create file.make (path)
			if not file.exists then
				str := "Could not open file : "
				str.append (path)
	--			create warning.make_default (demo_page, "File not found", str)
			else
				file.open_read
--				file.start
--				file.readstream (file.count)
				window_imp ?= window.implementation
				window_imp.load_rtf_file (file)
--				window.set_text (file.laststring)
			end
		end

feature {DEMO_ITEM} -- Execution commands

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		local
			demo: DEMO_WINDOW
			action_shown, event_shown: BOOLEAN
		do
			-- First, we set the demo on the first page.
			demo := current_demo.item
			if demo /= Void then
				demo.set_parent (Void)
				action_shown := demo.action_window_shown
				if action_shown then
--					dem_win.clear_notebook
					demo.hide_action_window
				end
				event_shown := demo.event_window_shown
				if event_shown then
					demo.hide_event_window
				end
			end

			-- Then, we set the new demo
			if demo_window = Void then
				create_demo
			else
				demo_window.set_parent (demo_page)
			end
			demo_window.set_tabs
			current_demo.put (demo_window)

			-- Finally, we set the button and the action
			-- window depending on what is necessary.
			if demo_window.has_action_window then
				action_button.set_insensitive (False)
				if action_shown then
					demo_window.show_action_window
				end
			else
				action_button.set_insensitive (True)
			end	
			if demo_window.has_event_window then
				event_button.set_insensitive (False)
				if event_shown then
					demo_window.show_event_window
				end
			else
				event_button.set_insensitive (True)
			end
			-- And we set the diverse documentations.
			display_text (example_page, example_file)
			display_rtf_text (class_page, class_file)
			display_text (text_page, documentation_file)
		end
 
	action_activate (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Activate feature of the button
		do
			current_demo.item.show_action_window
		end

	event_activate (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Activate feature of the button.
		do
			current_demo.item.show_event_window
		end

end -- class DEMO_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

