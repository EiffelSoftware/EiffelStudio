class CHOICE_WND 

inherit

	OVERRIDE_S	
		rename
			make as dialog_create,
			popup as old_popup
		export
			{NONE} all;
			{ANY} popdown, is_popped_up
		end;
	WINDOWS;
	COMMAND;
	CONSTANTS

creation

	make

feature 

	position: INTEGER is
			-- Position of selected item
			-- in list of alternatives.
		do
			Result := list.selected_position
		end;

	popup (l: LINKED_LIST [STRING]) is
			-- Fill the choice window with
			-- the list of subtypes of `node_syntype'
			-- and pop it up at the pointer position.
		do
			fill (l);
			set_y (eb_screen.y);
			if eb_screen.x + width > eb_screen.width then
				set_x (eb_screen.width - width);
			else
				set_x (eb_screen.x);
			end
			set_x_y (eb_screen.x, eb_screen.y);
			old_popup;
		end;

feature {NONE}

	fill (l: LINKED_LIST [STRING]) is
		do
			list.wipe_out;
			if l.empty then
				list.put_right ("Cancel");
				list.forth;
				list.put_right ("--no items--");
				list.set_visible_item_count (2);
			else
				from
					list.start;
					l.start;
					list.put_right ("Cancel");
					list.forth;
				until
					l.after
				loop
					list.put_right (l.item);
					l.forth;
					list.forth
				end;
				if list.count >= 10 then
					list.set_visible_item_count (10);
				else
					list.set_visible_item_count (list.count);
				end
			end
		end;	

feature -- EiffelVision

	make (a_parent: COMPOSITE) is
			-- Create choice window.
		do
			dialog_create (Widget_names.base, a_parent);
			!!list.make (Widget_names.list, Current);
			allow_resize;
			list.add_selection_action (Current, Void);
			set_exclusive_grab
		end;

feature {NONE}

	list: SCROLL_LIST;

	execute (argument: ANY) is
		do
			popdown;
			continue_after_popdown
		end;

	continue_after_popdown is
			-- (By default do nothing)
		do
		end

end
