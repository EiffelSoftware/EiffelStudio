indexing

	desciption:
			"Window where the user can make choice.";
	date: "$Date$";
	revision: "$Revision$"

class

	CHOICE_W

inherit

	OVERRIDE_S
		rename
			make as os_make,
			popup as os_popup
		end;

	COMMAND_W
		redefine
			execute
		end;

	NAMER;

	SET_WINDOW_ATTRIBUTES

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE) is
			-- Make a choice window.
		do
			os_make ("Choic Window", a_parent);
			!! list.make (new_name, Current);
			list.set_single_selection;
			allow_resize;
			set_exclusive_grab;
			list.add_single_action (Current, Void);
			set_composite_attributes (Current)
		end;

feature

	position: INTEGER is
			-- Position of selected item in list of alternatives
		do
			Result := list.selected_position
		end;

	selected_item: STRING is
			-- Selected item
		do
			Result := list.selected_item
		end;

	popup (command: COMMAND_W; name_list: LIST [STRING]) is
			-- Fill the choice window with `name_list' and
			-- pop it up at the pointer position.
		do
			caller := command;
			list.wipe_out;
			list.put_right ("-- cancel --");
			list.forth;
			list.merge_right (name_list);
			if list.count >= 15 then
				list.set_visible_item_count (15);
			else
				list.set_visible_item_count (list.count);
			end;
			display
		end;

	update_position is
		do
			if is_popped_up then
				display
			end
		end;

	execute (argument: ANY) is
			-- Recall the caller command.
		do
			popdown;
			caller.execute (Current)
		end;

feature {NONE} -- Implementation

	list: SCROLL_LIST;

	caller: COMMAND_W;
			-- Command who calls `Current'

	work (argument: ANY) is do end;

	display is
			-- Display the choice window in order to be seen 
			-- on the screen.
		do
			set_x_y (parent.real_x, parent.real_y);
			if real_x + width > screen.width then
				set_x (screen.width - width)
			end;
			if real_x < 0 then
				set_x (0)
			end;
			if real_y + height > screen.height then
				set_y (screen.height - height)
			end;
			if real_y < 0 then
				set_y (0)
			end;
			os_popup;
			raise
		end;

invariant

	list_exists: list /= Void

end -- class CHOICE_W
