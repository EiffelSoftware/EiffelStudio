indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Specific_control_statement

class SPECIFIC_CONTROL_STATEMENT 

inherit
	S_SPECIFIC_CONTROL_STATEMENT
		redefine 
			action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature 

	action is
		local
			dialog: TDS_DIALOG
			control: TDS_CONTROL_STATEMENT
		do
			dialog ?= tds.current_resource

			if (token.string_value.is_equal ("COMBOBOX")) then
				!tds_combobox_statement! control.make

			elseif (token.string_value.is_equal ("EDITTEXT")) then
				!tds_edittext_statement! control.make

			elseif (token.string_value.is_equal ("LISTBOX")) then
				!tds_listbox_statement! control.make
			end

			control.set_wel_code (true)
			dialog.set_current_control (control)

			tds.set_identifier_type (Control_id)
		end

end -- class SPECIFIC_CONTROL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
