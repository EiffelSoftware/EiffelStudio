indexing
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

create
	make

feature -- Status

	is_override: BOOLEAN is
			-- Is this an override?
		once
			Result := True
		end


feature -- Access, stored in configuration file

	override: ARRAYED_LIST [CONF_GROUP]
			-- The groups that this cluster overrides.
			-- override.is_empty => overrides everything

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_override (an_override: like override) is
			-- Set `override' to `an_override'.
		require
			an_override_not_void: an_override /= Void
		do
			override := an_override
		ensure
			override_set: override = an_override
		end

	add_override (a_group: CONF_GROUP) is
			-- Add an override.
		require
			a_group_not_void: a_group /= Void
		do
			if override = Void then
				create override.make (1)
			end
			override.extend (a_group)
		end


feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal_override (override, other.override)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
			a_visitor.process_override (Current)
		end

feature {NONE} -- Implementation

	equal_override (a, b: like override): BOOLEAN is
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
