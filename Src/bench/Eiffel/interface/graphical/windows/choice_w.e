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

	make, make_with_widget

feature -- Initialization

	make (a_parent: COMPOSITE) is
			-- Make a choice window.
		do
			os_make ("Choice Window", a_parent);
			!! list.make (new_name, Current);
			list.set_single_selection;
			allow_resize;
			set_exclusive_grab;
			list.add_click_action (Current, Void);
			set_composite_attributes (Current)
			map_widget := a_parent;
		end;

	make_with_widget (a_parent: COMPOSITE; a_widget: WIDGET) is
			-- Make a choice window, but map it to `a_widget'.
		do
			make (a_parent);
			map_widget := a_widget
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
			Result := list.selected_item.value
		end;

	popup (command: COMMAND_W; name_list: LIST [STRING]) is
			-- Fill the choice window with `name_list' and
			-- pop it up at the pointer position.
		local
			str: SCROLLABLE_LIST_STRING_ELEMENT
		do
			caller := command;
			list.wipe_out;
			!! str.make (0);
			str.append ("-- cancel --");
			list.extend (str);
			list.forth;
			from
				name_list.start
			until
				name_list.after
			loop
				!! str.make (0);
				str.append (name_list.item);
				list.extend (str);
				name_list.forth
			end
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

	select_i_th (i: INTEGER) is
			-- Select item at the `i'-th position.
		do
			if i >= 1 and then i <= list.count then
				list.select_i_th (i)
			end
		end;

feature {NONE} -- Properties

	list: SCROLLABLE_LIST;

	caller: COMMAND_W;
			-- Command who calls `Current'

	map_widget: WIDGET;
			-- Widget used while mapping Current on the screen

feature {NONE} -- Implementation

	work (argument: ANY) is
		do
		end;

	display is
			-- Display the choice window in order to be seen 
			-- on the screen.
		do
			set_x_y (map_widget.real_x, map_widget.real_y);
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
