-- Conformance table to generate

class CONFORM_TABLE 

inherit

	ARRAY [BOOLEAN]
		rename
			make as array_make
		end;
	SHARED_CODE_FILES
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		undefine
			copy, setup, consistent, is_equal
		end;
	BASIC_ROUTINES
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature 

	type_id: INTEGER;
			-- Type id: static type of the conformance table

	max_type_id: INTEGER;
			-- Max type id marked

	min_type_id: INTEGER;
			-- Minimum type id

	Char_size: INTEGER is 8;
			-- Assertion is done that a character is at least encoded
			-- on 8 bits.

	make (n: INTEGER) is
			-- Initialization
		do
			array_make (1, n);
		end;

	init (i: INTEGER) is
			-- Initialization to size `i'.
		require
			positive_argument: i > 0;
		do
			type_id := i;
			min_type_id := Char_size * ((i - 1) // Char_size) + 1;
			max_type_id := Char_size * (((i - 1) // Char_size) + 1);
			resize (min_type_id, max_type_id);
			clear_all;
		end;

	mark (i: INTEGER) is
			-- Mark conformance table.
		require
			index_large_enough: i >= lower;
		do
			if i > max_type_id then
				max_type_id := Char_size * (((i - 1) // Char_size) + 1);
				resize (min_type_id, max_type_id);
			elseif i < min_type_id then
				min_type_id := Char_size * ((i - 1) // Char_size) + 1;
				resize (min_type_id, max_type_id);
			end;
			put (True, i);
		end;

	generate (conformance_file: INDENT_FILE) is
			-- Generates the current conformance table
		require
			Conformance_file.is_open_write;
			min_type_id \\ Char_size = 1;
			max_type_id \\ Char_size = 0;
		local
			i, nb, j, val: INTEGER;
			local_copy: like Current
		do
debug
Conformance_file.putstring ("/* Conformance table for ");
System.class_type_of_id (type_id).type.dump (Conformance_file);
Conformance_file.putstring (" [");
Conformance_file.putint (type_id);
Conformance_file.putstring ("] */%N");
end;
			Conformance_file.putstring ("static char ctf");
			Conformance_file.putint (type_id);
			Conformance_file.putstring ("[] = {%N");
			from
				local_copy := Current
				i := min_type_id;
				nb := max_type_id;
			until
				i > nb
			loop
				val := 0;
				if local_copy.item (i) 	then val := 128;		end;
				if local_copy.item (i + 1) then val := val + 64; 	end;
				if local_copy.item (i + 2) then val := val + 32; 	end;
				if local_copy.item (i + 3) then val := val + 16; 	end;
				if local_copy.item (i + 4) then val := val + 8; 	end;
				if local_copy.item (i + 5) then val := val + 4; 	end;
				if local_copy.item (i + 6) then val := val + 2;	end;
				if local_copy.item (i + 7) then val := val + 1;	end;
				Conformance_file.putstring ("(char) ");
				Conformance_file.putint (val);
				Conformance_file.putstring (",%N");
				i := i + Char_size;
			end;
			Conformance_file.putstring ("};%N%Nstatic struct conform conf");
			Conformance_file.putint (type_id);
			Conformance_file.putstring (" = {(int16) ");
			Conformance_file.putint (min_type_id - 1);
			Conformance_file.putstring (",(int16) ");
			Conformance_file.putint (max_type_id - 1);
			Conformance_file.putstring (", ctf");
			Conformance_file.putint (type_id);
			Conformance_file.putstring ("};%N%N");
			
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		require
			min_type_id \\ Char_size = 1;
			max_type_id \\ Char_size = 0;
		local
			val, i, nb: INTEGER;
			local_copy: like Current
		do		
				-- Dynamic type associated to the table
			ba.append_short_integer (type_id - 1);
				-- Min type id of the table
			ba.append_short_integer (min_type_id - 1);
				-- Max type id of the table
			ba.append_short_integer (max_type_id - 1);
			from
				local_copy := Current
				i := min_type_id;
				nb := max_type_id;
			until
				i > nb
			loop
				val := 0;
				if local_copy.item (i)	 then val := 128;			end;
				if local_copy.item (i + 1) then val := val + 64;   end;
				if local_copy.item (i + 2) then val := val + 32;   end;
				if local_copy.item (i + 3) then val := val + 16;   end;
				if local_copy.item (i + 4) then val := val + 8;	end;
				if local_copy.item (i + 5) then val := val + 4;	end;
				if local_copy.item (i + 6) then val := val + 2;	end;
				if local_copy.item (i + 7) then val := val + 1;	end;
				ba.append (charconv(val));
				i := i + Char_size;
			end;
		end;

end
