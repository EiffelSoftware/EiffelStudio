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

	NAMER

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Make a choice window.
		do
			os_make (a_name, a_parent);
			!! list.make (new_name, Current);
			list.set_single_selection;
			allow_resize;
			set_exclusive_grab;
			list.add_single_action (Current, Void)
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
			list.set_visible_item_count (list.count);
			set_x_y (parent.real_x, parent.real_y);
			os_popup;
			raise
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

invariant

	list_exists: list /= Void

end -- class CHOICE_W
