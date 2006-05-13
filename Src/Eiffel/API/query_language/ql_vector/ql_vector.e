indexing
	description: "[
					A quantity vector
					Two vectors A and B can be applied to a binary operation in the following cases:
					1. Dimension of A is 1, and dimension of B is larger thnn 1
						For example, A = [1], B = [1, 2, 3]
						A - B = [0, 1, 2]
					2. Dimension of A is larger than 1 and dimension of B is 1
						For example, A = [1, 2, 3], B = [2]
						A * B = [2, 4, 6]
					3. Dimension of A is equal to dimension of B
					   For example, A = [1, 2, 3], B = [1, 2, 3]
					   A / B = [1, 2, 3]
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_VECTOR

inherit
	LINKED_LIST [QL_QUANTITY]

create
	make

feature -- Binary operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		require
			other_attached: other /= Void
			valid_for_binary_operation: is_valid_for_binary_operation (Current, other)
		do
			Result := result_vector (other, agent add_two_double)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		require
			other_attached: other /= Void
			valid_for_binary_operation: is_valid_for_binary_operation (Current, other)
		do
			Result := result_vector (other, agent subtract_two_double)
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		require
			other_attached: other /= Void
			valid_for_binary_operation: is_valid_for_binary_operation (Current, other)
		do
			Result := result_vector (other, agent multiply_two_double)
		end

	infix "^" (other: like Current): like Current is
			-- Power by `other'
		require
			other_attached: other /= Void
			valid_for_binary_operation: is_valid_for_binary_operation (Current, other)
		do
			Result := result_vector (other, agent power_two_double)
		end

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		require
			other_attached: other /= Void
			valid_for_binary_operation: is_valid_for_binary_operation (Current, other)
			good_divisor: divisible (other)
		do
			Result := result_vector (other, agent divide_two_double)
		end

feature -- Unary operations

	prefix "+": like Current is
			-- Unary plus
		do
			Result := result_from_unary_operation (agent unary_plus)
		ensure
			result_attached: Result /= Void
		end

	prefix "-": like Current is
			-- Unary minus
		do
			Result := result_from_unary_operation (agent unary_minus)
		ensure
			result_attached: Result /= Void
		end

	log_2: like Current is
			-- Base 2 logarithm of `Current'
		do
			Result := result_from_unary_operation (agent math_log_2)
		ensure
			result_attached: Result /= Void
		end

	cosine: like Current is
			-- Trigonometric cosine of radian `Current' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := result_from_unary_operation (agent math_cosine)
		ensure
			result_attached: Result /= Void
		end

	arc_cosine: like Current is
			-- Trigonometric arccosine of radian `Current'
			-- in the range [0, pi]
		do
			Result := result_from_unary_operation (agent math_arc_cosine)
		ensure
			result_attached: Result /= Void
		end

	sine: like Current is
			-- Trigonometric sine of radian `Current' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := result_from_unary_operation (agent math_sine)
		ensure
			result_attached: Result /= Void
		end

	arc_sine: like Current is
			-- Trigonometric arcsine of radian `Current'
			-- in the range [-pi/2, +pi/2]
		do
			Result := result_from_unary_operation (agent math_arc_sine)
		ensure
			result_attached: Result /= Void
		end

	tangent: like Current is
			-- Trigonometric tangent of radian `Current' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := result_from_unary_operation (agent math_tangent)
		ensure
			result_attached: Result /= Void
		end

	arc_tangent: like Current is
			-- Trigonometric arctangent of radian `Current'
			-- in the range [-pi/2, +pi/2]
		do
			Result := result_from_unary_operation (agent math_arc_tangent)
		ensure
			result_attached: Result /= Void
		end

	sqrt: like Current is
			-- Square root of `Current'
		do
			Result := result_from_unary_operation (agent math_sqrt)
		ensure
			result_attached: Result /= Void
		end

	exp: like Current is
			-- Exponential of `Current'.
		do
			Result := result_from_unary_operation (agent math_exp)
		ensure
			result_attached: Result /= Void
		end

	log: like Current is
			-- Natural logarithm of `Current'
		do
			Result := result_from_unary_operation (agent math_log)
		ensure
			result_attached: Result /= Void
		end

	log10: like Current is
			-- Base 10 logarithm of `Current'
		do
			Result := result_from_unary_operation (agent math_log10)
		ensure
			result_attached: Result /= Void
		end

	floor: like Current is
			-- Greatest integral less than or equal to `Current'
		do
			Result := result_from_unary_operation (agent math_floor)
		ensure
			result_attached: Result /= Void
		end

	ceiling: like Current is
			-- Least integral greater than or equal to `Current'
		do
			Result := result_from_unary_operation (agent math_ceiling)
		ensure
			result_attached: Result /= Void
		end

	dabs (v: DOUBLE): like Current is
			-- Absolute of `Current'
		do
			Result := result_from_unary_operation (agent math_dabs)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_valid_for_binary_operation (a_vector, b_vector: like Current): BOOLEAN is
			-- Are `a_vector' and `b_vector' valid for a binary operation?
		require
			a_vector_attached: a_vector /= Void
			b_vector_attached: b_vector /= Void
		do
			Result := a_vector.count <= 1 or else
					 b_vector.count <= 1 or else
					 a_vector.count = b_vector.count
		ensure
			good_result: Result implies (
				a_vector.count <= 1 or else
				b_vector.count <= 1 or else
				a_vector.count = b_vector.count
			)
		end

	divisible (other: like Current): BOOLEAN is
			-- May current object be divided by `other'?
		require
			other_attached: other /= Void
			is_valid_for_binary_operation (Current, other)
		do
			from
				Result := True
				other.start
			until
				other.after or not Result
			loop
				Result := other.item.value = 0.0
				other.forth
			end
		end

feature{NONE} -- Implementation

	result_from_unary_operation (a_calculation_function: FUNCTION [ANY, TUPLE [DOUBLE], DOUBLE]): like Current is
			-- Result vector of `Current' and `other' with `a_calculation_function' applied.
		require
			a_calculation_function_attached: a_calculation_function /= Void
		local
			l_cursor: CURSOR
		do
			create Result.make
			if not is_empty then
				l_cursor := cursor
				from
					start
				until
					after
				loop
					Result.extend (create{QL_QUANTITY}.make_with_value (a_calculation_function.item ([item.value])))
					forth
				end
				if l_cursor /= Void then
					go_to (l_cursor)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	result_vector (other: like Current; a_calculation_function: FUNCTION [ANY, TUPLE[DOUBLE, DOUBLE], DOUBLE]): like Current is
			-- Result vector of `Current' and `other' with `a_calculation_function' applied.
		require
			other_attached: other /= Void
			a_calculation_function_attached: a_calculation_function /= Void
		local
			l_count: INTEGER
			l_cur_cursor: CURSOR
			l_other_cursor: CURSOR
			l_list: like Current
			l_value: DOUBLE
		do
			l_count := count.max (other.count)
			create Result.make
			if count = other.count then
				l_cur_cursor := cursor
				l_other_cursor := other.cursor
				from
					start
					other.start
				until
					after
				loop
					Result.extend (create{QL_QUANTITY}.make_with_value (a_calculation_function.item ([item.value, other.item.value])))
					forth
					other.forth
				end
				if l_cur_cursor /= Void then
					go_to (l_cur_cursor)
				end
				if l_other_cursor /= Void then
					other.go_to (l_other_cursor)
				end
			else
				if count > other.count then
					l_list := Current
					l_value := other.first.value
					l_cur_cursor := cursor
					from
						start
					until
						after
					loop
						Result.extend (create{QL_QUANTITY}.make_with_value (a_calculation_function.item ([item.value, l_value])))
						forth
					end
				else
					l_list := other
					l_value := first.value
					l_cur_cursor := l_list.cursor
					from
						l_list.start
					until
						l_list.after
					loop
						Result.extend (create{QL_QUANTITY}.make_with_value (a_calculation_function.item ([l_value, l_list.item.value])))
						l_list.forth
					end
				end
				l_cur_cursor := l_list.cursor
				if l_cur_cursor /= Void then
					l_list.go_to (l_cur_cursor)
				end

			end
		end

	add_two_double (a, b: DOUBLE): DOUBLE is
			-- Sum of `a' and `b'
		do
			Result := a + b
		ensure
			good_result: Result = a + b
		end

	subtract_two_double (a, b: DOUBLE): DOUBLE is
			-- Subtraction of `a' and `b'
		do
			Result := a - b
		ensure
			good_result: Result = a - b
		end

	multiply_two_double (a, b: DOUBLE): DOUBLE is
			-- Multiplication of `a' and `b'
		do
			Result := a * b
		ensure
			good_result: Result = a * b
		end

	power_two_double (a, b: DOUBLE): DOUBLE is
			-- Power of `a' and `b'
		do
			Result := a ^ b
		ensure
			good_result: Result = a ^ b
		end

	divide_two_double (a, b: DOUBLE): DOUBLE is
			-- Quotient of `a' and `b'
		require
			not_b_is_zero: b /= 0.0
		do
			Result := a / b
		ensure
			good_result: Result = a / b
		end

	unary_plus (a: DOUBLE): DOUBLE is
			-- Unary plus of `a'
		do
			Result := +a
		ensure
			good_result: Result = + a
		end

	unary_minus (a: DOUBLE): DOUBLE is
			-- Unary minus of `a'
		do
			Result := -a
		ensure
			good_result: Result = -a
		end

	double_math: DOUBLE_MATH is
			-- Math operations
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	math_log_2 (v: DOUBLE): DOUBLE is
			-- Base 2 logarithm of `v'
		do
			Result := double_math.log_2 (v)
		ensure
			good_result: Result = double_math.log_2 (v)
		end

	math_cosine (v: DOUBLE): DOUBLE is
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := double_math.cosine (v)
		ensure
			good_result: Result = double_math.cosine (v)
		end

	math_arc_cosine (v: DOUBLE): DOUBLE is
			-- Trigonometric arccosine of radian `v'
			-- in the range [0, pi]
		do
			Result := double_math.arc_cosine (v)
		ensure
			good_result: Result = double_math.arc_cosine (v)
		end

	math_sine (v: DOUBLE): DOUBLE is
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := double_math.sine (v)
		ensure
			good_result: Result = double_math.sine (v)
		end

	math_arc_sine (v: DOUBLE): DOUBLE is
			-- Trigonometric arcsine of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := double_math.arc_sine (v)
		ensure
			good_result: Result = double_math.arc_sine (v)
		end

	math_tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := double_math.tangent (v)
		ensure
			good_result: Result = double_math.tangent (v)
		end

	math_arc_tangent (v: DOUBLE): DOUBLE is
			-- Trigonometric arctangent of radian `v'
			-- in the range [-pi/2, +pi/2]
		do
			Result := double_math.arc_tangent (v)
		ensure
			good_result: Result = double_math.arc_tangent (v)
		end

	math_sqrt (v: DOUBLE): DOUBLE is
			-- Square root of `v'
		do
			Result := double_math.sqrt (v)
		ensure
			good_result: Result = double_math.sqrt (v)
		end

	math_exp (v: DOUBLE): DOUBLE is
			-- Exponential of `v'.
		do
			Result := double_math.exp (v)
		ensure
			good_result: Result = double_math.exp (v)
		end

	math_log (v: DOUBLE): DOUBLE is
			-- Natural logarithm of `v'
		do
			Result := double_math.log (v)
		ensure
			good_result: Result = double_math.log (v)
		end

	math_log10 (v: DOUBLE): DOUBLE is
			-- Base 10 logarithm of `v'
		do
			Result := double_math.log10 (v)
		ensure
			good_result: Result = double_math.log10 (v)
		end

	math_floor (v: DOUBLE): DOUBLE is
			-- Greatest integral less than or equal to `v'
		do
			Result := double_math.floor (v)
		ensure
			good_result: Result = double_math.floor (v)
		end

	math_ceiling (v: DOUBLE): DOUBLE is
			-- Least integral greater than or equal to `v'
		do
			Result := double_math.ceiling (v)
		ensure
			good_result: Result = double_math.ceiling (v)
		end

	math_dabs (v: DOUBLE): DOUBLE is
			-- Absolute of `v'
		do
			Result := double_math.dabs (v)
		ensure
			good_result: Result = double_math.dabs (v)
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
