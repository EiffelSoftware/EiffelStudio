indexing
   description: "Sequence of ucchars, accessible through integer %
                %indices in a contigous range.";
   author:      "majkel kretschmar <majkel.kretschmar@student.uni-halle.de>";

   version:     "1";
   original:    "1999.10.11";
   copyright:   "1999 majkel kretschmar and others, see file »forum.txt«";

class UCSTRING

inherit
   COMPARABLE
      redefine infix "<=", infix ">", infix ">=", is_equal, 
	 three_way_comparison, out, copy
      end
   HASHABLE
      redefine is_equal, out, copy
      end
   UCSTRING_EXTERNAL
      redefine is_equal, out, copy
      end

creation 
   make, make_from_string, make_from_utf8

feature -- Creation

   frozen make (n: INTEGER) is
	 -- Allocate space for at least `n' characters.
      require
	 non_negative_size: n >= 0
      do
	 ensure_capacity(n)
	 i_count := 0
      ensure
	 empty_string: count = 0;
	 -- correctly_allocated_size: capacity >= n;
      end

   make_from_string (other: STRING) is
	 -- Initialize from the characters of `other'.
	 -- (Useful in proper descendants of class STRING,
	 -- to initialize a string-like object from a manifest string.)
      require
	 string_exists: other /= Void;
      local
	 i: INTEGER;
      do
	 ensure_capacity(other.count)
         i_count := other.count

	 from
	    i := 1
	 until
	    i > count
	 loop
	    put_code(other.item(i).code, i)
	    i := i + 1
	 end
      ensure
	 count_set: count = other.count;
      end

   make_from_utf8 (other: STRING) is
	 -- Initialize from the characters of `other' which are 
	 -- stored in UFT8-Format
      require
	 string_exists: other /= Void
--	 valid_utf8: valid_utf8(other)
      local
	 i,code,nc,j: INTEGER
	 xcp: EXCEPTIONS
      do
	 ensure_capacity(other.count)
	 i_count := other.count	-- may be too big

	 from
	    i := 1
            j := 0
	 until
	    i > other.count
	 loop
	    code := other.item(i).code

	    if code < 128 then
               j := j + 1
	       i := i + 1
	       put_code(code,j)
	    elseif code >= 192 and code <= 223 then
	       nc := (code \\ 192)*64 + (other.item(i+1).code \\ 128)
	       i := i + 2
               j := j + 1
	       put_code(nc,j)
	    elseif code >= 224 and code <= 239 then
	       nc := (code \\ 224)*4096 +
		  (other.item(i+1).code \\ 128)*64 +
		  (other.item(i+2).code \\ 128)
	       i := i + 3
               j := j + 1
	       put_code(nc,j)
	    else
	       !!xcp
	       xcp.raise("Corrupt UTF8")
	    end
	 end

         -- set correct size
         i_count := j
      end

feature -- Initialization

--   from_c (c_string: POINTER) is
--	 -- not implemented
--      require
--	 C_string_exists: c_string /= void
--      do
--	 --! not implemented
--      end

   frozen remake (n: INTEGER) is
	 -- Allocate space for at least `n' characters.
      require
	 non_negative_size: n >= 0
      do
	 make(n)
      ensure
	 empty_string: count = 0
      end;

feature -- Access

   hash_code: INTEGER is
      local
	 i: INTEGER
      do
	 -- taken from SmallEiffel

         i := count;
         if i > 5 then
            Result := i * item(i).code
            i := 5
         end
         from until i <= 0 loop
            Result := Result + item(i).code
            i := i - 1
         end
         Result := Result * count
      end

   index_of (c: UCCHAR; start: INTEGER): INTEGER is
	 -- Position of first occurrence of `c' at or after `start';
	 -- 0 if none.
      require
	 start_large_enough: start >= 1
	 start_small_enough: start <= count
      local
	 i: INTEGER;
      do
	 from
	    i := start
	 until
	    i > count or else item_code(i) = c.code
	 loop
	    i := i + 1;
	 end

	 if i<= count then
	    Result := i
	 end
      ensure
	 non_negative_result: Result >= 0;
         at_this_position: Result > 0 implies item(Result).code = c.code
	 -- none_before: For every i in start..Result, item (i) /= c
	 -- zero_iff_absent:
	 --     (Result = 0) = For every i in 1..count, item (i) /= c
      end

   item, infix "@" (i: INTEGER): UCCHAR is
	 -- Character at position `i'
      require
	 good_key: valid_index (i)
      do
	 Result.make_from_integer(item_code(i))
      end

   substring_index (other: UCSTRING; start: INTEGER) : INTEGER is
	 -- Position of first occurrence of `other' at or after `start';
	 -- 0 if none.
      require
	 start_in_range: valid_index(start);     --! mk
	 other_non_void: other /= void;		 --! mk
      local
	 i,j: INTEGER;
      do
	 from
	    i := start
	 until
	    Result /= 0 or else i > count - other.count + 1 
	 loop
	    from
	       j := 1
	    until
	       j > other.count or else not item(i+j-1).is_equal(other.item(j))
	    loop
	       j := j + 1;
	    end

	    if j > other.count then
	       Result := i
	    end

	    i := i + 1
	 end
      ensure
	 non_negative_result: Result >= 0; -- mk
         at_this_position: Result > 0 implies 
			   substring(Result, 
				     Result+other.count-1).is_equal(other);--mk
      end

