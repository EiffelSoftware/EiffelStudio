indexing
	description:
			"Abstract description of a nested call `target.message' %
			%Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_AS

inherit
	CALL_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; m: like message; d_as: like dot_symbol) is
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
			dot_symbol := d_as
		ensure
			target_set: target = t
			message_set: message = m
			dot_symbol_set: dot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_nested_as (Current)
		end

feature -- Roundtrip

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

feature -- Attributes

	target: ACCESS_AS
			-- Target of the call

	message: CALL_AS
			-- Message send to the target

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := target.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := message.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

feature {NESTED_AS} -- Replication

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

	set_message (m: like message) is
		require
			valid_arg: m /= Void
		do
			message := m
		end

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class NESTED_AS
