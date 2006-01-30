indexing

	description: "Node for real constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REAL_AS

inherit
	ATOMIC_AS
		undefine
			text
		redefine
			is_equivalent
		end

	LEAF_AS
		redefine
			first_token
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: like constant_type; r: STRING) is
			-- Create a new REAL_AS node of type `a_type' with `r'
			-- containing the textual representation
			-- of the real value.
		require
			r_not_void: r /= Void
		do
			value := r.string
			value.replace_substring_all ("_","")
			constant_type := a_type
		ensure
			value_not_void: value /= Void
			value_set: not r.has ('_') implies value.is_equal (r)
				-- and then r.has ('_') implies value.is_equal (r) (modulo removed underscores)
			constant_type_set: constant_type = a_type
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_real_as (Current)
		end

feature -- Roundtrip

	sign_symbol: SYMBOL_AS
			-- Symbol "+" or "-" associated with this structure

	set_sign_symbol (s_as: SYMBOL_AS) is
			-- Set `sign_symbol' with `s_as'.
		do
			sign_symbol := s_as
		ensure
			sign_symbol_set: sign_symbol = s_as
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Current
			else
				if sign_symbol /= Void then
					Result := sign_symbol.first_token (a_list)
				else
					Result := Current
				end
			end
		end

feature -- Access

	value: STRING
			-- Real value

	constant_type: TYPE_AS
			-- Actual type of real constant if specified.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value.is_equal (other.value) and then equal (constant_type, other.constant_type)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is
		do
			Result := value.twin
		end

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

end -- class REAL_AS
