indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Second_part -> Else_part | Elif_part |

class S_SECOND_PART

inherit
	RB_CHOICE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "SECOND_PART"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			else_part: ELSE_PART
			elif_part: ELIF_PART
		once
			!! Result.make
			Result.forth

			!! else_part.make
			put (else_part)

			!! elif_part.make
			put (elif_part)
		end

end -- class S_SECOND_PART

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
