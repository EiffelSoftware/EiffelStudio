indexing

	description:	
		"Command to display the history of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PAST

inherit

	FILTERABLE
		redefine
			display_temp_header
		end;
	SHARED_SERVER

create

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showaversions 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showpast
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showpast
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Past
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display history of `f'.
		local
			cmd: E_SHOW_ROUTINE_ANCESTORS;
		do
			create cmd.make (f.e_feature);
			if cmd.has_valid_feature then
				cmd.execute;
				Result := cmd.structured_text
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for ancestor versions...")
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

end -- class SHOW_PAST
