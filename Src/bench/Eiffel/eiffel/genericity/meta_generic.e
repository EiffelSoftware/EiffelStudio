class META_GENERIC

inherit

	ARRAY [TYPE_I]
		rename
			make as array_make
		end;
	SHARED_CODE_FILES
		undefine
			copy, setup, is_equal, consistent
		end

creation

	make

feature

	make (n: INTEGER) is
		do
			array_make (1, n);
		end;

	same_as (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			i, nb: INTEGER;
			local_copy: like Current
		do
			nb := count;
			Result := nb = other.count;
			from
				local_copy := Current
				i := 1;
			until
				i > nb or else not Result
			loop
				Result := local_copy.item (i).same_as (other.item (i));
				i := i + 1;
			end;
		end;

	is_valid: BOOLEAN is
			-- Are all the types valid ?
		local
			i, nb: INTEGER
			local_copy: like Current
		do
			from
				nb := count;
				local_copy := Current
				i := 1;
				Result := True
			until
				i > nb or else not Result
			loop
				Result := local_copy.item (i).is_valid;
				i := i + 1;
			end;
		end;

	generate_cecil_values (buffer: GENERATION_BUFFER) is
			-- Generate Cecil meta-types
		local
			i: INTEGER;
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				local_copy.item (i).generate_cecil_value (buffer);
				buffer.putstring (",%N");
				i := i + 1;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for cecil values
		require
			good_argument: ba /= Void
		local
			i: INTEGER;
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				ba.append_int32_integer (local_copy.item (i).cecil_value);
				i := i + 1
			end
		end;

end