feature -- Measurement

   count: INTEGER is
	 -- Actual number of characters making up the string
      do
	 Result := i_count
      end

   occurrences (c: UCCHAR): INTEGER is
	 -- Number of times `c' appears in the string
      local
	 i: INTEGER
      do
	 from
	    i := 1
	 until
	    i > count
	 loop
	    if item_code(i) = c.code then
	       Result := Result + 1
	    end
	    i := i + 1
	 end
      ensure
	 non_negative_occurrences: Result >= 0
      end

feature -- Comparison

   is_equal (other: like Current): BOOLEAN is
	 -- Is string made of same character sequence as other?
	 -- (Redefined from `GENERAL')
      do
	 if Current = other then
	    Result := true
         else
	    if count = other.count then
	       Result := three_way_comparison(other) = 0
            end
         end
      end

   infix "<" (other: like Current): BOOLEAN is
      do
	 Result := three_way_comparison(other) = -1
      end

   infix "<=" (other: like Current): BOOLEAN is
      do
	 Result := three_way_comparison(other) <= 0
      end

   infix ">=" (other: like Current): BOOLEAN is
      do
	 Result := three_way_comparison(other) >= 0
      end

   infix ">" (other: like Current): BOOLEAN is
      do
	 Result := three_way_comparison(other) = 1
      end

   three_way_comparison (other: like Current): INTEGER is
      local
	 stop: BOOLEAN
	 i: INTEGER
      do
	 if Current = other then
	    Result := 0
         else
	    from
	       i := 1
	    until
	       stop or else i > count.min(other.count)
	    loop
	       if item(i) < other.item(i) then
		  Result := -1
		  stop := true
	       elseif item(i) > other.item(i) then
		  Result := 1
		  stop := true
	       end

	       i := i + 1
	    end

	    if Result = 0 then
	       if count > other.count then
		  Result := 1
	       elseif count < other.count then
		  Result := -1
	       end
	    end
	 end
      end

