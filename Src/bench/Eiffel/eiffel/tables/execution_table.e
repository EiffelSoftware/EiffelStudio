-- Table of execution units (either C routines or byte code arrays)

class EXECUTION_TABLE 

inherit

	CENTRAL_TABLE [EXECUTION_UNIT];
	SHARED_WORKBENCH
		undefine
			twin
		end;
	SHARED_SERVER
		undefine
			twin
		end;
	SHARED_BODY_ID
		undefine
			twin
		end;

creation

	init

	
feature 

	make_update (file: UNIX_FILE) is
			-- Generate byte code for updating the dispatch table
		local
			e: EXECUTION_UNIT;
			real_body_id, frozen_level: INTEGER;
			melted_feature: MELT_FEATURE;
		do
			frozen_level := System.frozen_level;

				-- First write the count of the byte code table
			write_int (file.file_pointer, count - frozen_level);

			from
				melted_list.start
			until
				melted_list.offright
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

					melted_list.forth;
				else
					melted_list.remove;
				end;
			end;	
				-- End of execution table update
			write_int (file.file_pointer, -1);
		end;

	generate (file: UNIX_FILE) is
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
				nb := count;
				!!values.make (1, nb);
				start
			until
				offright
			loop
				unit := item_for_iteration;
				values.put (unit, unit.index);
				forth;
			end;

				-- Generation
			from
				i := 1;
				file.putstring ("#include %"struct.h%"%N%N");
			until
				i > nb
			loop
				values.item (i).generate_declaration (file);
				i := i + 1;
			end;
			from
				i := 1;
				file.new_line;
				!!temp.make (0);
				temp.append ("%Nint fpatidtab[] = {%N");
				file.putstring ("fnptr frozen[] = {%N");
			until
				i > nb
			loop
				values.item (i).generate (file);
				temp.append_integer (values.item (i).real_pattern_id);
				temp.append (",%N");
				i := i + 1;
			end;
			file.putstring ("};%N");
			temp.put ('%N', temp.count - 1);
			temp.put ('}', temp.count);
			temp.append (";%N");
			file.putstring (temp);
		end;

feature -- Debugging

	debug_counter: COUNTER is
		-- Counter used to generate real body
		-- id's for debuggable byte arrays.
		once
			!!Result
		end;

	reset_debug_counter is
			-- Reset `debug_counter'.
		do
			debug_counter.reset
		end;

	debuggable_body_id: INTEGER is
			-- New body id for 
			-- debuggable byte arrays.
		do
			Result := count + debug_counter.next
		end;

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
		end;

end
