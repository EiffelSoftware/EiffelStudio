indexing
 
	description:
		"A String resource with an edit field."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"
 
class COLOR_PREF_RES
 
inherit
	STRING_PREF_RES
		rename
			init as string_init,
			execute as string_execute
		redefine
			associated_resource
		end
	STRING_PREF_RES
		redefine
			associated_resource, init, execute
		select
			init, execute
		end;
	EB_CONSTANTS

create
	make

feature -- Execution
 
	execute (arg: ANY) is
			-- Execute command.
		do
			if arg = color_action then
				popup_color_box
			elseif arg = color_box then
				if color_box.position /= 0 then
					text.set_text (color_box.selected_item)
				end;
				color_box.popdown
			else
				string_execute (arg)
			end
		end;
 
feature {NONE} -- Properties
 
	associated_resource: COLOR_RESOURCE;
			-- Resource Current represnts

feature {NONE} -- Initialization

	init (a_parent: COMPOSITE) is
			-- Initialize the color resouce.
		do
			string_init (a_parent);
			text.remove_activate_action (Current, Void);
			text.add_button_press_action (3, Current, color_action);
		end;

	color_action: ANY is
		once
			create Result
		end;

	color_box: CHOICE_W is
			-- Color box dialog
		once
			create Result.make (text.top);
		end;

	popup_color_box is
			-- Popup the font box.
		local
			new_x, new_y: INTEGER;
			p: COMPOSITE;
			mp: MOUSE_PTR;	
			list: LINKED_LIST [STRING];
			c_array: ARRAY [STRING];
			i: INTEGER
		do	
			create mp.set_watch_cursor;
			p := color_box.parent;
			new_x := p.x + (p.width - color_box.width) // 2;
			new_y := p.y + (p.height - color_box.height) // 2;
			if new_x + color_box.width > color_box.screen.width then
				new_x := color_box.screen.width - width
			elseif new_x < 0 then
				new_x := 0
			end;
			if new_y + color_box.height > color_box.screen.height then
				new_y := color_box.screen.height - color_box.height
			elseif new_y < 0 then
				new_y := 0
			end;
			color_box.set_x_y (new_x, new_y);
			mp.restore;
			c_array := General_resources.color_list.actual_value;
			from
				create list.make;
				i := 1
			until
				i > c_array.count
			loop
				list.extend (c_array.item (i));
				i := i + 1 
			end;
			color_box.popup (Current, list, Interface_names.t_Select_color)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class COLOR_PREF_RES