feature -- Status report

   empty: BOOLEAN is
	 -- Is string empty?
      do
	 Result := count = 0
      end

   valid_index (i: INTEGER): BOOLEAN is
	 -- Is `i' within the bounds of the string?
      do
	 Result := (1 <= i) and (i <= count)
      end

feature -- Element change

   append_boolean (b: BOOLEAN) is
	 -- Append the string representation of `b' at end.
      do
	 append_string(b.out)
      end

   append_character (c: CHARACTER) is
      do
	 append_ucc_code(c.code)
      ensure
	 item_inserted: item_code(count) = c.code;
         -- one_more_occurrence: occurrences(c) = old (occurrences(c)) + 1;
      end

   append_double (d: DOUBLE) is
	 -- Append the string representation of `d' at end.
      do
	 append_string(d.out)
      end

   append_integer (i: INTEGER) is
	 -- Append the string representation of `i' at end.
      do
	 append_string(i.out)
      end

   append_real (r: REAL) is
	 -- Append the string representation of `r' at end.
      do
	 append_string(r.out)
      end

   append_string (s: STRING) is
	 -- Append a copy of `s' if not void, at end
      local
	 oc,i: INTEGER
      do
	 if s /= void then
	    oc := count
	    ensure_capacity(count + s.count)
	    i_count := i_count + s.count

	    from
	       i := 1
	    until
	       i > s.count
	    loop
	       put_code(s.item(i).code, oc+i)
	       i := i + 1
	    end
	 end
      ensure
	 new_count: s /= void and then count = old count + s.count;
         -- appended: For every `ì' in 1..s.count
         --   item(old count + 1) = s.item(i)
      end

   append_ucchar (c: UCCHAR) is
	 -- Append `c' at end.
      do
	 append_ucc_code(c.code)
      ensure
	 item_inserted: item(count).code = c.code
	 one_more_occurrence: occurrences (c) = old (occurrences (c)) + 1
	 -- item_inserted: has (c)
      end
   append_ucstring (s: UCSTRING) is
	 -- Append a copy of `s', if not void, at end.
      local
	 i: INTEGER
	 oc: INTEGER
         cnt: INTEGER
      do
	 if s /= void then
	    oc := count
            cnt := s.count

	    ensure_capacity(count+s.count)
            i_count := i_count + s.count

	    from
	       i := 1
	    until
	       i > cnt
	    loop
	       put_code(s.item_code(i), oc+i)
	       i := i + 1
	    end
         
	 end
      ensure
	 new_count: count = old count + s.count
	 -- appended: For every i in 1.. s.count,
	 --     item (old count + i) = s.item (i)
      end

   fill (c: UCCHAR) is
	 -- Replace every character with `c'.
      local
	 i: INTEGER;
      do
	 from
	    i := 1
	 until
	    i > count
	 loop
	    put_code(c.code, i)
	    i := i + 1
	 end
      ensure
	 -- allblank: For every i in 1..count, item (i) = Blank
      end

   head (n: INTEGER) is
	 -- Remove all characters except for the first `n';
	 -- do nothing if `n' >= count.
      require
	 non_negative_argument: n >= 0
      do
	 if n < count then
	    resize(n)
         end
      ensure
	 new_count: count = n.min (old count)
	 -- first_kept: For every i in 1..n, item (i) = old item (i)
      end

   insert (s: like Current; i: INTEGER) is
	 -- Add `s' to the left of position `i'.
      require
	 string_exists: s /= Void;
	 index_small_enough: i <= count;
	 index_large_enough: i > 0
      local
	 k: INTEGER
      do
	 resize(count + s.count)
	 move(i, i+s.count,count-i+1)

	 -- insert
	 from
	    k := 1
	 until
	    k > s.count
	 loop
	    put_code(s.item_code(i), i+k-1)
	    k := k + 1
	 end
      ensure
	 new_count: count = old count + s.count
      end

   insert_ucchar (c: UCCHAR; i: INTEGER) is
	 -- Add `c' to the left of position `i'.
      do
	 resize(count + 1)
	 move(i, i+1, 1)
	 put_code(c.code, i)
      ensure
         new_count: count = old count + 1
      end

   left_adjust is
	 -- Remove leading white space.
      local
	 i: INTEGER
      do
	 from
	    i := 1
	 until
	    i > count or else not is_whitespace(item(i).code)
	 loop
	    i := i + 1
	 end

         if i > 1 then
	    move(i, 1, count-i+1)
            i_count := i_count - i + 1
         end
      ensure
	 --! new_count: (count /= 0) implies (item(1).code /= (' ').code)
      end

   put (c: UCCHAR; i: INTEGER) is
	 -- Replace character at position `i' by `c'.
      require
	 good_key: valid_index (i)
      do
	 put_code(c.code, i);
      ensure
	 insertion_done: item(i).code = c.code
      end

--   put_substring (s: like Current; start_pos, end_pos: INTEGER) is
--	 -- Copy the characters of `s' to positions
--	 -- `start_pos' .. `end_pos'.
--      require
--	 string_exists: s /= Void;
--	 index_small_enough: end_pos <= count;
--	 order_respected: start_pos <= end_pos;
--	 index_large_enough: start_pos > 0
--      local
--	 i: INTEGER
--      do
--	 --!!!!! completely unclear
--	 from
--	    i := 0
--	 until
--	    i > s.count.min(end_pos - start_pos + 1)
--	 loop
--	    i_storage.put(s.i_storage.item(i+1), i)
--	    i := i + 1
--	 end
--      ensure
--	 new_count: count = old count + s.count - end_pos + start_pos - 1
--      end

   right_adjust is
	 -- Remove trailing white space.
      do
	 from
	 until
	    empty or else not is_whitespace(item(count).code)
	 loop
	    i_count := i_count - 1;
	 end
      ensure
	 --! new_count: (count /= 0) implies (item(count).code /= (' ').code)
      end

   tail (n: INTEGER) is
	 -- Remove all characters except for the last `n';
	 -- do nothing if `n' >= count.
	 -- TODO: There seems to be a bug in this feature when 
	 -- compiled with SE
      require
	 non_negative_argument: n >= 0
      do
	 if n < count then
	    move(count-n+1, 1, n)
	    i_count := n
	 end
      ensure
	 new_count: count = n.min (old count)
      end

