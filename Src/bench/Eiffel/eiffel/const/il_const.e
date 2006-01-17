indexing
	description: "Constant class for IL operators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_CONST

feature -- Property

	valid_type_kind (i: INTEGER): BOOLEAN is
			-- Is `i' on of the following values `il_i1', `il_i2', `il_i4', `il_i8',
			-- `il_r4', `il_r8', `il_ref'?
		do
			Result := i = il_i1 or i = il_i2 or i = il_i4 or i = il_i8 or
					 i = il_r4 or i = il_r8 or i = il_ref
		end

feature -- Constants for binary expression

		-- Comparisons operators on numeric and characters.
	Il_lt: INTEGER is 0
	Il_le: INTEGER is 1
	Il_gt: INTEGER is 2
	Il_ge: INTEGER is 3

		-- Numeric operators.
	Il_star: INTEGER is 4
	Il_slash: INTEGER is 5
	Il_power: INTEGER is 6
	Il_plus: INTEGER is 7
	Il_mod: INTEGER is 8
	Il_minus: INTEGER is 9
	Il_div: INTEGER is 10

		-- Boolean comparisons operators.
	Il_xor: INTEGER is 11
	Il_or: INTEGER is 12
	Il_and: INTEGER is 13

		-- Equality operators.
	Il_ne: INTEGER is 14
	Il_eq: INTEGER is 15

		-- Shifting operator
	Il_shl: INTEGER is 20
	Il_shr: INTEGER is 21

feature -- Constants for unary expression

	Il_uplus: INTEGER is 16
	Il_not: INTEGER is 17
	Il_uminus: INTEGER is 18
	Il_old: INTEGER is 19
	Il_bitwise_not: INTEGER is 22

feature -- Constants for variable kind

	il_i1: INTEGER is 30
	il_i2: INTEGER is 31
	il_i4: INTEGER is 32
	il_i8: INTEGER is 33
	il_r4: INTEGER is 34
	il_r8: INTEGER is 35
	il_ref: INTEGER is 36
	il_i: INTEGER is 37
	il_u1: INTEGER is 38
	il_u2: INTEGER is 39
	il_u4: INTEGER is 40
	il_u8: INTEGER is 41
	il_expanded: INTEGER is 42;
	
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

end -- class IL_CONST
