indexing

	description:	
		"Tables used by all formatters";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_FORMAT_TABLES

inherit
	EB_CONSTANTS
	
	SHARED_FORMAT_INFO

feature -- Properties

	flat_context_text (stone: CLASSC_STONE): STRUCTURED_TEXT is
			-- Format context of the flat form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			if flat_table.has (stone) then
				Result := flat_table.found_item
			else
				!! ctxt;
				ctxt.set_clickable;
				ctxt.set_feature_clause_order (Class_resources.feature_clause_order.actual_value);
				ctxt.format (stone.e_class);
				if not ctxt.error then
					Result := ctxt.text;
					flat_table.put (Result, stone);
					record_in_history (stone, flat_table)
				end
			end
		end;
		
	flatshort_context_text (stone: CLASSC_STONE): STRUCTURED_TEXT is
			-- Format context of the flatshort form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			if flatshort_table.has (stone) then
				Result := flatshort_table.found_item
			else
				set_is_without_breakable
				!! ctxt;
				ctxt.set_clickable;
				ctxt.set_feature_clause_order (Class_resources.feature_clause_order.actual_value);
				ctxt.set_is_short;
				ctxt.format (stone.e_class);
				if not ctxt.error then
					Result := ctxt.text;
					flatshort_table.put (Result, stone);
					record_in_history (stone, flatshort_table)
				end
			end
		end;
		
	short_context_text (stone: CLASSC_STONE): STRUCTURED_TEXT is
			-- Format context of the short form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			if short_table.has (stone) then
				Result := short_table.found_item
			else
				set_is_without_breakable
				!! ctxt;
				ctxt.set_clickable;
				ctxt.set_is_short;
				ctxt.set_one_class_only;
				ctxt.set_feature_clause_order (Class_resources.feature_clause_order.actual_value);
				ctxt.format (stone.e_class);
				if not ctxt.error then
					Result := ctxt.text;
					short_table.put (Result, stone);
					record_in_history (stone, short_table)
				end
			end
		end;
		
	clickable_context_text (stone: CLASSC_STONE): STRUCTURED_TEXT is
			-- Format context of the clickable form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			if clickable_table.has (stone) then
				Result := clickable_table.found_item
			else
				set_is_without_breakable
				!! ctxt;
				ctxt.set_clickable;
				ctxt.set_one_class_only;
				ctxt.set_order_same_as_text;
				ctxt.format (stone.e_class);
				if not ctxt.error then
					Result := ctxt.text;
					clickable_table.put (Result, stone);
					record_in_history (stone, clickable_table)
				end
			end
		end;
		
	rout_flat_context_text (stone: FEATURE_STONE): STRUCTURED_TEXT is
			-- Format context of the flat form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: FEATURE_TEXT_FORMATTER
		do
			if rout_flat_table.has (stone) then
				Result := rout_flat_table.found_item
			else
				set_is_without_breakable
				!! ctxt;
				ctxt.set_clickable;
					--| Show flat form of the routine (False)
				ctxt.format (stone.e_feature, False);
				if not ctxt.error then
					Result := ctxt.text;
					rout_flat_table.put (Result, stone);
					record_in_history (stone, rout_flat_table)
				end
			end
		end;
		
	debug_context_text (stone: FEATURE_STONE): STRUCTURED_TEXT is
			-- Format context of the debug form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: FEATURE_TEXT_FORMATTER
		do
			if debug_table.has (stone) then
				Result := debug_table.found_item
			else
				set_is_with_breakable
				!! ctxt;
				ctxt.set_clickable;
					--| Show flat form with debug point (True)
				ctxt.format (stone.e_feature, True);
				if not ctxt.error then
					Result := ctxt.text;
					debug_table.put (Result, stone);
					record_in_history (stone, debug_table)
				end
			end
		end;

	simple_debug_context_text (stone: FEATURE_STONE): STRUCTURED_TEXT is
			-- Simple formatting (nothing clickalbe)
			-- of the debug form of `stone'
		require
			stone_not_void: stone /= Void;
			valid_stone: stone.is_valid
		local
			ctxt: FEATURE_TEXT_FORMATTER
		do
			if debug_table.has (stone) then
				Result := debug_table.found_item
			else
				!! ctxt;
				set_is_with_breakable
				ctxt.simple_format_debuggable (stone.e_feature);
				if not ctxt.error then
					Result := ctxt.text;
					simple_debug_table.put (Result, stone);
					record_in_history (stone, debug_table)
				end
			end
		end;

feature -- Clearing tables

	clear_format_tables is
			-- Clear all the format tables (after a compilation)
		do
			flat_table.clear_all;
			flatshort_table.clear_all;
			short_table.clear_all;
			clickable_table.clear_all;
			rout_flat_table.clear_all;
			debug_table.clear_all;
			simple_debug_table.clear_all;
			history_list.wipe_out
		end;

	clear_class_tables is
			-- Clear the cache for class tables except for
			-- the `clickable_table'.
		local
			found: BOOLEAN;
			a_stone: CLASSC_STONE
		do
			from
				history_list.start
			until
				history_list.after
			loop
				a_stone ?= history_list.item.item1;
				if a_stone /= Void then
					found := flat_table.has (a_stone) or else
						flatshort_table.has (a_stone) or else
						short_table.has (a_stone) 
					if found then			
						history_list.remove
					else
						history_list.forth
					end
				else
					history_list.forth
				end
			end;
			flat_table.clear_all;
			flatshort_table.clear_all;
			short_table.clear_all;
		end;

