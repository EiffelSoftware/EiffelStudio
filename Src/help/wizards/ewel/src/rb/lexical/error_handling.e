indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLING

feature -- Access

	has_error: BOOLEAN is
		do
			Result := has_error_cell.item
		end

feature -- Element change

	set_has_error (a_value: BOOLEAN) is
		do
			has_error_cell.put (a_value)
		ensure
			has_error_set: has_error_cell.item = a_value
		end

feature {NONE} -- Implementation

	has_error_cell: CELL [BOOLEAN] is
		once
			!! Result.put (False)
		ensure
			result_not_void: Result /= Void
		end

end -- class ERROR_HANDLING

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|--------------------------------------------------------------- 
