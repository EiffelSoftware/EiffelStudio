indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Control_statement_list -> Control_statement Control_statement_list |

class CONTROL_STATEMENT_LIST

inherit
	S_CONTROL_STATEMENT_LIST
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			dialog: TDS_DIALOG
		do     
			dialog ?= tds.current_resource

			if (dialog.statement_list = Void) then
				dialog.make_control_statement
			end
		end

end -- class CONTROL_STATEMENT_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
