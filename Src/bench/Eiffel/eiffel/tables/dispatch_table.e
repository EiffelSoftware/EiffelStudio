-- Dispatch table: table fo correspondance between body indexes and
-- body ids

class DISPATCH_TABLE 

inherit
	CENTRAL_TABLE [DISPATCH_UNIT]
		redefine
			append
		end

	SHARED_SERVER
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make
	
feature -- Initialization

	make is
			-- Create a new dispatch table.
		do
			init
			!! counter.make
		end

	counter: REAL_BODY_INDEX_COUNTER
			-- Counter for real body index
			
feature 

	real_body_index (body_index: BODY_INDEX; class_type: CLASS_TYPE): REAL_BODY_INDEX is
			-- Real body index associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type `class_type'.
		local
			unit: DISPATCH_UNIT
		do
			unit := unit_of_body_index (body_index, class_type)
			if not (unit = Void) then
				Result := unit.real_body_index
			end
		end

feature {NONE} -- Search

	unit_of_body_index (body_index: BODY_INDEX; class_type: CLASS_TYPE): DISPATCH_UNIT is
			-- Unit associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type `class_type'.
		do
			Marker.set_body_index (body_index)
			Marker.set_class_type (class_type)
			Result := item (Marker)
		end

	Marker: DISPATCH_UNIT is
			-- Marker for search
		local
			f: DYN_PROC_I
			bi: BODY_INDEX
		once
			!!f
			!! bi.make (1)
			f.set_body_index (bi)
			!!Result.make (System.class_type_of_id (1), f)
		end

feature -- Refreezing

	frozen_level: INTEGER
			-- Melted/Frozen limit

	set_frozen_level (level: INTEGER) is
			-- Set `frozen_level' to `level'.
		do
			frozen_level := level
		end

feature -- Merging

	append (other: like Current) is
			-- Append  `other' to `Current'.
			-- Used when merging precompilations.
		do
			{CENTRAL_TABLE} precursor (other)
			frozen_level := counter.total_count
		end

feature	-- Melting and C Generation

	make_update (file: RAW_FILE) is
			-- Generate byte code for updating the dispatch table
		
				-- 2.3 PATCH: dump long integer `v' in file `f'	
		local
			u: DISPATCH_UNIT
		do
debug
	io.error.putstring ("Updating dispatch_table%NCount: ")
	io.error.putint (counter.total_count)
	io.error.new_line
end
debug ("DLE SPY")
	io.error.putstring ("Updating dispatch_table%NCount: ")
	io.error.putint (counter.total_count)
	io.error.new_line
end

			from
				melted_list.start
			until
				melted_list.after
			loop
				u := melted_list.item
				if u.is_valid then
debug ("DLE SPY")
io.error.put_string ("%Tstatic type #")
io.error.put_integer (u.class_type.id.id)
io.error.put_string (", dtype #")
io.error.put_integer (u.class_type.type_id)
io.error.new_line
io.error.put_string ("%Tbody_index #")
io.error.put_integer (u.real_body_index.id - 1)
io.error.put_string (", body_id #")
io.error.put_integer (u.real_body_id.id - 1)
io.error.new_line
end
					write_int (file.file_pointer, u.real_body_index.id - 1)
					write_int (file.file_pointer, u.real_body_id.id - 1)
debug
	io.error.putstring ("Item written%N")
end
					melted_list.forth
				else
					melted_list.remove
				end
			end
				-- End of update for the dispatch table
			write_int (file.file_pointer, -1)
		end

	write_dispatch_count (file: RAW_FILE) is
			-- Write the size of dispatch table on `file'.
		do
			write_int (file.file_pointer, counter.total_count)
		end

	generate (file: INDENT_FILE) is
			-- Generate the dispatch table in `file'.
		require
			good_argument: file /= Void
			is_open: file.is_open_write
		local
			values: ARRAY [INTEGER]
			unit: DISPATCH_UNIT
			i, nb: INTEGER
		do
			from
				nb := counter.total_count
				!!values.make (1, nb)
				start
			until
				after
			loop
				unit := item_for_iteration
				if unit.is_valid then
					values.put (unit.real_body_id.id - 1, unit.real_body_index.id)
				end
				forth
			end
			from
				i := 1
				file.putstring ("#include %"eif_portable.h%"%N%N")
				file.putstring ("uint32 egc_fdispatch_init[] = {%N")
			until
				i > nb
			loop
				file.putstring ("(uint32) ")
				file.putint (values.item (i))
				file.putchar (',')
				file.new_line
				i := i + 1
			end
			file.putstring ("};%N")
		end

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
		end

end
