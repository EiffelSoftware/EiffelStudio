-- Table of execution units (either C routines or byte code arrays)

class EXECUTION_TABLE 

inherit

	CENTRAL_TABLE [EXECUTION_UNIT]
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end
	SHARED_SERVER
		undefine
			copy, setup, consistent, is_equal
		end
	SHARED_BODY_ID
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature -- Initialization

	make is
			-- Create a new execution table.
		do
			init
			!! counter.make
		end

	counter: REAL_BODY_ID_COUNTER
			-- Counter for real body id

feature -- Refreezing

	frozen_level: INTEGER is
			-- Melted/Frozen limit
		do
			Result := counter.frozen_level
		end

	set_frozen_level (level: INTEGER) is
			-- Set `frozen_level' to `level'.
		do
			counter.set_frozen_level (level)
		end

	dle_frozen_level: INTEGER is
			-- Melted/Frozen limit in the DC-set
		do
			Result := counter.dle_frozen_level
		end

	set_dle_frozen_level (level: INTEGER) is
			-- Set `dle_frozen_level' to `level'.
		do
			counter.set_dle_frozen_level (level)
		end

feature 

	make_update (file: RAW_FILE) is
			-- Generate byte code for updating the execution table
		local
			e: EXECUTION_UNIT
			real_body_id: REAL_BODY_ID
			melted_feature: MELT_FEATURE
		do
				-- First write the count of the byte code table
			write_int (file.file_pointer, counter.total_count - frozen_level)
debug
	io.error.putstring ("Updating execution_table%NCount: ")
	io.error.putint (counter.total_count - frozen_level)
	io.error.new_line
	io.error.putstring ("Frozen level: ")
	io.error.putint (frozen_level)
	io.error.new_line
end

			from
				melted_list.start
			until
				melted_list.after
			loop
				e := melted_list.item
				if e.is_valid then
					real_body_id := e.real_body_id
					check
							-- Very important check
						is_melted: real_body_id.id > frozen_level
					end
					melted_feature := M_feature_server.item (real_body_id)
						-- Write the body id
					write_int
						(file.file_pointer, real_body_id.id - frozen_level - 1)
						-- Write the size
					write_int (file.file_pointer, melted_feature.size)
						-- Write the pattern id
					write_int (file.file_pointer, e.real_pattern_id)
						-- Write the byte code
					melted_feature.store (file)

debug
	io.error.putstring ("Item written%N")
end

					melted_list.forth
				else
					melted_list.remove
				end
			end;	
				-- End of execution table update
			write_int (file.file_pointer, -1)
		end

	generate (file: INDENT_FILE) is
			-- Generate the frozen execution table in `file'.
		require
			good_argument: file /= Void
			is_open: file.is_open_write
		local
			values: ARRAY [EXECUTION_UNIT]
			unit: EXECUTION_UNIT
			i, nb: INTEGER
			temp: STRING
		do
			from
				nb := counter.total_count
				!!values.make (1, nb)
				start
			until
				after
			loop
				unit := item_for_iteration
				values.put (unit, unit.index.id)
				forth
			end

				-- Generation
			from
				!! include_set.make
				include_set.compare_objects
				i := 1
				file.putstring ("#include %"eif_project.h%"%N%
								%#include %"eif_macros.h%"%N%
								%#include %"eif_struct.h%"%N%N")
			until
				i > nb
			loop
				unit := values.item (i)
				if unit /= Void and then unit.is_valid then
					unit.generate_declaration (file)
				end
				i := i + 1
			end

				-- Generate the include files associated with
				-- external features not encapsulated but with a list
				-- of include files (assuming the definition of the feature
				-- is in one of the include files)
			from
				include_set.start
			until
				include_set.after
			loop
				file.putstring ("#include ")
				file.putstring (include_set.item)

				file.putstring ("%N%N")
				include_set.forth
			end
			include_set := Void

			from
				file.new_line
				!!temp.make (0)
				i := 1
				temp.append ("%Nint egc_fpatidtab_init[] = {%N")
				file.putstring ("fnptr egc_frozen_init[] = {%N")
			until
				i > nb
			loop
				unit := values.item (i)
				if unit /= Void and then unit.is_valid then
					unit.generate (file)
					temp.append_integer (unit.real_pattern_id)
					temp.append (",%N")
				else
					file.putstring ("(char *(*)()) 0,%N")
					temp.append ("-1,%N")
				end
				i := i + 1
			end
			file.putstring ("};%N")
			temp.put ('%N', temp.count - 1)
			temp.put ('}', temp.count)
			temp.append (";%N")
			file.putstring (temp)
		end

feature {EXT_INCL_EXEC_UNIT} -- Include set

	include_set: LINKED_SET [STRING]

feature -- Debugging

	reset_debug_counter is
			-- Reset `debug_counter' and `dle_debug_counter'.
		do
			counter.reset_debug_counter
		end

	debuggable_body_id (old_id: REAL_BODY_ID): REAL_BODY_ID is
			-- New body id for debuggable byte arrays
		do
			Result := counter.debuggable_body_id (old_id)
		end

