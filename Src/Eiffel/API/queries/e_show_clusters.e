indexing

	description:
		"Command to show the universe: clusters in class lists."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTERS

inherit
	E_SHOW_CLUSTER_HIERARCHY
		redefine
			is_folder_hierarchy_displayed,
			work
		end

create

	make, do_nothing

feature -- Status report

	is_folder_hierarchy_displayed: BOOLEAN is
			-- Is folder hierarchy displayed?
			-- e.g., should we display folders in a cluster?
		do
			Result := False
		end

feature -- Execution

	work is
			-- Show clusters in universe.
		local
			l_creators: LIST [SYSTEM_ROOT]
			cs: CURSOR
		do
			text_formatter.add (output_interface_names.root_class)
			text_formatter.add (output_interface_names.colon)
			text_formatter.add_space
			from
				l_creators := eiffel_system.system.root_creators
				cs := l_creators.cursor
				l_creators.start
			until
				l_creators.after
			loop
				l_creators.item_for_iteration.root_class.compiled_class.append_signature (text_formatter, True)
				text_formatter.add_new_line
				l_creators.forth
			end
			l_creators.go_to (cs)
			text_formatter.add_new_line
			text_formatter.add_new_line
			Precursor
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

end -- class E_SHOW_CLUSTERS
