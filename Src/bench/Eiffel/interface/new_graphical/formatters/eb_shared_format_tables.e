indexing
	description: "Tables used by all formatters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_FORMAT_TABLES

inherit
	EB_CONSTANTS

	EB_FORMATTER_DATA

feature -- Properties

	flat_context_text (a_class: CLASS_C): STRUCTURED_TEXT is
			-- Format context of the flat form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
			ctxt: CLASS_TEXT_FORMATTER
		do
			if flat_table.has (a_class) then
				create an_item_and_table.make (a_class, flat_table)
				Result := flat_table.found_item
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
				history_list.extend (an_item_and_table)
			else
				create ctxt
				ctxt.set_clickable
				ctxt.set_feature_clause_order (feature_clause_order)
				ctxt.set_is_with_breakable
				ctxt.format (a_class)
				if not ctxt.error then
					Result := ctxt.text
					record_in_history (a_class, flat_table, Result)
				end
			end
		end
		
	flatshort_context_text (a_class: CLASS_C): STRUCTURED_TEXT is
			-- Format context of the flatshort form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
			ctxt: CLASS_TEXT_FORMATTER
		do
			if flatshort_table.has (a_class) then
				create an_item_and_table.make (a_class, flatshort_table)
				Result := flatshort_table.found_item
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
				history_list.extend (an_item_and_table)
			else
				create ctxt
				ctxt.set_clickable
				ctxt.set_feature_clause_order (feature_clause_order)
				ctxt.set_is_short
				ctxt.set_is_without_breakable
				ctxt.format (a_class)
				if not ctxt.error then
					Result := ctxt.text
					record_in_history (a_class, flatshort_table, Result)
				end
			end
		end
		
	short_context_text (a_class: CLASS_C): STRUCTURED_TEXT is
			-- Format context of the short form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
			ctxt: CLASS_TEXT_FORMATTER
		do
			if short_table.has (a_class) then
				create an_item_and_table.make (a_class, short_table)
				Result := short_table.found_item
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
				history_list.extend (an_item_and_table)
			else
				create ctxt
				ctxt.set_clickable
				ctxt.set_is_short
				ctxt.set_is_without_breakable
				ctxt.set_one_class_only
				ctxt.set_feature_clause_order (feature_clause_order)
				ctxt.format (a_class)
				if not ctxt.error then
					Result := ctxt.text
					record_in_history (a_class, short_table, Result)
				end
			end
		end
		
	clickable_context_text (a_class: CLASS_C): STRUCTURED_TEXT is
			-- Format context of the clickable form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
			ctxt: CLASS_TEXT_FORMATTER
		do
			if clickable_table.has (a_class) then
				create an_item_and_table.make (a_class, clickable_table)
				Result := clickable_table.found_item
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
				history_list.extend (an_item_and_table)
			else
				create ctxt
				ctxt.set_clickable
				ctxt.set_one_class_only
				ctxt.set_order_same_as_text
				ctxt.set_is_without_breakable
				ctxt.format (a_class)
				if not ctxt.error then
					Result := ctxt.text
					record_in_history (a_class, clickable_table, Result)
				end
			end
		end
		
	rout_flat_context_text (a_feature: E_FEATURE): STRUCTURED_TEXT is
			-- Format context of the flat form of `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		local
			f_id: EB_FEATURE_ID
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
			ctxt: FEATURE_TEXT_FORMATTER
		do
			create f_id.make (a_feature)
			if rout_flat_table.has (f_id) then
				create an_item_and_table.make (f_id, rout_flat_table)
				Result := rout_flat_table.found_item
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
				history_list.extend (an_item_and_table)
			else
				create ctxt
				ctxt.set_clickable
					--| Show flat form of the routine (False)
				ctxt.format (a_feature, True)
				if not ctxt.error then
					Result := ctxt.text
					record_in_history (f_id, rout_flat_table, Result)
				end
			end
		end
		
feature -- Clearing tables

	clear_format_tables is
			-- Clear all the format tables (after a compilation)
		do
			flat_table.clear_all
			flatshort_table.clear_all
			short_table.clear_all
			clickable_table.clear_all
			rout_flat_table.clear_all
			history_list.wipe_out
		end

	clear_class_tables is
			-- Clear the cache for class tables except for
			-- the `clickable_table'.
		local
			found: BOOLEAN
			a_class: CLASS_C
		do
			from
				history_list.start
			until
				history_list.after
			loop
				a_class ?= history_list.item.item1
				if a_class /= Void then
					found := flat_table.has (a_class) or else
						flatshort_table.has (a_class) or else
						short_table.has (a_class) 
					if found then			
						history_list.remove
					else
						history_list.forth
					end
				else
					history_list.forth
				end
			end
			flat_table.clear_all
			flatshort_table.clear_all
			short_table.clear_all
		end

feature {NONE} -- Attributes

	History_size: INTEGER is
		once
			Result := editor_history_size
			if Result < 1 then
				Result := 5
			elseif Result > 200 then
					-- Just in case the user specified some weird values.
				Result := 50
			end
		end

	flat_table: HASH_TABLE [STRUCTURED_TEXT, CLASS_C] is
			-- Table of the last flat formats
		once
			create Result.make (History_size)
		end

	flatshort_table: HASH_TABLE [STRUCTURED_TEXT, CLASS_C] is
			-- Table of the last flatshort formats
		once
			create Result.make (History_size)
		end

	short_table: HASH_TABLE [STRUCTURED_TEXT, CLASS_C] is
			-- Table of the last short formats
		once
			create Result.make (History_size)
		end

	clickable_table: HASH_TABLE [STRUCTURED_TEXT, CLASS_C] is
			-- Table of the last clickable formats
		once
			create Result.make (History_size)
		end

	rout_flat_table: HASH_TABLE [STRUCTURED_TEXT, EB_FEATURE_ID] is
			-- Table of the last flat formats
		once
			create Result.make (History_size)
		end

	history_list: LINKED_LIST [CELL2 [HASHABLE,
						HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]] is
			-- History list. Only `History_size' contexts are kept in memory.
		once
			create Result.make
			Result.compare_objects
		end

feature {NONE} -- Implementation

	record_in_history (an_item: HASHABLE;
					table: HASH_TABLE [STRUCTURED_TEXT, HASHABLE];
					text: STRUCTURED_TEXT) is
			-- Extend the history with `an_item'. Remove the oldest from
			-- the history list if it is full.
			-- Add `text' to the memorized texts in `table'.
		require
			an_item_not_void: an_item /= Void
			table_not_void: table /= Void
		local
			an_item_and_table: CELL2 [HASHABLE, 
							HASH_TABLE [STRUCTURED_TEXT, HASHABLE]]
		do
			create an_item_and_table.make (an_item, table)
			table.put (text, an_item)
			if table.conflict then
					-- Text was already memorized.
					-- Raise it in history.
				history_list.start
				history_list.search (an_item_and_table)
				if not history_list.exhausted then
					history_list.remove
				end
			end
			history_list.extend (an_item_and_table)
			if history_list.count > History_size then
				history_list.start
				an_item_and_table := history_list.item
				an_item_and_table.item2.remove (an_item_and_table.item1)
				history_list.remove
			end
		end

invariant

	Cache_big_enough: History_size > 1

end -- class EB_SHARED_FORMAT_TABLES
