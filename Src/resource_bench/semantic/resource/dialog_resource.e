indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Dialog_resource -> "DIALOG" Dialog_options "BEGIN" Control_statement_list "END"

class DIALOG_RESOURCE

inherit
	S_DIALOG_RESOURCE
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
			!! dialog.make
			dialog.set_id (tds.last_token)
			dialog.set_class_name (dialog.id.to_class_style ("DIALOG"))
			tds.insert_resource (dialog)

			tds.set_current_resource (dialog)
		end

end -- class DIALOG_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
