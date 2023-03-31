note
	description: "A group of classes that can be renamed."

deferred class
	CONF_RENAMING_GROUP

inherit
	CONF_NAMED_GROUP

feature -- Access, stored in configuration file

	renaming: detachable STRING_TABLE [READABLE_STRING_32]
			-- Mapping of renamed classes from the old name to the new name.

	name_prefix: detachable READABLE_STRING_32
			-- An optional name prefix for this group.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name_prefix (a_name_prefix: like name_prefix)
			-- Set `name_prefix' to `a_name_prefix'.
		local
			np: STRING_32
		do
			if a_name_prefix /= Void then
				create np.make_from_string (a_name_prefix)
					--| FIXME: check if this is expected to upper the argument.
				np.to_upper
				name_prefix := np
			else
				name_prefix := Void
			end
		ensure
			name_prefix_unset: ¬ attached a_name_prefix ⇒ ¬ attached name_prefix
			name_prefix_set: attached a_name_prefix ⇒
				attached name_prefix as p ∧… p.is_case_insensitive_equal (a_name_prefix)
		end

	set_renaming (a_renaming: like renaming)
			-- Set `renaming' to `a_renaming'.
		do
			renaming := a_renaming
		ensure
			renaming_set: renaming = a_renaming
		end

	add_renaming (an_old_name: READABLE_STRING_GENERAL; a_new_name: READABLE_STRING_32)
			-- Add a renaming.
		require
			an_old_name_ok: an_old_name /= Void and then not an_old_name.is_empty
			an_old_name_upper: an_old_name.same_string (an_old_name.as_upper)
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
			a_new_name_upper: a_new_name.same_string (a_new_name.as_upper)
		local
			l_renaming: like renaming
		do
			l_renaming := renaming
			if l_renaming = Void then
				create l_renaming.make_equal (1)
				renaming := l_renaming
			end
			l_renaming.force (a_new_name, an_old_name)
		ensure
			renaming_attached: attached renaming as el_renaming
			added: el_renaming.has (an_old_name) and then el_renaming.item (an_old_name) = a_new_name
		end

invariant
	name_prefix_upper: attached name_prefix as p ⇒  p.same_string (p.as_upper)

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
