indexing

	description:
		"Notion of a command associated with an EB_BUTTON_HOLE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DEFAULT_HOLE_COMMAND

inherit
	HOLE_COMMAND
		redefine
			init_other_button_actions, receive,
			transported_stone
		end

create

	make

feature -- Initialization

	init_other_button_actions (a_button: EB_BUTTON_HOLE) is
			-- Initialize other button actions
		do
			a_button.set_action ("c<Btn3Down>", 
				Current, control_button_three_action);
			a_button.set_action ("Shift<Btn3Down>", 
				Current, shift_button_three_action);
		end;

feature -- Access

	stone_type: INTEGER is
		do
		end;

	transported_stone: STONE is
		do
			Result := tool.stone
		end;

	symbol: PIXMAP is
			-- Pixmap for the button
		do
		end

	name: STRING is
			-- Name of hole
		do
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature -- Execution

	work (argument: ANY) is
		local
			ts: STONE;
			new_tool: TOOL_W;
		do
			if argument = control_button_three_action then
				ts := tool.stone;
				if ts /= Void then
					Project_tool.receive (ts)
				end
			elseif argument = shift_button_three_action then
--Arnaud 	create super_melt_cmd.make (tool);
--Arnaud	super_melt_cmd.work (Void)
			elseif tool = Project_tool then
				inspect 
					stone_type
				when Class_type then
					new_tool := window_manager.class_window
				when Routine_type then
					new_tool := window_manager.routine_window
				when Object_type then
					new_tool := window_manager.object_window
				when Explain_type then
					new_tool := window_manager.explain_window
				when System_type then
					new_tool := system_tool;
				when Dynamic_lib_type then
					new_tool := dynamic_lib_tool;
				end;
				if new_tool /= Void then
					new_tool.display
				end
			else
				ts := tool.stone;
				if ts /= Void then
					tool.synchronize
				end
			end
		end;

feature -- Update

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'
		do
			if compatible (a_stone) then
				if a_stone.is_valid then
					tool.receive (a_stone)
				else
					a_stone.process (Current)
				end
			end
		end;

feature {NONE} -- Implementation

	control_button_three_action: ANY is
			-- Action to specify that the control third button was pressed
		once
			create Result
		end;

	shift_button_three_action: ANY is
			-- Action to specify that the shift third button was pressed
		once
			create Result
		end;

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

end -- class DEFAULT_HOLE_COMMAND
