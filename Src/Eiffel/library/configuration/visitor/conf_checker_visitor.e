indexing
	description: "Check if renamings, options and visiblities are done on valid classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CHECKER_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		redefine
			process_group
		end

	CONF_ACCESS

create
	make

feature -- Visit nodes

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		local
			l_ren: CONF_HASH_TABLE [STRING, STRING]
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_c_opt: HASH_TABLE [CONF_OPTION, STRING]
			l_found: BOOLEAN
		do
			l_classes := a_group.classes
			check
				l_classes_not_void: l_classes /= Void
			end

				-- check renamings
			l_ren := a_group.renaming
			if l_ren /= Void then
				from
					l_ren.start
				until
					l_ren.after
				loop
					if not l_classes.has (l_ren.item_for_iteration) or else not l_classes.found_item.name.is_equal (l_ren.key_for_iteration) then
						add_error (create {CONF_ERROR_RENAM}.make (l_ren.key_for_iteration))
					end
					l_ren.forth
				end
			end
				-- check class options
			l_c_opt := a_group.class_options
			if l_c_opt /= Void then
				from
					l_c_opt.start
				until
					l_c_opt.after
				loop
					from
						l_classes.start
					until
						l_found or l_classes.after
					loop
						l_found := l_classes.item_for_iteration.name.is_equal (l_c_opt.key_for_iteration)
						l_classes.forth
					end
					if not l_found then
						add_error (create {CONF_ERROR_CLOPT}.make (l_c_opt.key_for_iteration))
					end
					l_c_opt.forth
				end
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
end
