
class CHOICE_WND 

inherit

	OVERRIDE_S	
		rename
			make as dialog_create,
			popup as old_popup
		export
			{NONE} all;
			{ANY} popdown, is_poped_up
		undefine
			init_toolkit
		end;
	WIDGET_NAMES
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end;
	COMMAND

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
			set_x_y (eb_screen.x, eb_screen.y);
			old_popup;
			--list.manage;
		end;

feature {NONE}

	fill (l: LINKED_LIST [STRING]) is
		do
			list.wipe_out;
			if
				l.empty
			then
				list.add_right ("Cancel");
				list.forth;
				list.add_right ("--no items--");
				list.set_visible_item_count (2);
			else
				from
					list.start;
					l.start;
					list.add_right ("Cancel");
					list.forth;
				until
					l.after
				loop
					list.add_right (l.item);
					l.forth;
					list.forth
				end;
				list.set_visible_item_count (list.count);
			end
		end;	

feature -- EiffelVision

	make (a_parent: COMPOSITE) is
			-- Create choice window.
		local
			Nothing: ANY
		do
			dialog_create ("Popup", a_parent);
			!!list.make (L_ist, Current);
			allow_resize;
			list.add_selection_action (Current, Nothing);
		end;

feature {NONE}

	list: SCROLL_LIST;

	execute (argument: ANY) is
		do
			popdown;
			--list.unmanage;
			continue_after_popdown
		end;

	continue_after_popdown is
			-- (By default do nothing)
		do
		end

end
