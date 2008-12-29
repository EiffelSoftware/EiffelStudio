note
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

	execute
			-- Dump class information.
		do
			dump_cluster (Universe.all_classes)
		end

	dump_cluster (cs: DS_HASH_SET [CLASS_I])
			-- Recursive function called by `execute'.
		local
			l_class: CLASS_I
		do
			from
				cs.start
			until
				cs.after
			loop
				l_class := cs.item_for_iteration
				if
					l_class /= Void and then
					l_class.is_compiled and then
					not l_class.compiled_class.is_deferred and then
					l_class.compiled_class.allows_default_creation
				then
					print (l_class.name + "%N")
				end
				cs.forth
			end
		end

note
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
