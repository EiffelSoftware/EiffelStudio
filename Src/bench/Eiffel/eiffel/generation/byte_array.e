-- Byte array

class BYTE_ARRAY 

inherit

	CHARACTER_ARRAY
		rename
			make as basic_make
		end;
	SHARED_SIZE
		export
			{NONE} all
		end;
	SHARED_C_LEVEL
		export
			{NONE} all
		end;
	BYTE_CONST
		export
			{NONE} all
		end;

creation

	make

	
feature 

	position: INTEGER
			-- Posiiton of the cursor in the array

	last_string: STRING
			-- Last string read by `last_string'.

	last_long_integer: INTEGER
			-- Last long integer read by `read_long_integer'.

	last_short_integer: INTEGER
			-- Last short integer read by `read_short_integer'.

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			pos_large_enough: i > 0
			pos_small_enough: i <= size
		do
			position := i
		end

	make is
			-- Initialization
		do
			basic_make (Chunk)
			position := 1
			!!forward_marks.make
			!!forward_marks2.make
			!!forward_marks3.make
			!!forward_marks4.make
			!!backward_marks.make
			!!sep_backward_marks.make
		end

	Chunk: INTEGER is 5000
			-- Chunk array

	clear is
			-- Clear the structure
		do
			position := 1
			last_string := Void
			last_long_integer := 0
			last_short_integer := 0
			retry_position := 0
			ca_zero ($area, size)
		end

	character_array: CHARACTER_ARRAY is
			-- Simple character array
		local
			other_area: like area;
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	feature_table: MELTED_FEATURE_TABLE is
			-- Melted feature table
		local
			other_area: like area;
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	melted_feature: MELT_FEATURE is
			-- Melted feature
		local
			other_area: like area
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	melted_descriptor: MELTED_DESC is
			-- Melted descriptor
		local
			other_area: like area
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	melted_routine_table: MELTED_ROUT_TABLE is
			-- Melted routine table
		local
			other_area: like area
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	melted_routid_array: MELTED_ROUTID_ARRAY is
			-- Melted routine id array
		local
			other_area: like area
		do
			!!Result.make (position - 1);
			other_area := Result.area;
			ca_copy ($area, $other_area, position - 1, 0);
		end;

	append (c: CHARACTER) is
			-- Append `c' in the array
		local
			new_position: INTEGER
		do
			new_position := position + 1;
			if new_position > size then
				resize (size + Chunk);
			end;
			put (c, position);
			position := new_position;
		end;

	append_boolean (b: BOOLEAN) is
			-- Append boolean `b' in array.
		do
			if b then
				append ('%/001/')
			else
				append ('%U')
			end
		end

	append_integer (i: INTEGER) is
			-- Append long integer `i' in the array
		local
			new_position: INTEGER
		do
			new_position := position + Int32_size;
			if new_position > size then
				resize (size + Chunk);
			end;
			ca_wlong ($area, i, position - 1);
			position := new_position;
		end;

	append_short_integer (i: INTEGER) is
			-- Append short integer `i' in the array
		local
			new_position: INTEGER
		do  
			new_position := position + Short_size;
			if new_position > size then
				resize (size + Chunk);
			end;
			ca_wshort ($area, i, position - 1);
			position := new_position;
		end;

	append_uint32_integer (i: INTEGER) is
			-- Append unsigned 32 bits integer in the array
		local
			new_position: INTEGER
		do 
			new_position := position + Uint32_size;
			if new_position > size then
				resize (size + Chunk);
			end;
			ca_wuint32 ($area, i, position - 1);
			position := new_position;
		end;

	append_int32_integer (i: INTEGER) is
			-- Append signed 32 bits integer in the array
		
		local
			new_position: INTEGER
		do 
			new_position := position + Int32_size;
			if new_position > size then
				resize (size + Chunk);
			end;
			ca_wint32 ($area, i, position - 1);
			position := new_position;
		end;

	append_real (r: DOUBLE) is
			-- Append real value `r'.
		local
			new_position: INTEGER
		do
			new_position := position + Double_size;
			if new_position > size then
				resize (size + Chunk);
			end;
			ca_wdouble ($area, r, position - 1);
			position := new_position;
		end;

	append_string (s: STRING) is
			-- Append string `s'.
		require
			good_argument: s /= Void;
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := s.count;
					-- First write the string count
				append_short_integer (nb);
			until
				i > nb
			loop
				append (s.item (i));
				i := i + 1;
			end;
		end;

	append_bit (s: STRING) is
			-- Append bit which string value is `s'.
		local
			nb_uint32, new_position, bcount: INTEGER;
			ptr: ANY;
		do
				-- Append number of uint32 integers needed
				-- for representing the bit value `s'
			bcount := s.count;
			append_uint32_integer (bcount);

				-- Resize if necessary
			nb_uint32 := ca_bsize(bcount);
			new_position := position + nb_uint32 * Uint32_size;
			if new_position > size then
				resize ((new_position \\ Chunk + 1) * Chunk)
			end;
				
				-- Write bit representation in `area'
			ptr := s.to_c;
			ca_wbit ($area, $ptr, position - 1, s.count);
			position := new_position;
		end;

	append_raw_string (s: STRING) is
			-- Append string `s'.
		require
			good_argument: s /= Void
		local
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := s.count;
			until
				i > nb
			loop
				append (s.item (i));
				i := i + 1;
			end;
			append ('%U');
		end;

	allocate_space (t: TYPE_I) is
			-- Allocate space for meta-type `t'.
		require
			good_argument: t /= Void
		local
			new_position: INTEGER;
		do
			inspect
				t.c_type.level
			when C_char then
				new_position := position + Char_size;
			when C_int8 then
				new_position := position + Int8_size;
			when C_int16, C_wide_char then
				new_position := position + Int16_size;
			when C_int32 then
				new_position := position + Int32_size;
			when C_int64 then
				new_position := position + Int64_size;
			when C_float then
				new_position := position + Float_size;
			when C_double then
				new_position := position + Double_size;
			when C_pointer then
				new_position := position + Pointer_size;
			when C_ref then
				new_position := position + Reference_size;
			else
					-- Void type
				new_position := position;
			end;
			if new_position > size then
				resize (size + Chunk);
			end;
			position := new_position;
		end;

