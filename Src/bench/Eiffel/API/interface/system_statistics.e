indexing

	description:
		"General information about the Eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_STATISTICS

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end;
	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make,
	make_compilation_stat

feature {NONE} -- Initialization

	make is
			-- Initialize statistical information.
		require
			project_inititalized: Eiffel_project.initialized
		do
			number_of_classes := Eiffel_system.number_of_classes;
			number_of_melted_classes := System.degree_minus_1.count;
			number_of_compilations := Workbench.compilation_counter - 1;
--			number_of_clusters := Eiffel_universe.clusters.count;
		end;

	make_compilation_stat is
			-- Initailize `number_of_compilations'
		do
			number_of_compilations := Workbench.compilation_counter
		end

feature -- Access

	number_of_classes: INTEGER
			-- Total number of compiled classes in the system

	number_of_clusters: INTEGER
			-- Total number of clusters in the system

	number_of_melted_classes: INTEGER
			-- Number of melted classes in the system

	number_of_compilations: INTEGER;
			-- Number of melted classes in the system

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

end -- class SYSTEM_STATISTICS