feature -- DLE

	dle_level: INTEGER is
			-- Limit between static and dynamic system
		do
			Result := counter.dle_level
		end

	set_levels is
			-- Keep track of the different levels after each compilation
		do
			counter.set_levels
			reset_debug_counter
		end

	make_melted_dle (file: RAW_FILE) is
			-- Generate byte code for updating the execution table
			-- for the Dynamic Class Set.
		require
			dynamic_system: System.is_dynamic
		local
			e: EXECUTION_UNIT
			real_body_id: REAL_BODY_ID
			melted_feature: MELT_FEATURE
		do
				-- First write the count of the byte code table
			write_int (file.file_pointer, counter.total_count - dle_frozen_level)
debug ("DLE ACTIVITY", "DLE SPY")
	io.error.putstring ("Updating execution_table%NCount: ")
	io.error.putint (counter.total_count - dle_frozen_level)
	io.error.new_line
	io.error.putstring ("Frozen level: ")
	io.error.putint (frozen_level)
	io.error.new_line
	io.error.putstring ("DLE level: ")
	io.error.putint (dle_level)
	io.error.new_line
	io.error.putstring ("DLE frozen level: ")
	io.error.putint (dle_frozen_level)
	io.error.new_line
end

			from
				melted_list.start
			until
				melted_list.after
			loop
				e := melted_list.item
				if e.is_valid then
					real_body_id := e.real_body_id
					check
							-- Very important check
						is_melted: real_body_id.id > dle_frozen_level
					end
					melted_feature := M_feature_server.item (real_body_id)
						-- Write the body id
					write_int
						(file.file_pointer, real_body_id.id - dle_frozen_level -1)
						-- Write the size
					write_int (file.file_pointer, melted_feature.size)
						-- Write the pattern id
					write_int (file.file_pointer, e.real_pattern_id)
						-- Write the byte code
					melted_feature.store (file)

debug
	io.error.putstring ("Item written%N")
end

					melted_list.forth
				else
					melted_list.remove
				end
			end;	
				-- End of execution table update
			write_int (file.file_pointer, -1)
		end

	generate_dle (file: INDENT_FILE) is
			-- Generate the frozen execution table for the Dynamic Class Set.
		require
			dynamic_system: System.is_dynamic
			good_argument: file /= Void
			is_open: file.is_open_write
		local
			values: ARRAY [EXECUTION_UNIT]
			unit: EXECUTION_UNIT
			i, nb: INTEGER
			temp: STRING
		do
			from
				nb := counter.total_count
				!!values.make (1, nb)
				start
			until
				after
			loop
				unit := item_for_iteration
				values.put (unit, unit.index.id)
				forth
			end

				-- Generation
			from
				!! include_set.make
				include_set.compare_objects
				i := nb - counter.current_count + 1
				file.putstring ("#include %"eif_struct.h%"%N%
								%#include %"eif_macros.h%"%N%N")
			until
				i > nb
			loop
				unit := values.item (i)
				if unit /= Void and then unit.is_valid then
					unit.generate_declaration (file)
				end
				i := i + 1
			end

				-- Generate the include files associated with
				-- external features not encapsulated but with a list
				-- of include files (assuming the definition of the feature
				-- is in one of the include files)
			from
				include_set.start
			until
				include_set.after
			loop
				file.putstring ("#include ")
				file.putstring (include_set.item)
				file.putstring ("%N%N")
				include_set.forth
			end
			include_set := Void

			from
				file.new_line
				!!temp.make (0)
				i := nb - counter.current_count + 1
				temp.append ("%Nstatic int Dfpatidtab[] = {%N")
				file.putstring ("static fnptr Dfrozen[] = {%N")
			until
				i > nb
			loop
				unit := values.item (i)
				if unit /= Void and then unit.is_valid then
					unit.generate (file)
					temp.append_integer (unit.real_pattern_id)
					temp.append (",%N")
				else
					file.putstring ("(char *(*)()) 0,%N")
					temp.append ("-1,%N")
				end
				i := i + 1
			end
			file.putstring ("};%N")
			temp.put ('%N', temp.count - 1)
			temp.put ('}', temp.count)
			temp.append (";%N")
			file.putstring (temp)

			file.new_line
			file.putstring ("void dle_efrozen(void) {")
			file.new_line
			file.indent
			file.putstring ("dle_zeroc = ")
			file.putint (dle_frozen_level)
			file.putchar (';')
			file.new_line
			file.putstring ("dle_frozen = Dfrozen - ")
			file.putint (dle_level)
			file.putchar (';')
			file.new_line
			file.putstring ("dle_fpatidtab = Dfpatidtab - ")
			file.putint (dle_level)
			file.putchar (';')
			file.new_line
			file.exdent
			file.putchar ('}')
			file.new_line
		end

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
		end

end
