indexing
	description: "Semantic information for constructs of the resource script language"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_SYMBOLS

feature -- Access

	tds: TABLE_OF_SYMBOLS_STRUCTURE is
			-- Informations about the analyzed resource script file.
		do
			Result := tds_cell.item
		end

feature -- Element change

	set_tds (a_tds: TABLE_OF_SYMBOLS_STRUCTURE) is
			-- Set the current `tds' to `a_tds'.
		require
			tds_not_void: a_tds /= Void
		do
			tds_cell.put (a_tds)
		ensure
			tds_set: tds = a_tds
		end

	erase_tds is
			-- Remove the element of `tds_cell'.
		do
			tds_cell.put (Void)
		end

feature {NONE} -- Implementation

	tds_cell: CELL [TABLE_OF_SYMBOLS_STRUCTURE] is
			-- The current `tds'.
		once
			!!Result.put (Void)
		ensure
			result_not_void: Result /= Void
		end

	
end -- TABLE_OF_SYMBOLS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