feature {NONE} -- Attributes

	History_size: INTEGER is
		do
			Result := General_resources.history_size.actual_value;
			if Result < 1 or Result > 100 then
					-- Just in case the user specified some weird values.
				Result := 10
			end;
			Result := Result * 3
		end;

	flat_table: HASH_TABLE [STRUCTURED_TEXT, CLASSC_STONE] is
			-- Table of the last flat formats
		once
			!!Result.make (History_size)
		end;

	flatshort_table: HASH_TABLE [STRUCTURED_TEXT, CLASSC_STONE] is
			-- Table of the last flatshort formats
		once
			!!Result.make (History_size)
		end;

	short_table: HASH_TABLE [STRUCTURED_TEXT, CLASSC_STONE] is
			-- Table of the last short formats
		once
			!!Result.make (History_size)
		end;

	clickable_table: HASH_TABLE [STRUCTURED_TEXT, CLASSC_STONE] is
			-- Table of the last clickable formats
		once
			!!Result.make (History_size)
		end;

	rout_flat_table: HASH_TABLE [STRUCTURED_TEXT, FEATURE_STONE] is
			-- Table of the last flat formats
		once
			!!Result.make (History_size)
		end;

	debug_table: HASH_TABLE [STRUCTURED_TEXT, FEATURE_STONE] is
			-- Table of the last debug formats
		once
			!!Result.make (History_size)
		end;

	simple_debug_table: HASH_TABLE [STRUCTURED_TEXT, FEATURE_STONE] is
			-- Table of the last debug formats
		once
			!!Result.make (History_size)
		end;

	history_list: LINKED_LIST [CELL2 [HASHABLE_STONE,
						HASH_TABLE [STRUCTURED_TEXT, HASHABLE_STONE]]] is
			-- History list. Only `History_size' contexts are kept in memory
		once
			!!Result.make
		end;

feature {NONE} -- Implementation

	record_in_history (stone: HASHABLE_STONE; 
					table: HASH_TABLE [STRUCTURED_TEXT, HASHABLE_STONE]) is
			-- Extend the history with `stone'. Remove the oldest from
			-- the history list if it is full.
		require
			stone_not_void: stone /= Void;
			table_not_void: table /= Void
		local
			stone_and_table: CELL2 [HASHABLE_STONE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE_STONE]]
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
