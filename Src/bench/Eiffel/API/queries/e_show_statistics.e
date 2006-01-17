indexing

	description: 
		"Command to display the system statistics."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_STATISTICS

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

create

	make, do_nothing

feature -- Execution

	work is
			-- Show system statistics.
		local
			stats: SYSTEM_STATISTICS
		do
			if Eiffel_project.initialized then
				stats := Eiffel_system.statistics;
				structured_text.add_int (stats.number_of_compilations);
				if stats.number_of_compilations = 1 then
					structured_text.add_string (" compilation for system.")
				else
					structured_text.add_string (" compilations for system.")
				end;
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_clusters);
				structured_text.add_string (" clusters in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_classes);
				structured_text.add_string (" classes in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_melted_classes);
				if stats.number_of_melted_classes = 1 then
					structured_text.add_string (" melted class in the system.");
				else
					structured_text.add_string (" melted classes in the system.");
				end
				structured_text.add_new_line;
			end
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

end -- class E_SHOW_STATISTICS
