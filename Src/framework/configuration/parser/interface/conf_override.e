note
	description: "Clusters that override other groups."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_OVERRIDE

inherit
	CONF_CLUSTER
		redefine
			process, is_group_equivalent,
			is_override
		end

create {CONF_PARSE_FACTORY}
	make

feature -- Status

	is_override: BOOLEAN
			-- Is this an override?
		once
			Result := True
		end

feature -- Access, stored in configuration file

	override: detachable ARRAYED_LIST [CONF_GROUP]
			-- The groups that this cluster overrides.
			-- override.is_empty => overrides everything

	override_group_names: detachable ARRAYED_LIST [like {CONF_GROUP}.name]
			-- The group names that this cluster overrides.
			-- To be expanded in `override`.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_override (an_override: like override)
			-- Set `override' to `an_override'.
		do
			override := an_override
			if an_override = Void or else an_override.is_empty then
				override_group_names := Void
			end
		ensure
			override_set: override = an_override
		end

	add_override (a_group: CONF_GROUP)
			-- Add an override.
		require
			a_group_not_void: a_group /= Void
		local
			l_override: like override
		do
			l_override := override
			if l_override = Void then
				create l_override.make (1)
				override := l_override
			end
			l_override.extend (a_group)
		end

	add_override_group_name (a_group_name: READABLE_STRING_32)
			-- Add override group named `a_group_name` to the `override_group_names`.
		require
			a_group_not_void: a_group_name /= Void
		local
			l_override: like override_group_names
		do
			l_override := override_group_names
			if l_override = Void then
				create l_override.make (1)
				override_group_names := l_override
			end
			l_override.extend (a_group_name)
		end

	reset_override_group_names
		do
			override_group_names := Void
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal_override (override, other.override)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_override (Current)
		end

feature {NONE} -- Implementation

	equal_override (a, b: like override): BOOLEAN
			-- Are `a' and `b' equal?
		do
			if a = b then
				Result := True
			end
			if not Result and a /= Void and b /= Void then
				from
					Result := True
					a.start
					b.start
				until
					not Result or a.after or b.after
				loop
					Result := equal (a.item.name, b.item.name)
					a.forth
					b.forth
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