feature -- Forward and backward jump managment

	forward_marks: EXTEND_STACK [INTEGER];
			-- Forward jump stack

	mark_forward is
			-- Mark a forward offset
		do
			forward_marks.put (position);
			append_integer (0);
		end;

	write_forward is
			-- Write Current position at previous mark
		local
			pos: INTEGER;
		do
			pos := position;
			position := forward_marks.item;
			forward_marks.remove;
			append_integer (pos - position - Int32_size);
			position := pos;
		end;

	forward_marks2: EXTEND_STACK [INTEGER];
			-- Forward jump stack

	
	mark_forward2 is
			-- Mark a forward offset
		do
			forward_marks2.put (position);
			append_integer (0);
		end;

	write_forward2 is
			-- Write Current position at previous mark
		local
			pos: INTEGER;
		do
			pos := position;
			position := forward_marks2.item;
			forward_marks2.remove;
			append_integer (pos - position - Int32_size);
			position := pos;
		end;

	forward_marks3: EXTEND_STACK [INTEGER];
			-- Forward jump stack

	mark_forward3 is
			-- Mark a forward offset
		do
			forward_marks3.put (position);
			append_integer (0);
		end;

	write_forward3 is
			-- Write Current position at previous mark
		local
			pos: INTEGER;
		do
			pos := position;
			position := forward_marks3.item;
			forward_marks3.remove;
			append_integer (pos - position - Int32_size);
			position := pos;
		end;

	forward_marks4: EXTEND_STACK [INTEGER];
			-- Forward jump stack
 
	mark_forward4 is
			-- Mark a forward offset
		do
			forward_marks4.put (position);
			append_integer (0);
		end;

	write_forward4 is
			-- Write Current position at previous mark
		local
			pos: INTEGER;
		do
			pos := position;
			position := forward_marks4.item;
			forward_marks4.remove;
			append_integer (pos - position - Int32_size);
			position := pos;
		end;

	backward_marks: EXTEND_STACK [INTEGER];
			-- Backward jump stack

	mark_backward is
			-- Mark a backward offset
		do
			backward_marks.put (position);
		end;

	write_backward is
			-- Write a backward jump
		do
			append_integer (- position - Int32_size + backward_marks.item);
			backward_marks.remove;
		end;

	retry_position: INTEGER;
			-- Retry position

	mark_retry is
			-- Record retry position
		do
			retry_position := position;
		end;

	write_retry is
			-- Write a retry offset
		do
			append_integer (- position - Int32_size + retry_position);
		end;

	prepend (other: BYTE_ARRAY) is
			-- Prepend `other' before in Current
		local
			new_size, old_pos, new_pos, other_position: INTEGER;
			other_area, buffer_area: like area;
		do
			old_pos := position;
			other_position := other.position;
			if old_pos >= Buffer.size then
				new_size := Chunk * ((old_pos // Chunk) + 1);
				Buffer.resize (new_size);
			end;
			buffer_area := Buffer.area;
			ca_copy ($area, $buffer_area, old_pos - 1, 0);
			new_pos := old_pos + other_position - 1;
			if new_pos > size then
				new_size := Chunk * ((new_pos // Chunk) + 1);
				resize (new_size);
			end;
			other_area := other.area;
			ca_copy ($other_area, $area, other_position - 1, 0);
			ca_copy ($buffer_area, $area, old_pos - 1, other_position - 1);
			position := new_pos;
		end;

	Buffer: BYTE_ARRAY is
			-- Prepend buffer
		once
			!!Result.make;
		end;

feature {NONE} -- Externals

	ca_zero (ptr: POINTER; siz: INTEGER) is
		external
			"C"
		alias
			"ca_zero"
		end;

	Short_size: INTEGER is
			-- Size of a short integer
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(short)"
		end

	Uint32_size: INTEGER is
			-- Size of uint32 type
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"sizeof(uint32)"
		end

	ca_wint32 (ptr: POINTER; val: INTEGER; pos: INTEGER) is
		external
			"C"
		end;

	ca_wuint32 (ptr: POINTER; val: INTEGER; pos: INTEGER) is
		external
			"C"
		end;

	ca_wshort (ptr: POINTER; val: INTEGER; pos: INTEGER) is
		external
			"C"
		end;

	ca_wlong (ptr: POINTER; val: INTEGER; pos: INTEGER) is
		external
			"C"
		end;

	ca_wdouble (ptr: POINTER; val: DOUBLE; pos: INTEGER) is
		external
			"C"
		end;

	ca_bsize (bit_count: INTEGER): INTEGER is
			-- Number of uint32 fields for encoding a bit of length `bit_count'
		external
			"C [macro %"eif_eiffel.h%"] (long int): EIF_INTEGER"
		alias
			"BIT_NBPACK"
		end;

	ca_wbit(ptr: POINTER; val: POINTER; pos: INTEGER; bit_count: INTEGER) is
			-- Write in `ptr' at position `pos' a bit value `val'
		external
			"C"
		end;

feature -- Debugger

	generate_melted_debugger_hook(lnr: INTEGER) is
			-- Write continue mark (where breakpoint may be set).
			-- lnr is the current breakable line number index.
		do
			append (Bc_hook)
			append_integer (lnr)
		end

	generate_melted_debugger_hook_nested(lnr: INTEGER) is
			-- Write continue mark (where breakpoint may be set).
			-- lnr is the current breakable line number index (nested call).
		do
			append (Bc_nhook)
			append_integer (lnr)
		end

feature -- Concurrent Eiffel
 
       sep_backward_marks: EXTEND_STACK [INTEGER];
		      -- Backward jump stack
 
       sep_mark_backward is
		       -- Mark a backward offset
	       do
		      sep_backward_marks.put (position);
	       end;
 
       sep_write_backward is
		       -- Write a backward jump
	       do
		       append_integer (- position - Int32_size + sep_backward_marks.item);
		       sep_backward_marks.remove;
			end

invariant

	position_greater_than_zero: position > 0;
	position_less_than_size: position <= size;

end
