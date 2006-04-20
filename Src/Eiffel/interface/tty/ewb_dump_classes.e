indexing
	description:
		"Dumps compiled non deferred classed with `default_create' to stdout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EWB_DUMP_CLASSES

inherit

	EWB_CMD
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

	SHARED_WORKBENCH

create
	default_create

feature

	execute is
			-- Dump class information.
		do
--			dump_cluster (Universe.clusters)
		end

	dump_cluster (cs: LINEAR [CLUSTER_I]) is
			-- Recursive function called by `execute'.
		local
			l: LINEAR [CLASS_I]
			s: STRING
		do
			from
				cs.start
			until
				cs.after
			loop
				if cs.item.sub_clusters /= Void then
					dump_cluster (cs.item.sub_clusters)
				end
				if cs.item.classes /= Void then
					from
						l := cs.item.classes.linear_representation
						l.start
					until
						l.after
					loop
						if
							l.item.is_compiled and
							not l.item.compiled_class.is_deferred and
							l.item.compiled_class.creators.has ("default_create")
						then
							s := l.item.name
							s.to_upper
							print (s + "%N")
						end
						l.forth
					end
				end
				cs.forth
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

end -- class EWB_DUMP_CLASSES
