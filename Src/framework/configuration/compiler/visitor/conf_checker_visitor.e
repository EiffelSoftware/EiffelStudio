note
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

	CONF_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Visit nodes

	process_group (a_group: CONF_GROUP)
			-- Visit `a_group'.
		local
			l_name: READABLE_STRING_GENERAL
			l_map: STRING_TABLE [READABLE_STRING_32]
			l_options: CONF_OPTION
		do
			if attached a_group.classes as l_classes then
				l_map := a_group.mapping
				l_options := a_group.options
					-- Check renamings.
				if
					l_options.is_warning_enabled (w_renaming_unknown_class) and then
					attached {CONF_VIRTUAL_GROUP} a_group as l_vg and then
					attached l_vg.renaming as l_ren
				then
					across
						l_ren as r
					loop
						l_name := r.key
							-- do not use mapping because renaming already deals with changing names in the system,
							-- also applying mapping would make things too confusing
						if not attached l_classes.item (r.item) as l_found_ren_item or else not l_found_ren_item.name.same_string_general (l_name) then
							add_error (create {CONF_ERROR_RENAM}.make (l_name, a_group.target.system.file_name))
						end
					end
				end
					-- Check class options.
				if
					l_options.is_warning_enabled (w_option_unknown_class) and then
					attached a_group.internal_class_options as l_c_opt
				then
					across
						l_c_opt as o
					loop
						l_name := o.key
						if attached l_map.item (l_name) as l_found_name then
							l_name := l_found_name
						end
						if not o.item.is_empty and then not l_classes.has (l_name) then
							add_error (create {CONF_ERROR_CLOPT}.make (l_name, a_group.target.system.file_name))
						end
					end
				end
			else
					-- FIXME: it seems it could be Void, if the group is empty!
				check
					l_classes_not_void: False
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
