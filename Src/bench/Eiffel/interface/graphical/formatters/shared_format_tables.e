class SHARED_FORMAT_TABLES

feature

	flat_context (stone: CLASSC_STONE): FORMAT_CONTEXT is
			-- Format context of the flat form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if flat_table.has (stone) then
				Result := flat_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.execute;
				if not Result.execution_error then
					flat_table.put (Result, stone);
					record_in_history (stone, flat_table)
				end
			end
		end;
		
	flatshort_context (stone: CLASSC_STONE): FORMAT_CONTEXT is
			-- Format context of the flatshort form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if flatshort_table.has (stone) then
				Result := flatshort_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.set_is_short;
				Result.execute;
				if not Result.execution_error then
					flatshort_table.put (Result, stone);
					record_in_history (stone, flatshort_table)
				end
			end
		end;
		
	short_context (stone: CLASSC_STONE): FORMAT_CONTEXT is
			-- Format context of the short form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if short_table.has (stone) then
				Result := short_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.set_is_short;
				Result.set_current_class_only;
				Result.execute;
				if not Result.execution_error then
					short_table.put (Result, stone);
					record_in_history (stone, short_table)
				end
			end
		end;
		
	clickable_context (stone: CLASSC_STONE): FORMAT_CONTEXT is
			-- Format context of the clickable form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if clickable_table.has (stone) then
				Result := clickable_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.set_current_class_only;
				Result.set_order_same_as_text;
				Result.execute;
				if not Result.execution_error then
					clickable_table.put (Result, stone);
					record_in_history (stone, clickable_table)
				end
			end
		end;
		
	rout_flat_context (stone: FEATURE_STONE): FORMAT_FEAT_CONTEXT is
			-- Format context of the flat form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if rout_flat_table.has (stone) then
				Result := rout_flat_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.execute (stone.feature_i);
				if not Result.execution_error then
					rout_flat_table.put (Result, stone);
					record_in_history (stone, rout_flat_table)
				end
			end
		end;
		
	debug_context (stone: FEATURE_STONE): DEBUG_CONTEXT is
			-- Format context of the debug form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		do
			if debug_table.has (stone) then
				Result := debug_table.item (stone)
			else
				!!Result.make (stone.class_c);
				Result.set_in_bench_mode;
				Result.execute (stone.feature_i);
				if not Result.execution_error then
					debug_table.put (Result, stone);
					record_in_history (stone, debug_table)
				end
			end
		end;
		
	clear_format_tables is
			-- Clear all the format tables (after a compilation)
		do
			flat_table.clear_all;
			flatshort_table.clear_all;
			short_table.clear_all;
			clickable_table.clear_all;
			rout_flat_table.clear_all;
			debug_table.clear_all;
			history_list.wipe_out
		end;

feature {NONE} -- Implementation

	History_size: INTEGER is 30;

	flat_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last flat formats
		once
			!!Result.make (History_size)
		end;

	flatshort_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last flatshort formats
		once
			!!Result.make (History_size)
		end;

	short_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last short formats
		once
			!!Result.make (History_size)
		end;

	clickable_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last clickable formats
		once
			!!Result.make (History_size)
		end;

	rout_flat_table: HASH_TABLE [FORMAT_FEAT_CONTEXT, FEATURE_STONE] is
			-- Table of the last flat formats
		once
			!!Result.make (History_size)
		end;

	debug_table: HASH_TABLE [DEBUG_CONTEXT, FEATURE_STONE] is
			-- Table of the last debug formats
		once
			!!Result.make (History_size)
		end;

	history_list: LINKED_LIST [CELL2 [HASHABLE_STONE,
						HASH_TABLE [FORMAT_CONTEXT, HASHABLE_STONE]]] is
			-- History list. Only `History_size' contexts are kept in memory
		once
			!!Result.make
		end;

	record_in_history (stone: HASHABLE_STONE; 
					table: HASH_TABLE [FORMAT_CONTEXT, HASHABLE_STONE]) is
			-- Extend the history with `stone'. Remove the oldest from
			-- the history list if it is full.
		require
			stone_not_void: stone /= Void;
			table_not_void: table /= Void
		local
			stone_and_table: CELL2 [HASHABLE_STONE, 
							HASH_TABLE [FORMAT_CONTEXT, HASHABLE_STONE]]
		do
			!!stone_and_table.make (stone, table);
			history_list.extend (stone_and_table);
			if history_list.count > History_size then
				history_list.start;
				stone_and_table := history_list.item;
				stone_and_table.item2.remove (stone_and_table.item1);
				history_list.remove
			end
		end;

invariant

	Cache_big_enough: History_size > 1

end -- class SHARED_FORMAT_TABLES
