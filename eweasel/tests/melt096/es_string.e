note
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

create
	make, make_from_string, clone_from_string,
	make_from_c

feature -- Creation

	clone_from_string (s: STRING)
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

	appended (other: detachable ANY): ES_STRING
		do
			Result := twin
			if other /= Void then
				Result.append (other.out)
			end
		ensure
			constant: equal (Current, old twin)
		end

	plus alias "+" (other: detachable ANY): ES_STRING
		do
			Result := twin
			if other /= Void then
				Result.append (other.out)
			end
		ensure
			constant: equal (Current, old twin)
		end


feature -- Status report

	is_left_adjusted: BOOLEAN
		do
			Result := item (lower) /= ' '
		ensure
			no_initial_blank: item (1) /= ' '
		end

	is_right_adjusted: BOOLEAN
		do
			Result := item (upper) /= ' '
		ensure
			no_final_blank: item (count) /= ' '
		end

	upper: INTEGER   
                          -- Synonym of count   
                  do   
                          Result := count   
                  end   
   
feature -- Element change

	shorten_to (i: INTEGER)
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

	mirrored: like Current
			-- Mirror image of string;
			-- result for "Hello world" is "dlrow olleH".
		do
			--| Why re-implement it? Simplicity.
			Result := twin
			Result.mirror
		end

end
