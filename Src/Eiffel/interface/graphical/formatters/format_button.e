indexing

	description:
		"Abstract notion of a tool button."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_BUTTON

inherit
	EB_BUTTON
		rename
			associated_command as associated_format
		redefine
			make, associated_format
		end;
	WINDOWS;
	HOLE
		redefine
			receive, registered, compatible
		end;

create
	make

feature {NONE} -- Initialization

	make (a_format: FORMATTER; a_parent: COMPOSITE) is
		do
			associated_format := a_format;
			button_make (button_name, a_parent);
			init_button (implementation);
			set_symbol (a_format.symbol);
			add_activate_action (a_format, a_format.tool);
			set_focus_string (associated_format.name)
			initialize_focus 
		end;

feature -- Access

	registered: BOOLEAN is
			-- Always registered
		do
			Result := True
		end;

	compatible (a_stone: STONE): BOOLEAN is
			-- Is the hole compatible with `a_stone'
		local
			tool: TOOL_W;
		do
			tool := associated_format.tool;
			Result := (tool.stone_type = a_stone.stone_type)
		end;

	stone_type: INTEGER is
		do
		end;

	target: WIDGET is
			-- Target of the hole is Current
		do
			Result := Current
		end

feature -- Status Setting

	set_selected (b: BOOLEAN) is
			-- Darken the symbol of current button if `b', lighten it otherwise.
		do
			if b /= is_pressed then
				set_pressed (b)
			end
		end;

feature -- Update

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'.
		local
			tool: TOOL_W;
			bar_and_text: BAR_AND_TEXT
		do
			if compatible (a_stone) then
				tool := associated_format.tool;
				if tool.text_window.changed then
					bar_and_text ?= tool;
					bar_and_text.showtext_frmt_holder.execute (tool.stone)
				else
					tool.set_stone (Void);
					tool.set_last_format (associated_format.holder);
						-- Propagate receiption to `associated_format'.
					tool.receive (a_stone)
				end
			end
		end;

feature {NONE} -- Properties

	associated_format: FORMATTER;
			-- Associated format

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

end -- class FORMAT_BUTTON
