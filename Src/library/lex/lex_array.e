--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                    (805) 685-1006                           --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- One-dimensional arrays used in lexical analysis
-- (This class exports area)

indexing

	date: "$Date$";
	revision: "$Revision$"

class LEX_ARRAY [T]

inherit

	ARRAY [T]
		rename
			make as array_make
		export
			{ANY} lower, upper, item, put, resize;
			{TEXT_FILLER} area, to_c
		end

creation

	make

feature

	make (lower_index, upper_index: INTEGER) is
		do
			array_make (lower_index, upper_index)
		end -- make

end -- class LEX_ARRAY [T]
