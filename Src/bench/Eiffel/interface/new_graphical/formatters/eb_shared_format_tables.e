indexing
	description: "Tables used by all formatters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_FORMAT_TABLES

inherit
	EB_CONSTANTS

	EB_SHARED_PREFERENCES

feature -- Properties

	flat_context_text (a_class: CLASS_C; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format context of the flat form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
			a_formatter_not_void: a_formatter /= Void
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt
			ctxt.set_clickable
			ctxt.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
			ctxt.set_is_with_breakable
			ctxt.format (a_class, a_formatter)
			Result := ctxt.error
		end

	flatshort_context_text (a_class: CLASS_C; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format context of the flatshort form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt
			ctxt.set_clickable
			ctxt.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
			ctxt.set_is_short
			ctxt.set_is_without_breakable
			ctxt.format (a_class, a_formatter)
			Result := ctxt.error
		end

	short_context_text (a_class: CLASS_C; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format context of the short form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt
			ctxt.set_clickable
			ctxt.set_is_short
			ctxt.set_is_without_breakable
			ctxt.set_one_class_only
			ctxt.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
			ctxt.format (a_class, a_formatter)
			Result := ctxt.error
		end

	clickable_context_text (a_class: CLASS_C; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format context of the clickable form of `a_class'
		require
			a_class_not_void: a_class /= Void
			valid_a_class: a_class.is_valid
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt
			ctxt.set_clickable
			ctxt.set_one_class_only
			ctxt.set_order_same_as_text
			ctxt.set_is_without_breakable
			ctxt.format (a_class, a_formatter)
			Result := ctxt.error
		end

	rout_flat_context_text (a_feature: E_FEATURE; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format context of the flat form of `a_feature'
		require
			a_feature_not_void: a_feature /= Void
		local
			ctxt: FEATURE_TEXT_FORMATTER
		do
			create ctxt
			ctxt.set_clickable
				--| Show flat form of the routine (False)
			ctxt.format (a_feature, True, a_formatter)
			Result := ctxt.error
		end

feature -- Properties .NET	

	flatshort_dotnet_text (a_consumed: CONSUMED_TYPE; a_classi: CLASS_I; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format .NET consumed type, flat short.
		require
			a_consumed_void: a_consumed /= Void
		local
			dntxt: DOTNET_TEXT_FORMATTER
		do
			create dntxt
			dntxt.set_is_flat_short
			dntxt.format (a_consumed, a_classi, a_formatter)
			Result := dntxt.error
		end

	short_dotnet_text (a_consumed: CONSUMED_TYPE; a_classi: CLASS_I; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format .NET consumed type, short (no inheritance).
		require
			a_consumed_void: a_consumed /= Void
			a_classi_not_void: a_classi /= Void
		local
			dntxt: DOTNET_TEXT_FORMATTER
		do
			create dntxt
			dntxt.format (a_consumed, a_classi, a_formatter)
			Result := dntxt.error
		end

	rout_flat_dotnet_text (a_feature: E_FEATURE; a_consumed: CONSUMED_TYPE; a_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Format .NET feature text, flat short (include inheritance).
		require
			a_feature_not_void: a_feature /= Void
			a_consumed_void: a_consumed /= Void
		local
			dntxt: DOTNET_FEATURE_TEXT_FORMATTER
		do
			create dntxt
			dntxt.format (a_feature, a_consumed, a_formatter)
			Result := dntxt.error
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
			Result := preferences.context_tool_data.editor_history_size
			if Result < 1 then
				Result := 5
			elseif Result > 200 then
					-- Just in case the user specified some weird values.
				Result := 50
			end
		end

	flat_table: HASH_TABLE [TEXT_FORMATTER, CLASS_C] is
			-- Table of the last flat formats
		once
			create Result.make (History_size)
		end

	flatshort_table: HASH_TABLE [TEXT_FORMATTER, CLASS_C] is
			-- Table of the last flatshort formats
		once
			create Result.make (History_size)
		end

	short_table: HASH_TABLE [TEXT_FORMATTER, CLASS_C] is
			-- Table of the last short formats
		once
			create Result.make (History_size)
		end

	clickable_table: HASH_TABLE [TEXT_FORMATTER, CLASS_C] is
			-- Table of the last clickable formats
		once
			create Result.make (History_size)
		end

	rout_flat_table: HASH_TABLE [TEXT_FORMATTER, EB_FEATURE_ID] is
			-- Table of the last flat formats
		once
			create Result.make (History_size)
		end

	history_list: LINKED_LIST [CELL2 [HASHABLE,
						HASH_TABLE [TEXT_FORMATTER, HASHABLE]]] is
			-- History list. Only `History_size' contexts are kept in memory.
		once
			create Result.make
			Result.compare_objects
		end

feature {NONE} -- Attributes .NET

	consumed_types: HASH_TABLE [CONSUMED_TYPE, STRING] is
			-- Table of .NET types which have been formatted already.
			-- Used to prevent deserializing consumed type every time we
			-- wish to format.
		once
			create Result.make (History_size)
		end

	flatshort_dotnet_table: HASH_TABLE [TEXT_FORMATTER, STRING] is
			-- Table of last .NET flat short formats.
		once
			create Result.make (History_size)
		end

	short_dotnet_table: HASH_TABLE [TEXT_FORMATTER, STRING] is
			-- Table of last .NET short formats.
		once
			create Result.make (History_size)
		end

	rout_flat_dotnet_table: HASH_TABLE [TEXT_FORMATTER, E_FEATURE] is
			-- Table of last .NET flat routine formats.
		once
			create Result.make (History_size)
		end

feature {NONE} -- Implementation

	record_in_history (an_item: HASHABLE;
					table: HASH_TABLE [TEXT_FORMATTER, HASHABLE];
					text: TEXT_FORMATTER) is
			-- Extend the history with `an_item'. Remove the oldest from
			-- the history list if it is full.
			-- Add `text' to the memorized texts in `table'.
		require
			an_item_not_void: an_item /= Void
			table_not_void: table /= Void
		local
			an_item_and_table: CELL2 [HASHABLE,
							HASH_TABLE [TEXT_FORMATTER, HASHABLE]]
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SHARED_FORMAT_TABLES
