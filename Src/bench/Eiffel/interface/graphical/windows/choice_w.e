indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

	desciption: "Window where the user can make choice.";
	date: "$Date$";
	revision: "$Revision$"

class

	CHOICE_W

inherit

	FORM_D
		rename
			make as fd_make,
			popup as fd_popup,
			popdown as fd_popdown
		end;

	COMMAND_W
		redefine
			execute
		end;

	NAMER;

	WINDOW_ATTRIBUTES

create

	make, make_with_widget

feature -- Initialization

	make (a_parent: COMPOSITE) is
			-- Make a choice window.
		do
			fd_make ("Choice Window", a_parent);
			set_title ("Choice Window");
			create list.make (new_name, Current);
			create exit_b.make (Interface_names.b_Cancel, Current);
			set_fraction_base (3);
			attach_top (list, 0);
			attach_left (list, 0);
			attach_right (list, 0);
			attach_bottom_widget (exit_b, list, 5);
			attach_left_position (exit_b, 1);
			attach_right_position (exit_b, 2);
			attach_bottom (exit_b, 5);
			allow_resize;
			set_exclusive_grab;
			list.add_click_action (Current, Void);
			exit_b.add_activate_action (Current, exit_b);
			set_composite_attributes (Current);
			set_default_position (False);
				-- When user closes via the window manager close button
			set_parent_action ("<Unmap>,<Prop>", Current, exit_b);
			realize;
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

	popup (command: COMMAND; name_list: LIST [STRING]; a_title: STRING) is
			-- Fill the choice window with `name_list' and
			-- pop it up at the pointer position.
		require
			valid_args: command /= Void and then 
					name_list /= Void and then
					a_title /= Void
		local
			str: SCROLLABLE_LIST_STRING_ELEMENT
			new_width: INTEGER
		do
			caller := command;
			list.wipe_out;
			create str.make (0);
			from
				name_list.start
			until
				name_list.after
			loop
				create str.make (0);
				str.append (name_list.item);
				new_width := new_width.max (name_list.item.count)
				list.extend (str);
				name_list.forth
			end
			if list.count >= 15 then
				list.set_visible_item_count (15);
			elseif list.count > 0 then
				list.set_visible_item_count (list.count);
			else
				list.set_visible_item_count (1);
			end;
			
			set_width ((150).max (new_width * 10));
			set_title (a_title);
			display
		end;

	popdown is
			-- Popdown the window.
		do
			caller := Void;
			fd_popdown
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
			if caller /= Void then
				if argument = exit_b then
					list.deselect_all;
				end;
				caller.execute (Current);
				popdown
			end
		end;

	select_i_th (i: INTEGER) is
			-- Select item at the `i'-th position.
		do
			if i <= list.count and then i > 0 then
				list.select_i_th (i)
			end
		end;

feature {NONE} -- Properties

	list: SCROLLABLE_LIST;

	exit_b: PUSH_B;	
			-- Exit button

	caller: COMMAND;
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
		local
			x1, y1: INTEGER;
			a_widget: WIDGET
		do
			--realize;
			if map_widget /= Void then
				x1 := map_widget.real_x;
				y1 := map_widget.real_y;
			else
				a_widget := parent;
                x1 := a_widget.real_x + (a_widget.width - width) // 2;
                y1 := a_widget.real_y + (height // 2)
			end;
			set_x_y (x1, y1);
			fd_popup;
			if real_x + width > screen.width then
				set_x (screen.width - width)
			elseif real_x < 0 then
				set_x (0)
			end;
			if real_y + height > screen.height then
				set_y (screen.height - height)
			elseif real_y < 0 then
				set_y (0)
			end;
		end;

invariant

	list_exists: list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CHOICE_W
