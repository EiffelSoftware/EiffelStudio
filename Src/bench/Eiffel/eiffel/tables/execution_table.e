-- Table of execution units (either C routines or byte code arrays)

class EXECUTION_TABLE 

inherit

	CENTRAL_TABLE [EXECUTION_UNIT];
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_SERVER
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_BODY_ID
		undefine
			copy, setup, consistent, is_equal
		end;

creation

	init

	
feature 

	make_update (file: RAW_FILE) is
			-- Generate byte code for updating the execution table
		local
			e: EXECUTION_UNIT;
			real_body_id: INTEGER;
			melted_feature: MELT_FEATURE;
		do
				-- First write the count of the byte code table
			write_int (file.file_pointer, counter - frozen_level);
debug
	io.error.putstring ("Updating execution_table%NCount: ");
	io.error.putint (counter-frozen_level);
	io.error.new_line;
	io.error.putstring ("Frozen level: ");
	io.error.putint (frozen_level);
	io.error.new_line;
end;

			from
				melted_list.start
			until
				melted_list.after
			loop
				e := melted_list.item;
				if e.is_valid then
					real_body_id := e.real_body_id;
					check
							-- Very important check
						is_melted: real_body_id > frozen_level
					end;
					melted_feature := M_feature_server.item (real_body_id);
						-- Write the body id
					write_int
						(file.file_pointer, real_body_id - frozen_level - 1);
						-- Write the size
					write_int (file.file_pointer, melted_feature.size);
						-- Write the pattern id
					write_int (file.file_pointer, e.real_pattern_id);
						-- Write the byte code
					melted_feature.store (file);

debug
	io.error.putstring ("Item written%N");
end;

					melted_list.forth;
				else
					melted_list.remove;
				end;
			end;	
				-- End of execution table update
			write_int (file.file_pointer, -1);
		end;

	generate (file: INDENT_FILE) is
			-- Generate the frozen execution table in `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		local
			values: ARRAY [EXECUTION_UNIT];
			unit: EXECUTION_UNIT;
			i, nb: INTEGER;
			temp: STRING
		do
			from
				nb := counter;
				!!values.make (1, nb);
				start
			until
				after
			loop
				unit := item_for_iteration;
				values.put (unit, unit.index);
				forth;
			end;

				-- Generation
			from
				!! include_set.make;
				include_set.compare_objects;
				i := 1;
				file.putstring ("#include %"struct.h%"%N%N");
			until
				i > nb
			loop
				unit := values.item (i);
				if unit /= Void and then unit.is_valid then
					unit.generate_declaration (file);
				end;
				i := i + 1;
			end;

				-- Generate the include files associated with
				-- external features not encapsulated but with a list
				-- of include files (assuming the definition of the feature
				-- is in one of the include files)
			from
				include_set.start
			until
				include_set.after
			loop
				file.putstring ("#include ");
				file.putstring (include_set.item);
				file.putstring ("%N%N");
				include_set.forth
			end
			include_set := Void;

			from
				file.new_line;
				!!temp.make (0);
				i := 1;
				temp.append ("%Nint fpatidtab[] = {%N");
				file.putstring ("fnptr frozen[] = {%N")
			until
				i > nb
			loop
				unit := values.item (i);
				if unit /= Void and then unit.is_valid then
					unit.generate (file);
					temp.append_integer (unit.real_pattern_id);
					temp.append (",%N");
				else
					file.putstring ("(fnptr) 0,%N");
					temp.append ("-1,%N");
				end;
				i := i + 1;
			end;
			file.putstring ("};%N");
			temp.put ('%N', temp.count - 1);
			temp.put ('}', temp.count);
			temp.append (";%N");
			file.putstring (temp);
		end;

feature {EXT_INCL_EXEC_UNIT} -- Include set

	include_set: LINKED_SET[STRING];

feature -- Debugging

	debug_counter: COUNTER is
			-- Counter used to generate real body
			-- id's for debuggable byte arrays of the static system.
		once
			!!Result;
			Result.set_value (debug_level)
		end;

	dle_debug_counter: COUNTER is
			-- Counter used to generate real body
			-- id's for debuggable byte arrays of the dynamic system.
		once
			!!Result;
			Result.set_value (dle_debug_level)
		end;

	reset_debug_counter is
			-- Reset `debug_counter' and `dle_debug_counter'.
		do
			debug_counter.set_value (debug_level);
			dle_debug_counter.set_value (dle_debug_level)
		end;

	debuggable_body_id (old_id: INTEGER): INTEGER is
			-- New body id for debuggable byte arrays
		do
			if old_id <= frozen_level then
					-- The routine was frozen in the static system.
					-- Generate a new id in the static melted area.
				Result := debug_counter.next
			elseif old_id > dle_level and old_id <= dle_frozen_level then
					-- The routine was frozen in the dynamic system.
					-- Generate a new id in the dynamic melted area.
				Result := dle_debug_counter.next
			else
					-- The routine was melted either in the static or
					-- dynamic system. Keep the same id.
				Result := old_id
			end
		end;

