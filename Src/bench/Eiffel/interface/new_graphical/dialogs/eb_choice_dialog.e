indexing

	desciption: "Window where the user can make choice."
	date: "$Date$"
	revision: "$Revision$"

class

	EB_CHOICE_DIALOG

inherit

	EV_DIALOG
		redefine
			make
		end

	EV_COMMAND
		redefine
			execute
		end

	NEW_EB_CONSTANTS

--	WINDOW_ATTRIBUTES

creation

	make_default

feature -- Initialization

	make (a_parent: EV_WINDOW) is
			-- Make a choice window.
		do
			precursor (a_parent)
			set_title ("Choice Window")
			create list.make (display_area)
			create exit_b.make_with_text (action_area, Interface_names.b_Cancel)
			allow_resize
			set_modal (True)
			list.add_selection_command (Current, Void)
			exit_b.add_click_command (Current, exit_it)
--			set_composite_attributes (Current)
--			set_default_position (False)
--				-- When user closes via the window manager close button
--			set_parent_action ("<Unmap>,<Prop>", Current, exit_b)
		end

	make_default (ctf: like caller) is
			-- Make a choice window, but map it to `a_widget'.
		do
			caller := ctf
			make (caller.tool.parent_window)
		end

feature

	position: INTEGER is
			-- Position of selected item in list of alternatives
		do
			Result := list.selected_item.index
		end

	selected_name: STRING is
			-- Text of selected item in list of alternatives
		do
			Result := list.selected_item.text
		end

	set_list (name_list: LIST [STRING]) is
			-- Fill the choice window with `name_list'
		require
			valid_args: name_list /= Void
		local
			str: EV_LIST_ITEM
			new_width: INTEGER
		do
			list.clear_items
			from
				name_list.start
			until
				name_list.after
			loop
				create str.make_with_text (list, name_list.item)
				new_width := new_width.max (name_list.item.count)
				name_list.forth
			end
--			if list.count >= 15 then
--				list.set_visible_item_count (15)
--			elseif list.count > 0 then
--				list.set_visible_item_count (list.count)
--			else
--				list.set_visible_item_count (1)
--			end
			
			set_width ((150).max (new_width * 10))
				-- a changer quand la fonction set_width_in_rows sera disponible
--			display
		end

--	update_position is
--		do
--			if shown then
--				display
--			end
--		end

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Recall the caller command.
		local
			p: INTEGER
			arg: EV_ARGUMENT1 [EB_CHOICE_DIALOG]
		do
			list.remove_selection_commands
				-- In gtk, an selection event is send when the list
				-- is destroyed, while having a non-void selection.
				-- Of course we do not want this to disturb us.
			if argument /= exit_it and then caller /= Void then
				create arg.make (Current)
				caller.execute (arg, data)
			else
				destroy
			end
		end

--	select_i_th (i: INTEGER) is
--			-- Select item at the `i'-th position.
--		do
--			if i <= list.count and then i > 0 then
--				list.go_to_i_th (i)
--			end
--		end

feature {NONE} -- Properties

	exit_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

feature {NONE} -- Properties

	list: EV_LIST

	exit_b: EV_BUTTON	
			-- Exit button

	caller: EB_TOOL_COMMAND
			-- Command who calls `Current'

feature {NONE} -- Implementation

--	display is
--			-- Display the choice window in order to be seen 
--			-- on the screen.
--		local
--			x1, y1: INTEGER
--			a_widget: EV_WIDGET
--		do
--			if map_widget /= Void then
--				x1 := map_widget.real_x
--				y1 := map_widget.real_y
--			else
--				a_widget := parent
--              x1 := a_widget.real_x + (a_widget.width - width) // 2
--		y1 := a_widget.real_y + (height // 2)
--			end
--			set_x_y (x1, y1)
--			fd_popup
--			if real_x + width > screen.width then
--				set_x (screen.width - width)
--			elseif real_x < 0 then
--				set_x (0)
--			end
--			if real_y + height > screen.height then
--				set_y (screen.height - height)
--			elseif real_y < 0 then
--				set_y (0)
--			end
--		end

invariant

--	list_exists: list /= Void

end -- class EB_CHOICE_DIALOG
