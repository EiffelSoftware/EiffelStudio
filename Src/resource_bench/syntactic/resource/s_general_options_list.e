indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- General_options_list -> General_options General_options_list |

class S_GENERAL_OPTIONS_LIST

inherit
	RB_AGGREGATE
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
			Result := "GENERAL_OPTIONS_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			options: GENERAL_OPTIONS
			list: GENERAL_OPTIONS_LIST
		once
			!! Result.make
			Result.forth

			!! options.make
			put (options)

			!! list.make
			put (list)
		end

end -- class S_GENERAL_OPTIONS_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
