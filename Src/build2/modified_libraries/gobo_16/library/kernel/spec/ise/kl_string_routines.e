indexing

	description:

		"Routines that ought to be in class STRING"

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_STRING_ROUTINES

feature -- Initialization

	make (n: INTEGER): STRING is
			-- Create an empty string. Try to allocate space
			-- for at least `n' characters.
		require
			non_negative_n: n >= 0
		do
			!! Result.make (n)
		ensure
			string_not_void: Result /= Void
			empty_string: Result.count = 0
		end

	make_buffer (n: INTEGER): STRING is
			-- Create a new string containing `n' characters.
		require
			non_negative_n: n >= 0
		do
			!! Result.make (n)
			Result.fill_blank
		ensure
			string_not_void: Result /= Void
			count_set: Result.count = n
		end

feature -- Status report

	is_integer (a_string: STRING): BOOLEAN is
			-- Is `a_string' only made up of digits?
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.is_integer
		end

feature -- Access

	case_insensitive_hash_code (a_string: STRING): INTEGER is
			-- Hash code value of `a_string' which doesn't
			-- take case sensitivity into account
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
		do
			nb := a_string.count
			if nb > 5 then
				Result := nb * a_string.item (nb).lower.code
				i := 5
			else
				i := nb
			end
			from until i <= 0 loop
				Result := Result + a_string.item (i).lower.code
				i := i - 1
			end
			Result := Result * nb
		ensure
			hash_code_positive: Result >= 0
		end

feature -- Comparison

	same_case_insensitive (s1, s2: STRING): BOOLEAN is
			-- Are `s1' and `s2' made up of the same
			-- characters (case insensitive)?
		require
			s1_not_void: s1 /= Void
			s2_not_void: s2 /= Void
		local
			c1, c2: CHARACTER
			i: INTEGER
		do
			if s1 = s2 then
				Result := True
			elseif s1.count = s2.count then
				Result := True
				from i := s1.count until i < 1 loop
					c1 := s1.item (i)
					c2 := s2.item (i)
					if c1 = c2 then
						i := i - 1
					elseif c1.lower = c2.lower then
						i := i - 1
					else
						Result := False
						i := 0  -- Jump out of the loop
					end
				end
			end
		end

feature -- Conversion

	to_lower (a_string: STRING): STRING is
			-- Lower case version of `a_string'
			-- (Do not alter `a_string'.)
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_lower
		ensure
			lower_string_not_void: Result /= Void
			same_count: Result.count = a_string.count
--			definition: forall i in 1..a_string.count,
--				Result.item (i) = a_string.item (i).to_lower
		end

	to_upper (a_string: STRING): STRING is
			-- Upper case version of `a_string'
			-- (Do not alter `a_string'.)
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_upper
		ensure
			lower_string_not_void: Result /= Void
			same_count: Result.count = a_string.count
--			definition: forall i in 1..a_string.count,
--				Result.item (i) = a_string.item (i).to_upper
		end

feature -- Resizing

	resize_buffer (a_string: STRING; n: INTEGER) is
			-- Resize `a_string' so that it contains `n' characters.
			-- Do not lose any previously entered characters.
		require
			a_string_not_void: a_string /= Void
			n_large_enough: n >= a_string.count
		local
			i: INTEGER
		do
			from
				i := n - a_string.count
				a_string.resize (n)
			until
				i = 0
			loop
				a_string.append_character ('#')
				i := i - 1
			end
		ensure
			count_set: a_string.count = n
		end

end -- class KL_STRING_ROUTINES