feature -- Removal

   remove (i: INTEGER) is
	 -- Remove `i'-th character.
      require
	 index_small_enough: i <= count;
	 index_large_enough: i > 0
      do
	 move(i+1, i, count -i)
	 i_count := i_count - 1
      ensure
	 new_count: count = old count - 1
      end

   wipe_out is
	 -- Remove all characters.
      do
	 resize(0)
      ensure
	 empty_string: count = 0;
	 wiped_out: empty
      end

feature -- Resizing

   resize (newsize: INTEGER) is
	 -- Rearrange string so that it can accommodate
	 -- at least newsize characters.
	 -- Do not lose any previously entered character.
      require
	 new_size_non_negative: newsize >= 0
      local
	 i, oc: INTEGER
      do
	 ensure_capacity(newsize)

	 -- clear all following characters
         oc := count
         i_count := newsize
         from
	    i := oc + 1
         until
	    i > i_count
         loop
	    put_code((' ').code, i)
	    i := i + 1
         end
      end

feature -- Conversion

--   to_boolean: BOOLEAN is
--	 -- Boolean value;
--	 -- "true" yields true, "false" yields false
--	 -- (case-insensitive)
--      do
--	 --! TBD
--      end

--   to_double: DOUBLE is
--	 -- "Double" value; for example, when applied to "123.0",
--	 -- will yield 123.0 (double)
--      do
--	 --! TBD
--      end

   to_integer: INTEGER is
	 -- Integer value;
	 -- for example, when applied to "123", will yield 123
      local
	 i: INTEGER
         last_character: INTEGER
	 state: INTEGER;
         sign: BOOLEAN;
         last_integer: INTEGER
         -- state = 0 : waiting sign or first digit.
         -- state = 1 : sign read, waiting first digit.
         -- state = 2 : in the number.
         -- state = 3 : end state.
         -- state = 4 : error state.
      do
	 -- taken from SmallEiffel
	 
         from
	    i := 1
         until
            i > count or state > 2
         loop
            last_character := item(i).code
            inspect
               state
            when 0 then
               if is_whitespace(last_character) then
               elseif is_digit(last_character) then
                  last_integer := int_value(last_character)
                  state := 2;
               elseif last_character = ('-').code then
                  sign := true;
                  state := 1;
               elseif last_character = ('+').code then
                  state := 1;
               else
                  state := 4;
               end;
            when 1 then
               if is_whitespace(last_character) then
               elseif is_digit(last_character) then
                  last_integer := int_value(last_character)
                  state := 2;
               else
                  state := 4;
               end;
            else -- 2
               if is_digit(last_character) then
                  last_integer := (last_integer * 10) + int_value(last_character)
               else
                  state := 3;
               end;
            end;
            if i = count then
               inspect
                  state
               when 0 .. 1 then
                  state := 4;
               when 2 .. 3 then
                  state := 3;
               else -- 4
               end;
            end;
            i := i + 1
         end
         debug
            if state = 4 then
               io.error.put_string("Error in UCSTRING.to_integer.%N");
               --crash;
            end;
         end;
         if sign then
            last_integer := - last_integer;
         end;
         
         Result := last_integer
      end

   to_lower is
	 -- Convert to lower case.
      local
	 i: INTEGER
	 ucc: UCCHAR
      do
	 from
	    i := 1
	 until
	    i > count
	 loop
	    ucc := item(i)
	    ucc.to_lower
            put(ucc, i)
	    i := i + 1
	 end
      end

   to_title is
	 -- Convert to title case.
      local
	 i: INTEGER
	 ucc: UCCHAR
      do
	 from
	    i := 1
	 until
	    i > count
	 loop
	    ucc := item(i)
	    ucc.to_title
            put(ucc, i)
	    i := i + 1
	 end
      end

--   to_real: REAL is
--	 -- Real value;
--	 -- for example, when applied to "123.0", will yield 123.0
--      do
--	 --! TBD
--      end

   to_upper is
	 -- Convert to upper case.
      local
	 i: INTEGER
	 ucc: UCCHAR
      do
	 from
	    i := 1
	 until
	    i > count
	 loop
	    ucc := item(i)
	    ucc.to_upper
            put(ucc, i)
	    i := i + 1
	 end
      end

   to_utf8: STRING is
	 -- Conversion to UTF-8 (as defined by RFC 2279)
      local
	 i,c: INTEGER
	 c1,c2,c3: INTEGER
      do
	 !!Result.make(count)

         -- Visual Eiffel makes things a little bit complicated
         if Result.count /= 0 then
	    Result.wipe_out
         end

	 from
	    i := 1
	 until
	    i > count
	 loop
	    c := item(i).code
	    if c < 128 then
	       Result.append_character(i_br.charconv(c))
	    elseif c < 2048 then
	       c1 := 192 + c // 64
	       c2 := 128 + c \\ 64
	       Result.append_character(i_br.charconv(c1))
	       Result.append_character(i_br.charconv(c2))
	    else
	       c1 := 224 + ((c // 64) \\ 64) // 64
	       c2 := 128 + (c // 64) \\ 64
	       c3 := 128 + c \\ 64
	       Result.append_character(i_br.charconv(c1))
	       Result.append_character(i_br.charconv(c2))
	    end
	    i := i + 1
	 end
      ensure
	 result_not_void: Result /= Void
      end

feature -- Duplication

   copy (other: like Current) is
      local
	 i: INTEGER
      do
	 --! other should be /= void

	 resize(other.count)
	 from
	    i := 1
	 until
	    i > other.count
	 loop
	    put_code(other.item_code(i), i)
	    i := i + 1
	 end
      end

   substring (n1, n2: INTEGER): like Current is
	 -- Copy of substring containing all characters at indices
	 -- between `n1' and `n2'
      require
	 meaningful_origin: 1 <= n1;
	 meaningful_interval: n1 <= n2;
	 meaningful_end: n2 <= count
      local
	 i,j: INTEGER
      do
	 !!Result.make(n2-n1+1)
	 Result.resize(n2-n1+1)

	 from
	    i := n1
            j := 1
	 until
	    i > n2
	 loop
	    Result.put_code(item_code(i), j)
	    i := i + 1
            j := j + 1
	 end
      ensure
	 new_result_count: Result.count = n2 - n1 + 1
	 -- original_characters: For every i in 1..n2-n1,
	 --     Result.item (i) = item (n1 + i -1)
      end

