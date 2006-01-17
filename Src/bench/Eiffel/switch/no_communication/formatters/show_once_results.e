indexing

	description:	
		"Command to display results (if any) of once %
		%functions relevant to a given object."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SHOW_ONCE_RESULTS 

inherit
	FILTERABLE
		redefine
			display_temp_header
		end

	SHARED_APPLICATION_EXECUTION

create

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showonces 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showoncefunc
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showoncefunc
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Oncefunc_of
		end;

	criterium (f: E_FEATURE): BOOLEAN is
			-- `f' is a once function and `f' is written in a descendant of ANY
			-- or the object is a direct instance of a parent of ANY
		require
			f_exists: f /= Void
		do
			Result := f.is_once and f.is_function
		end;

	create_structured_text (object: OBJECT_STONE): STRUCTURED_TEXT is
		do
			create Result.make;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Finding values of once functions...")
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

end -- class SHOW_ONCE_RESULTS
