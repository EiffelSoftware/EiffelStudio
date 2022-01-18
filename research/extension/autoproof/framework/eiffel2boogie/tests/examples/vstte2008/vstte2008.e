class
	VSTTE2008

feature -- VSTTE 2008: Adding and Multiplying Numbers

	add (a, b: INTEGER): INTEGER
			-- Add two numbers by repeated increment.
			-- Iterative version.
		require
			a_not_negative: a >= 0
			b_not_negative: b >= 0
		local
			i: INTEGER
		do
			from
				Result := a
				i := b
			invariant
				Result = a + (b - i)
				0 <= i and i <= b
			until
				i = 0
			loop
				Result := Result + 1
				i := i - 1
			variant
				i
			end
		ensure
			result_correct: Result = a + b
		end

	add_recursive (a, b: INTEGER): INTEGER
			-- Add two numbers by repeated increment.
			-- Recursive version.
		require
			a_not_negative: a >= 0
			b_not_negative: b >= 0
		do
			if b = 0 then
				Result := a
			else
				Result := add_recursive (a, b - 1) + 1
			end
		ensure
			result_correct: Result = a + b
		end

	multiply (a, b: INTEGER): INTEGER
			-- Multiply two numbers by repeated addition.
			-- Iterative version.
		require
			a_not_negative: a >= 0
			b_not_negative: b >= 0
		local
			i: INTEGER
		do
			if a = 0 or b = 0 then
				Result := 0
			else
				from
					Result := a
					i := b
				invariant
					Result = a * (b - i + 1)
					1 <= i and i <= b
				until
					i = 1
				loop
					Result := Result + a
					i := i - 1
				variant
					i
				end
			end
		ensure
			result_correct: Result = a * b
		end

	multiply_recursive (a, b: INTEGER): INTEGER
			-- Multiply two numbers by repeated addition.
			-- Recursive version.
		require
			a_not_negative: a >= 0
			b_not_negative: b >= 0
		do
			if a = 0 or b = 0 then
				Result := 0
			else
				if b = 1 then
					Result := a
				else
					Result := a + multiply (a, b-1)
				end
			end
		ensure
			result_correct: Result = a * b
		end

feature -- VSTTE2008: Binary search

	client_binary_search
			-- Using binary search.
		note
			explicit: wrapping
		local
			a: SIMPLE_ARRAY [INTEGER]
			i: INTEGER
		do
			create a.init (<<-3, 5, 9, 22, 104, 105, 107, 213>>)

			i := binary_search (a, -3)
			check i = 1 end
			i := binary_search (a, 22)
			check i = 4 end
			i := binary_search (a, 56)
			check i = 0 end
		end

	binary_search (a: SIMPLE_ARRAY [INTEGER]; x: INTEGER): INTEGER
			-- Calculate index of `x' in `a', or return 0 if not found.
		note
			status: impure
		require
			a_not_void: a /= Void
			a_sorted: sorted (a)
		local
			low, up, middle: INTEGER
		do
			from
				low := 1
				up := a.count + 1
			invariant
				low_and_up_range: 1 <= low and low <= up and up <= a.sequence.count + 1
				result_range: Result = 0 or 1 <= Result and Result <= a.sequence.count
				x_not_in_lower_part: across 1 |..| (low-1) as i all a.sequence[i] < x end
				x_not_in_upper_part: across up |..| a.sequence.count as i all x < a.sequence[i] end
				x_found: Result > 0 implies a.sequence[Result] = x
			until
				low >= up or Result > 0
			loop
				middle := low + ((up - low) // 2)
				if a[middle] < x then
					lemma_smaller_until_index (a, middle, x)
					low := middle + 1
				elseif a[middle] > x then
					lemma_larger_from_index (a, middle, x)
					up := middle
				else
					Result := middle
				end
			variant
				(a.count - Result) + (up - low)
			end
		ensure
			Result = 0 or 1 <= Result and Result <= a.sequence.count
			Result = 0 implies not a.sequence.has (x)
			Result > 0 implies a.sequence[Result] = x
		end

	sorted (a: SIMPLE_ARRAY [INTEGER]): BOOLEAN
			-- Is `a' sorted?
		note
			status: functional
		require
			a /= Void
		do
			Result := across 1 |..| (a.sequence.count-1) as i all a.sequence[i] <= a.sequence[i+1] end
		end

	lemma_smaller_until_index (a: SIMPLE_ARRAY [INTEGER]; i, x: INTEGER)
		note
			status: lemma
		require
			a_wrapped: a.is_wrapped
			a_sorted: sorted (a)
			i_in_range: 1 <= i and i <= a.count
			a_at_i_smaller: a.sequence[i] < x
		do
			if i > 1 then
				lemma_smaller_until_index (a, i-1, x)
			end
		ensure
			 a_until_i_smaller: across 1 |..| i as ai all a.sequence[ai] < x end
		end

	lemma_larger_from_index (a: SIMPLE_ARRAY [INTEGER]; i, x: INTEGER)
		note
			status: lemma
		require
			a_wrapped: a.is_wrapped
			a_sorted: sorted (a)
			i_in_range: 1 <= i and i <= a.count
			a_at_i_larger: a.sequence[i] > x

			decreases (a.count - i)
		do
			if i < a.sequence.count then
				lemma_larger_from_index (a, i+1, x)
			end
		ensure
			 a_from_i_larger: across i |..| a.sequence.count as ai all a.sequence[ai] > x end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
