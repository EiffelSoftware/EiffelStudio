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
					flat_list.extend (stone);
					if flat_list.count > Max_number then
						flat_list.start;
						flat_table.remove (flat_list.item);
						flat_list.remove
					end
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
					flatshort_list.extend (stone);
					if flatshort_list.count > Max_number then
						flatshort_list.start;
						flatshort_table.remove (flatshort_list.item);
						flatshort_list.remove
					end
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
					short_list.extend (stone);
					if short_list.count > Max_number then
						short_list.start;
						short_table.remove (short_list.item);
						short_list.remove
					end
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
					clickable_list.extend (stone);
					if clickable_list.count > Max_number then
						clickable_list.start;
						clickable_table.remove (clickable_list.item);
						clickable_list.remove
					end
				end
			end
		end;
		
	clear_format_tables is
			-- Clear all the format tables (after a compilation)
		do
			flat_list.wipe_out;
			flat_table.clear_all;
			flatshort_list.wipe_out;
			flatshort_table.clear_all;
			short_list.wipe_out;
			short_table.clear_all;
			clickable_list.wipe_out;
			clickable_table.clear_all
		end;

feature {NONE} -- Implementation

	Max_number: INTEGER is 10;

	flat_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last flat formats
		once
			!!Result.make (Max_number)
		end;

	flat_list: LINKED_LIST [CLASSC_STONE] is
			-- List of the stones whose flat format is available
		once
			!!Result.make
		end;

	flatshort_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last flatshort formats
		once
			!!Result.make (Max_number)
		end;

	flatshort_list: LINKED_LIST [CLASSC_STONE] is
			-- List of the stones whose flatshort format is available
		once
			!!Result.make
		end;

	short_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last short formats
		once
			!!Result.make (Max_number)
		end;

	short_list: LINKED_LIST [CLASSC_STONE] is
			-- List of the stones whose short format is available
		once
			!!Result.make
		end;

	clickable_table: HASH_TABLE [FORMAT_CONTEXT, CLASSC_STONE] is
			-- Table of the last clickable formats
		once
			!!Result.make (Max_number)
		end;

	clickable_list: LINKED_LIST [CLASSC_STONE] is
			-- List of the stones whose clickable format is available
		once
			!!Result.make
		end;

invariant

	Cache_big_enough: Max_number > 1

end -- class SHARED_FORMAT_TABLES
