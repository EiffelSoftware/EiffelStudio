note

	description: "Abstract node for alternative values of a multi-branch instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INTERVAL_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like lower; u: like upper; d_as: like dotdot_symbol)
			-- Create a new INTERVAL AST node.
		require
			l_not_void: l /= Void
		do
			lower := l
			upper := u
			dotdot_symbol := d_as
		ensure
			lower_set: lower = l
			upper_set: upper = u
			dotdot_symbol_set: dotdot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_interval_as (Current)
		end

feature -- Roundtrip

	dotdot_symbol: detachable SYMBOL_AS
			-- Symbol ".." associated with this structure.

	index: INTEGER
			-- <Precursor>
		do
			if attached dotdot_symbol as s then
				Result := s.index
			else
				Result := lower.index
			end
		end

feature -- Attributes

	lower: ATOMIC_AS
			-- Lower bound.

	upper: detachable ATOMIC_AS
			-- Upper bound.
			-- Void if constant rather than interval.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := lower.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached upper as l_upper then
				Result := l_upper.last_token (a_list)
			else
				Result := lower.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (lower, other.lower) and
				equivalent (upper, other.upper)
		end

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower)
			-- Set `lower' to `l'.
		require
			l_not_void: l /= Void
		do
			lower := l
		end

	set_upper (u: like upper)
			-- Set `upper' to `u'.
		do
			upper := u
		end

invariant
	lower_not_void: lower /= Void

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
