class META_GENERIC

inherit

	ARRAY [TYPE_I]
		rename
			make as array_make
		end;
	SHARED_CODE_FILES
		undefine
			twin
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
		do
			nb := count;
			Result := nb = other.count;
			from
				i := 1;
			until
				i > nb or else not Result
			loop
				Result := item (i).same_as (other.item (i));
				i := i + 1;
			end;
		end;

	is_valid: BOOLEAN is
			-- Are all the types valid ?
		local
			i, nb: INTEGER
		do
			from
				nb := count;
				i := 1;
				Result := True
			until
				i > nb or else not Result
			loop
				Result := item (i).is_valid;
				i := i + 1;
			end;
		end;

	generate_cecil_values (f: UNIX_FILE) is
			-- Generate Cecil meta-types
		local
			i: INTEGER;
		do
			from
				i := lower
			until
				i > upper
			loop
				item (i).generate_cecil_value (f);
				f.putstring (",%N");
				i := i + 1;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for cecil values
		require
			good_argument: ba /= Void
		local
			i: INTEGER;
		do
			from
				i := lower
			until
				i > upper
			loop
				ba.append_int32_integer (item (i).sk_value);
				i := i + 1
			end
		end;

end
