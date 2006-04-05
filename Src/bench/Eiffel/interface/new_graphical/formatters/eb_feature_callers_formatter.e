indexing
	description: "Command to display the routines clients."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_CALLERS_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, make
		end
	EB_FEATURE_TOOL_DATA
	NEW_EB_CONSTANTS

create

	make
	
feature -- Initialization

	make (a_tool: like tool) is
		do
			Precursor {EB_FILTERABLE} (a_tool)
			to_show_all_callers :=
				show_all_callers
		end

feature -- Properties

	to_show_all_callers: BOOLEAN
			-- Is the format going to show all callers?

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showcallers 
		end
 
feature -- Executions

feature -- Status setting

	set_show_all_callers (b: BOOLEAN) is
			-- Set `to_show_all_callers' to `b'
		do
			to_show_all_callers := b
		ensure
			set: to_show_all_callers = b
		end

feature {NONE} -- Properties

	name: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.f_Showallcallers
			else
				Result := Interface_names.f_Showcallers
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			if to_show_all_callers then
				Result := Interface_names.m_Showallcallers
			else
				Result := Interface_names.m_Showcallers
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			if to_show_all_callers then
				Result := Interface_names.t_All_callers
			else
				Result := Interface_names.t_Callers
			end
		end

	post_fix: STRING is "fcl"

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display Senders of `f`.
		local
			cmd: E_SHOW_CALLERS
		do
			create cmd.make (f.e_feature)
			if to_show_all_callers then
				cmd.set_all_callers
			end
			if cmd.has_valid_feature then
				cmd.execute
				Result := cmd.structured_text
			end
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for callers...")
		end

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

end -- class EB_FEATURE_CALLERS_FORMATTER
