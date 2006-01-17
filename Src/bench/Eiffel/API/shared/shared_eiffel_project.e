indexing

	description: 
		"Shared instance of an eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_EIFFEL_PROJECT

feature -- Access

	Eiffel_project: E_PROJECT is
		once
			create Result
		end	

	Eiffel_ace: E_ACE is
			-- Eiffel system
		require
			initialized: Eiffel_project.initialized
		once
			Result := Eiffel_project.ace
		ensure
			result_is_set: Result = Eiffel_project.ace;
			result_is_not_void: Result /= Void
		end;
	
	Eiffel_dynamic_lib: E_DYNAMIC_LIB is
		require
			initialized: Eiffel_project.initialized
		do
			Result := Eiffel_project.dynamic_lib
		ensure
			result_is_set: Result = Eiffel_project.dynamic_lib
		end;

	Eiffel_system: E_SYSTEM is
			-- Eiffel system
		require
			initialized: Eiffel_project.initialized
			defined: Eiffel_project.system_defined
		once
			Result := Eiffel_project.system
		ensure
			result_is_set: Result = Eiffel_project.system;
			result_is_not_void: Result /= Void
		end;

	Eiffel_universe: UNIVERSE_I is
			-- Eiffel project universe
		require
			initialized: Eiffel_project.initialized
		once
			Result := Eiffel_project.universe
		ensure
			result_is_set: Result = Eiffel_project.universe;
			result_is_not_void: Result /= Void
		end;

feature {NONE} -- Implementation

	Degree_output: DEGREE_OUTPUT is
			-- Degree output for Eiffel project
		do
			Result := Eiffel_project.degree_output
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

end -- class SHARED_EIFFEL_PROJECT
