indexing

	description:	
		"Command to display the routines clients."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUTCLIENTS

inherit

	FILTERABLE
		rename
			execute as old_execute	
		redefine
			display_temp_header, make
		end;
	FILTERABLE
		redefine
			display_temp_header, execute, make
		select
			execute
		end;
	CUSTOM_CALLER;
	EB_CONSTANTS

create

	make
	
feature -- Initialization

	make (a_tool: TOOL_W) is
		do
			tool := a_tool;
			to_show_all_callers :=
				Feature_resources.show_all_callers.actual_value
		end;

feature -- Properties

	to_show_all_callers: BOOLEAN;
			-- Is the format going to show all callers?

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showcallers 
		end;
 
feature -- Executions

	execute_apply_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when apply button is activated
		do
			if a_cust_tool.is_first_option_selected = to_show_all_callers then
				to_show_all_callers := not a_cust_tool.is_first_option_selected;
				if tool.last_format.associated_command = Current then
					tool.synchronize
				end
			end
		end;	

	execute_ok_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when save button is activated
		do
			execute_apply_action (a_cust_tool);
			Feature_resources.show_all_callers.set_actual_value 
					(to_show_all_callers)
		end;

	execute (arg: ANY) is
			-- Execute the format.
		local
			rcw: ROUTINE_CUSTOM_W
		do
			if arg = button_three_action then
				rcw := routine_custom_window (popup_parent);
				rcw.set_window (popup_parent);
				rcw.call (Current, 
						Interface_names.l_Showcallers, 	
						Interface_names.l_Showallcallers,
						not to_show_all_callers)
			else
				old_execute (arg)
			end
		end

feature -- Status setting

	set_show_all_callers (b: BOOLEAN) is
			-- Set `to_show_all_callers' to `b'
		do
			to_show_all_callers := b
		ensure
			set: to_show_all_callers = b
		end;

feature {NONE} -- Properties

	associated_custom_tool: ROUTINE_CUSTOM_W is
			-- Associated custom tool
			-- (Used for type checking and system validity)
		do
		end;	   

	name: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.f_Showallcallers
			else
				Result := Interface_names.f_Showcallers
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			if to_show_all_callers then
				Result := Interface_names.m_Showallcallers
			else
				Result := Interface_names.m_Showcallers
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.t_All_callers
			else
				Result := Interface_names.t_Callers
			end
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display Senders of `f`.
		local
			cmd: E_SHOW_CALLERS
		do
			create cmd.make (f.e_feature);
			if to_show_all_callers then
				cmd.set_all_callers;
			end;
			if cmd.has_valid_feature then
				cmd.execute;
				Result := cmd.structured_text
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for callers...")
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

end -- class SHOW_ROUTCLIENTS
