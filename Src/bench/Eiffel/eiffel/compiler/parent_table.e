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

	generate (parents_file : INDENT_FILE; final_mode : BOOLEAN) is
			-- Generates the current parent table
		require
			valid_file: parents_file /= Void
			is_open_write: parents_file.is_open_write;
		local
			i, j, n : INTEGER;
		do
			parents_file.putstring ("static int16 ptf");
			parents_file.putint (type_id);
			parents_file.putstring ("[] = {%N");

			from
				i := 1;
				j := 1;
				n := crnt_pos;
			until
				i >= n
			loop
				parents_file.putstring (item (i).gen_type_string (final_mode, false));

				i := i + 1;
				j := j + 1;

				if (j \\ 8) = 0 then
					parents_file.put_string ("%N")
				end
			end;

			parents_file.putint (-1);
			parents_file.putstring ("};%N%Nstatic struct eif_par_types par");
			parents_file.putint (type_id);
			parents_file.putstring (" = {(int16) ");
			parents_file.putint (generic_count);
			parents_file.putstring (", %"");
			parents_file.putstring (classname);

			if is_expanded then
				parents_file.putstring ("%", (char)1, ptf");
			else
				parents_file.putstring ("%", (char)0, ptf");
			end

			parents_file.putint (type_id);
			parents_file.putstring ("};%N%N");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code
		local
			i, n: INTEGER;
		do
			-- Dynamic type associated to the table
			ba.append_short_integer (type_id);
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
				item (i).make_gen_type_byte_code (ba, false);
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

