indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_STRING

inherit
	STRING
		rename
			plus as string_plus
		redefine
			mirrored
		end

creation
	make, make_from_string, clone_from_string,
	make_from_c

feature -- Creation

	clone_from_string (s: STRING) is
			-- Initialize from the characters of `s'.
		require
			string_exists: s /= void
		do
			area := s.area.twin
			count := s.count
		ensure
			unique_identity: area /= s.area
			identical_data: equal (area, s.area)
		end

feature -- Basic operations

	appended (other: detachable ANY): ES_STRING is
		do
			Result := twin
			if other /= Void then
				Result.append (other.out)
			end
		ensure
			constant: equal (Current, old twin)
		end

	plus alias "+" (other: detachable ANY): ES_STRING is
		do
			Result := twin
			if other /= Void then
				Result.append (other.out)
			end
		ensure
			constant: equal (Current, old twin)
		end


feature -- Status report

	is_left_adjusted: BOOLEAN is
		do
			Result := item (lower) /= ' '
		ensure
			no_initial_blank: item (1) /= ' '
		end

	is_right_adjusted: BOOLEAN is
		do
			Result := item (upper) /= ' '
		ensure
			no_final_blank: item (count) /= ' '
		end

	lower: INTEGER is 1
			-- Index of lowest character

	upper: INTEGER is
			-- Synonym of count
		do
			Result := count
		end

feature -- Element change

	shorten_to (i: INTEGER) is
		require
			great_enough: i >= 1
			small_enough: i <= count
		do
			from
			variant
				count
			until
				i = count
			loop
				remove (count)
			end
		ensure
			correct_length: count = i
		end

feature -- Conversion

	mirrored: like Current is
			-- Mirror image of string;
			-- result for "Hello world" is "dlrow olleH".
		do
			--| Why re-implement it? Simplicity.
			Result := twin
			Result.mirror
		end

feature -- Access

--	new_iterator: ES_STRING_ITERATOR is
--		do
--			!! Result.make (Current)
--		end

end -- class ES_STRING
