indexing

	description:
		"Command to display the system statistics."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_STATISTICS

inherit
	E_OUTPUT_CMD

	SHARED_EIFFEL_PROJECT

create

	make, do_nothing

feature -- Execution

	work is
			-- Show system statistics.
		local
			stats: SYSTEM_STATISTICS
			l_number: INTEGER
		do
			if Eiffel_project.initialized then
				stats := Eiffel_system.statistics

				text_formatter.add (output_interface_names.for_system)
				text_formatter.add_space
				text_formatter.add (eiffel_universe.target.name)
				text_formatter.add_new_line
				text_formatter.add (output_interface_names.long_separator)
				text_formatter.add_new_line

					-- Number of compilations
				text_formatter.add_int (stats.number_of_compilations)
				text_formatter.add_indent
				if stats.number_of_compilations = 1 then
					text_formatter.add (output_interface_names.compilation_for_system)
				else
					text_formatter.add (output_interface_names.compilations_for_system)
				end
				text_formatter.add_new_line

					-- Number of clusters
				l_number := stats.number_of_clusters
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				if l_number > 1 then
					text_formatter.add (output_interface_names.clusters_in_system)
				else
					text_formatter.add (output_interface_names.cluster_in_system)
				end
				text_formatter.add_new_line

					-- Number of libraries
				l_number := stats.number_of_libraries
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				if l_number > 1 then
					text_formatter.add (output_interface_names.libraries_in_system)
				else
					text_formatter.add (output_interface_names.library_in_system)
				end
				text_formatter.add_new_line

					-- Number of assemblies
				l_number := stats.number_of_assemblies
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				if l_number > 1 then
					text_formatter.add (output_interface_names.assemblies_in_system)
				else
					text_formatter.add (output_interface_names.assembly_in_system)
				end
				text_formatter.add_new_line

					-- Number of classes
				l_number := stats.number_of_classes
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				text_formatter.add (output_interface_names.classes_in_system)
				text_formatter.add_new_line

					-- Number of existing classes
				l_number := stats.number_of_used_classes
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				text_formatter.add (output_interface_names.all_classes)
				text_formatter.add_new_line

					-- Number of compiled classes
				l_number := stats.number_of_compiled_classes
				text_formatter.add_int (l_number)
				text_formatter.add_indent
				text_formatter.add (output_interface_names.compiled)
				text_formatter.add_space
				if l_number > 1 then
					text_formatter.add (output_interface_names.classes_in_universe)
				else
					text_formatter.add (output_interface_names.class_in_universe)
				end
				text_formatter.add_new_line

					-- Number of melted classes
				text_formatter.add_int (stats.number_of_melted_classes)
				text_formatter.add_indent
				text_formatter.add (output_interface_names.melted)
				text_formatter.add_space
				if stats.number_of_melted_classes = 1 then
					text_formatter.add (output_interface_names.classes_in_universe)
				else
					text_formatter.add (output_interface_names.class_in_universe)
				end
				text_formatter.add_new_line
			end
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

end -- class E_SHOW_STATISTICS