feature -- DLE

	debug_level, dle_debug_level: INTEGER;
			-- Supermelted routines in the static (resp. dynamic) system
			-- are assigned body_ids between `debug_level' and `dle_level'
			-- (resp. greater then `dle_debug_level')

	set_levels is
			-- Keep track of the different levels after each compilation
		do
			if System.is_dynamic then
				dle_debug_level := counter
			else
				debug_level := counter;
					-- `dle_level' has to take into account the fact that frozen
					-- routines of the static system we want to debug (i.e.
					-- supermelt, or melt on the fly) will require a body_id
					-- between `debug_level' and `dle_level'.
				dle_level := counter + frozen_level;
				dle_frozen_level := dle_level;
				dle_debug_level := dle_level
			end;
			reset_debug_counter
		end;

	make_melted_dle (file: RAW_FILE) is
			-- Generate byte code for updating the execution table
			-- for the Dynamic Class Set.
		require
			dynamic_system: System.is_dynamic
		local
			e: EXECUTION_UNIT;
			real_body_id: INTEGER;
			melted_feature: MELT_FEATURE
		do
				-- First write the count of the byte code table
			write_int (file.file_pointer, counter - dle_frozen_level);
debug ("DLE ACTIVITY", "DLE SPY")
	io.error.putstring ("Updating execution_table%NCount: ");
	io.error.putint (counter-dle_frozen_level);
	io.error.new_line;
	io.error.putstring ("Frozen level: ");
	io.error.putint (frozen_level);
	io.error.new_line;
	io.error.putstring ("Debug level: ");
	io.error.putint (debug_level);
	io.error.new_line;
	io.error.putstring ("DLE level: ");
	io.error.putint (dle_level);
	io.error.new_line;
	io.error.putstring ("DLE frozen level: ");
	io.error.putint (dle_frozen_level);
	io.error.new_line;
	io.error.putstring ("DLE debug level: ");
	io.error.putint (dle_debug_level);
	io.error.new_line;
end;

			from
				melted_list.start
			until
				melted_list.after
			loop
				e := melted_list.item;
				if e.is_valid then
					real_body_id := e.real_body_id;
					check
							-- Very important check
						is_melted: real_body_id > dle_frozen_level
					end;
					melted_feature := M_feature_server.item (real_body_id);
						-- Write the body id
					write_int
						(file.file_pointer, real_body_id - dle_frozen_level -1);
						-- Write the size
					write_int (file.file_pointer, melted_feature.size);
						-- Write the pattern id
					write_int (file.file_pointer, e.real_pattern_id);
						-- Write the byte code
					melted_feature.store (file);

debug
	io.error.putstring ("Item written%N");
end;

					melted_list.forth;
				else
					melted_list.remove;
				end
			end;	
				-- End of execution table update
			write_int (file.file_pointer, -1)
		end;

	generate_dle (file: INDENT_FILE) is
			-- Generate the frozen execution table for the Dynamic Class Set.
		require
			dynamic_system: System.is_dynamic;
			good_argument: file /= Void;
			is_open: file.is_open_write
		local
			values: ARRAY [EXECUTION_UNIT];
			unit: EXECUTION_UNIT;
			i, nb: INTEGER;
			temp: STRING
		do
			from
				nb := counter;
				!!values.make (1, nb);
				start
			until
				after
			loop
				unit := item_for_iteration;
				values.put (unit, unit.index);
				forth;
			end;

				-- Generation
			from
				!! include_set.make;
				include_set.compare_objects;
				i := dle_level + 1;
				file.putstring ("#include %"struct.h%"%N%N");
			until
				i > nb
			loop
				unit := values.item (i);
				if unit /= Void and then unit.is_valid then
					unit.generate_declaration (file);
				end;
				i := i + 1;
			end;

				-- Generate the include files associated with
				-- external features not encapsulated but with a list
				-- of include files (assuming the definition of the feature
				-- is in one of the include files)
			from
				include_set.start
			until
				include_set.after
			loop
				file.putstring ("#include ");
				file.putstring (include_set.item);
				file.putstring ("%N%N");
				include_set.forth
			end
			include_set := Void;

			from
				file.new_line;
				!!temp.make (0);
				i := dle_level + 1;
				temp.append ("%Nstatic int Dfpatidtab[] = {%N");
				file.putstring ("static fnptr Dfrozen[] = {%N");
			until
				i > nb
			loop
				unit := values.item (i);
				if unit /= Void and then unit.is_valid then
					unit.generate (file);
					temp.append_integer (unit.real_pattern_id);
					temp.append (",%N");
				else
					file.putstring ("(fnptr) 0,%N");
					temp.append ("-1,%N");
				end;
				i := i + 1;
			end;
			file.putstring ("};%N");
			temp.put ('%N', temp.count - 1);
			temp.put ('}', temp.count);
			temp.append (";%N");
			file.putstring (temp);

			file.new_line;
			file.putstring ("void dle_efrozen()");
			file.new_line;
			file.putchar ('{');
			file.new_line;
			file.indent;
			file.putstring ("dle_zeroc = ");
			file.putint (dle_frozen_level);
			file.putchar (';');
			file.new_line;
			file.putstring ("dle_frozen = Dfrozen - ");
			file.putint (dle_level);
			file.putchar (';');
			file.new_line;
			file.putstring ("dle_fpatidtab = Dfpatidtab - ");
			file.putint (dle_level);
			file.putchar (';');
			file.new_line;
			file.exdent;
			file.putchar ('}');
			file.new_line
		end;

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
		end;

end
