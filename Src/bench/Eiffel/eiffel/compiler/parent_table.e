-- Parent table to generate

class PARENT_TABLE 

inherit
	ARRAY [CL_TYPE_I]
		rename
			make as array_make
		end;

creation
	make

feature 

	type_id: INTEGER;
			-- Static type to which the table belongs

	generic_count : INTEGER;
			-- Number of formal generic parameters

	classname : STRING;
			-- Name of class to which table belongs

	is_expanded : BOOLEAN;
			-- Is type expanded?

	make is 

		do
			array_make (1, Init_size)
			crnt_pos := 1
		end

	init (tid, gcount : INTEGER; cname : STRING; is_exp : BOOLEAN) is
			-- Initialization for id `tid' with `gcount' generics;
			-- Classname is `cname', `is_exp' is expandedness status.
		require
			positive_id: tid >= 0;
			meaningful_count: gcount >= 0
			valid_classname: cname /= Void
		do
			type_id := tid;
			generic_count := gcount
			classname := cname
			is_expanded := is_exp
			crnt_pos := 1
		ensure
			type_id_set: type_id = tid
			generic_count_set: generic_count = gcount
			classname_set: classname.is_equal (cname)
			expandedness_set: is_expanded = is_exp
			cursor_reset: crnt_pos = 1
		end;

	append_type (ptype : CL_TYPE_I) is
			-- Append type `ptype' to list of parent types.
		require
			valid_type: ptype /= Void
		do
			if crnt_pos > upper then
				resize (1, crnt_pos + Increment);
			end;

			put (ptype, crnt_pos);
			crnt_pos := crnt_pos + 1
		end;

	generate (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
			-- Generates the current parent table
		require
			valid_file: buffer /= Void
		local
			i, j, n : INTEGER;
			l_type_id: INTEGER
		do
			buffer.putstring ("static int16 ptf");

			l_type_id := type_id
			if l_type_id <= -256 then
				-- expanded
				l_type_id := -256 - l_type_id
			end

			buffer.putint (l_type_id);

			buffer.putstring ("[] = {%N");

			from
				i := 1;
				j := 1;
				n := crnt_pos;
			until
				i >= n
			loop
				item (i).generate_cid (buffer, final_mode, False);

				i := i + 1;
				j := j + 1;

				if (j \\ 16) = 0 then
					buffer.new_line
				end
			end;

			buffer.putint (-1);
			buffer.putstring ("};%N%Nstatic struct eif_par_types par");

			buffer.putint (l_type_id);

			buffer.putstring (" = {%"")
			buffer.putstring (classname)
			buffer.putstring ("%", ptf")

			buffer.putint (l_type_id);

			buffer.putstring (", (int16) ")
			buffer.putint (generic_count)
			buffer.putstring (", (char) ")

			if is_expanded then
				buffer.putstring ("1")
			else
				buffer.putstring ("0")
			end

			buffer.putstring ("};%N%N");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		local
			i, n: INTEGER;
		do
			-- Dynamic type associated to the table
			if type_id <= -256 then
				-- expanded
				ba.append_short_integer (-256-type_id);
			else
				ba.append_short_integer (type_id);
			end
			-- Number of formal generics
			ba.append_short_integer (generic_count)
			-- Classname
			ba.append_raw_string (classname)
			-- Expandedness
			if is_expanded then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

			from
				i := 1
				n := crnt_pos;
			until
				i >= n
			loop
				item (i).make_gen_type_byte_code (ba, False);
				i := i + 1
			end;

			-- End mark
			ba.append_short_integer (-1);
		end;

feature {NONE}  -- Implementation

	Init_size : INTEGER is 64
				-- Initial size of array
	Increment : INTEGER is 32
				-- Size increment

	crnt_pos : INTEGER
				-- Cursor position for appending data

end -- class PARENT_TABLE