feature -- Output

   out: STRING is
	 --| characters with code >= 256 will be represented as
	 --| "\uxxxx;", where "xxxx" is the hexadecimal 
	 --| representation of code.
      local
	 i: INTEGER
      do
         !!Result.make(0)

	 from
	    i := 1
	 until
	    i > count
	 loop
	    Result.append_string(item(i).out)
	    i := i + 1
	 end
      end

   valid_utf8 (s: STRING): BOOLEAN is
	 -- is `s' a valid UTF8-representation.
	 --| this will not check all errors!
      require
	 string_exists: s /= void;
      local
	 i, code: INTEGER
      do
	 from
	    Result := true
	    i := 1
	 until
	    not Result or i > s.count
	 loop
	    code := s.item(i).code

	    if code < 128 then
	       i := i + 1
	    elseif code >= 192 and code <= 223 then
	       if i + 1 > count then
		  Result := false
	       else
		  i := i + 2
	       end
	    elseif code >= 224 and code <= 239 then
	       if i + 2 > count then
		  Result := false
	       else
		  i := i + 3
	       end
	    else
	       Result := false
	    end
	 end
      end

feature {UCSTRING} -- Implementation

   i_count:   INTEGER
	 -- string's length

   i_br: BASIC_ROUTINES is
      once
	 !!Result
      end

feature{UCSTRING}

   append_ucc_code(n: INTEGER) is
	 -- append single ucchar with code `n'
      require
	 is_unicode: 0 <= n and n <= 65535
      do
	 ensure_capacity(count+1)
         i_count := i_count + 1
         put_code(n, count)
      end

   is_whitespace (i: INTEGER): BOOLEAN is
	 -- is character with code `i' a whitespace?
      do
	 inspect i
	 when 32, 9, 10, 12, 13
	  then Result := true
	 else
	    Result := false
         end
      end

   is_digit (i: INTEGER): BOOLEAN is
	 -- is character with code `i' a digit?
      do
	 if i >= ('0').code and i <= ('9').code then
	    Result := true
         end
      end

   int_value (code: INTEGER): INTEGER is
	 -- return the value of integer `code'.
      require
	 is_digit: is_digit(code)
      do
	 Result := code - ('0').code
      end
            
invariant

   empty_definition       : empty = (count = 0);
   non_negative_count     : count >= 0;

end -- class UCSTRING
