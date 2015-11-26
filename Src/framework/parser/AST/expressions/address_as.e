note
	description: "AST representation of an Eiffel function pointer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_AS

inherit
	EXPR_AS
	ID_SET_ACCESSOR

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name; a_as: like address_symbol)
			-- Create a new ADDRESS AST node.
		require
			f_not_void: f /= Void
		do
			make_id_set
			feature_name := f
			if a_as /= Void then
				address_symbol_index := a_as.index
			end
		ensure
			feature_name_set: feature_name = f
			address_symbol_set: a_as /= Void implies address_symbol_index = a_as.index
			no_routine_id: routine_ids.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_address_as (Current)
		end

feature -- Roundtrip

	address_symbol_index: INTEGER
			-- Index of symbol "$" associated with this structure.

	address_symbol (a_list: detachable LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "[" associated with this structure
		local
			i: INTEGER
		do
			if a_list /= Void then
				i := address_symbol_index
				if
					a_list.valid_index (i) and then
					attached {like address_symbol} a_list.i_th (i) as l_result
				then
					Result := l_result
				end
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := address_symbol_index
		end

feature -- Attributes

	feature_name: FEATURE_NAME
			-- Feature name to address

	is_qualified: BOOLEAN
			-- Is current entity a call on an other object?
		do
			Result := not (is_local or is_argument)
		end

	is_local: BOOLEAN
			-- Is current entity a local?

	is_argument: BOOLEAN
			-- Is the current entity an argument?

	is_object_test_local: BOOLEAN
			-- Is current entity an object test local?

	argument_position: INTEGER
			-- If the current entity is an argument this gives the position in the argument list.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := address_symbol (a_list)
			if Result = Void then
				Result := feature_name.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := feature_name.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name)
		end

feature -- Setting

	set_argument_position (an_argument_position: like argument_position)
			-- Set `argument_position' to `an_argument_position'.
		do
			argument_position := an_argument_position
		end

	enable_local
			-- Set `is_local' to true.
		do
			is_local := True
		end

	enable_object_test_local
			-- Set `is_object_test_local' to true.
		do
			is_object_test_local := True
		end

	enable_argument
			-- Set `is_argument' to true.
		do
			is_argument := True
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class ADDRESS_AS
