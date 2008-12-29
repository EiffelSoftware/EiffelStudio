note
	description: "[
			Virtual group like a library or an assembly that only provides access to classes in another group.
			Virtual groups also allow renamings/prefixing of the classes they give access to.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VIRTUAL_GROUP

inherit
	CONF_GROUP

feature -- Access, stored in configuration file

	renaming: EQUALITY_HASH_TABLE [STRING, STRING]
			-- Mapping of renamed classes from the old name to the new name.

	renaming_32: EQUALITY_HASH_TABLE [STRING_32, STRING_32]
			-- Same as `renaming' but with STRING_32.
		local
			l_renaming: like renaming
		do
			l_renaming := renaming
			if l_renaming /= Void then
				create Result.make (l_renaming.count)
				from
					l_renaming.start
				until
					l_renaming.after
				loop
					Result.extend (l_renaming.item_for_iteration, l_renaming.key_for_iteration)
					l_renaming.forth
				end
			end
		end

	name_prefix: STRING
			-- An optional name prefix for this group.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name_prefix (a_name_prefix: like name_prefix)
			-- Set `name_prefix' to `a_name_prefix'.
		do
			name_prefix := a_name_prefix
			if name_prefix /= Void then
				name_prefix.to_upper
			end
		ensure
			name_prefix_set: name_prefix = a_name_prefix
		end

	set_renaming (a_renaming: like renaming)
			-- Set `renaming' to `a_renaming'.
		do
			renaming := a_renaming
		ensure
			renaming_set: renaming = a_renaming
		end

	set_renaming_32 (a_renaming_32: like renaming_32)
			-- Set `renaming_32' to `a_renaming_32'.
		do
			if a_renaming_32 = Void then
				renaming := Void
			else
				create renaming.make (a_renaming_32.count)
				from
					a_renaming_32.start
				until
					a_renaming_32.after
				loop
					renaming.extend (a_renaming_32.item_for_iteration, a_renaming_32.key_for_iteration)
					a_renaming_32.forth
				end
			end
		end

	add_renaming (an_old_name, a_new_name: STRING)
			-- Add a renaming.
		require
			an_old_name_ok: an_old_name /= Void and then not an_old_name.is_empty
			an_old_name_upper: an_old_name.is_equal (an_old_name.as_upper)
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
			a_new_name_upper: a_new_name.is_equal (a_new_name.as_upper)
		do
			if renaming = Void then
				create renaming.make (1)
			end
			renaming.force (a_new_name, an_old_name)
		ensure
			added: renaming.has (an_old_name) and then renaming.item (an_old_name) = a_new_name
		end

invariant
	name_prefix_upper: name_prefix /= Void implies name_prefix.is_equal (name_prefix.as_upper)

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
end
