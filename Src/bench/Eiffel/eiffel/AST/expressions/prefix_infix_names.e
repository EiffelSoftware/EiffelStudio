indexing
	description: "Internal names for infix and prefix functions, Bench version"
	date: "$Date$"
	revision: "$Revision$"

class PREFIX_INFIX_NAMES

feature -- Basic operations

	prefix_feature_name_with_symbol (symbol: STRING): STRING is
			-- Internal name corresponding to prefix `symbol'.
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
			prefix_table.search(symbol)
			if prefix_table.found then
				create Result.make_from_string(prefix_table.found_item)
			else
				create Result.make_from_string("_prefix_" + symbol)
			end
		ensure
			Result_not_void: Result /= Void
		end

	infix_function_name_with_symbol (symbol: STRING): STRING is
			-- Internal name corresponding to prefix `symbol'
		require
			symbol_not_void: symbol /= Void
			symbol_not_empty: not symbol.is_empty
		do
			infix_table.search(symbol)
			if infix_table.found then
				Result := clone (infix_table.found_item)
			else
				Result := "_infix_" + symbol
			end
		ensure
			Result_not_void: Result /= Void
		end

feature  -- Access

	and_infix: STRING is "_infix_and"
		-- infix for "and"

	and_then_infix: STRING is "_infix_and_then"
		-- infix for "and then"

	implies_infix: STRING is "_infix_implies"
		-- infix for "implies"

	or_else_infix: STRING is "_infix_or_else"
		-- infix for "or else"

	xor_infix: STRING is "_infix_xor"
		-- infix for "xor"

	or_infix: STRING is "_infix_or"
		-- infix for "or"

	equal_infix: STRING is "_infix_="
		-- infix for "="

	not_equal_infix: STRING is "_infix_/="
		-- infix for "/="

	ge_infix: STRING is "_infix_ge"
		-- infix for ">="

	gt_infix: STRING is "_infix_gt"
		-- infix for ">"

	le_infix: STRING is "_infix_le"
		-- infix for "<="

	lt_infix: STRING is "_infix_lt"
		-- infix for "<"

	div_infix: STRING is "_infix_div"
		-- infix for "//"

	mod_infix: STRING is "_infix_mod"
		-- infix for "\\"

	minus_infix: STRING is "_infix_minus"
		-- infix for "-"

	plus_infix: STRING is "_infix_plus"
		-- infix for "+"

	power_infix: STRING is "_infix_power"
		-- infix for "^"

	slash_infix: STRING is "_infix_slash"
		-- infix for "/"

	star_infix: STRING is "_infix_star"
		-- infix for "*"

	not_prefix: STRING is "_prefix_not"
		-- prefix for "not"

	minus_prefix: STRING is "_prefix_minus"
		-- prefix for "-"

	plus_prefix: STRING is "_prefix_plus"
		-- prefix for "+"

feature -- Lookup

	infix_reverse_table: HASH_TABLE [STRING, STRING] is
			-- Reverse association of symbols and suffixes.	
		local
			other: like infix_table
		once
			other := infix_table
			create Result.make (other.count)
			from
				other.start
			until
				other.after
			loop
				Result.put (other.key_for_iteration, other.item_for_iteration)
				other.forth
			end
		end

	prefix_reverse_table: HASH_TABLE [STRING, STRING] is
			-- Reverse association of symbols and suffixes.	
		local
			other: like prefix_table
		once
			other := prefix_table
			create Result.make (other.count)
			from
				other.start
			until
				other.after
			loop
				Result.put (other.key_for_iteration, other.item_for_iteration)
				other.forth
			end
		end

feature {NONE} -- Implementation

	infix_table: HASH_TABLE [STRING, STRING] is
			-- Association of symbols and suffixes.
		once
			Create Result.make(19)
			Result.put (and_infix,"and")
			Result.put (and_then_infix,"and then")
			Result.put (implies_infix,"implies")
			Result.put (or_else_infix,"or else")
			Result.put (or_infix,"or")
			Result.put (xor_infix,"xor")
			Result.put (equal_infix,"=")
			Result.put (not_equal_infix,"/=")
			Result.put (ge_infix,">=")
			Result.put (gt_infix,">")
			Result.put (le_infix,"<=")
			Result.put (lt_infix,"<")
			Result.put (div_infix,"//")
			Result.put (mod_infix,"\\")
			Result.put (minus_infix,"-")
			Result.put (plus_infix,"+")
			Result.put (power_infix,"^")
			Result.put (slash_infix,"/")
			Result.put (star_infix,"*")
		end

	prefix_table: HASH_TABLE [STRING, STRING] is
			-- Association of symbols and suffixes.
		once
			Create Result.make(3)
			Result.put (minus_prefix,"-")
			Result.put (plus_prefix,"+")
			Result.put (not_prefix,"not")
		end

end -- Class PREFIX_INFIX_NAMES
