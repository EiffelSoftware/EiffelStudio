indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Control_statement -> Icon_statement | Generic_statement | Specific_statement | General_statement


class CONTROL_STATEMENT 

inherit
	S_CONTROL_STATEMENT
		redefine
			post_action
		end

	TABLE_OF_SYMBOLS

creation
	make
	
feature

	post_action is
		local
			dialog: TDS_DIALOG
		do     
			dialog ?= tds.current_resource
			dialog.current_control.finish_control_setup
			dialog.insert_control (dialog.current_control)
		end

end -- class CONTROL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
