indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Accelerators_list_element -> event "," id_value More_accelerators

class ACCELERATORS_LIST_ELEMENT

inherit

	S_ACCELERATORS_LIST_ELEMENT
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation

	make

feature 

	pre_action is
		local
			accelerators_item: TDS_ACCELERATORS_ITEM
			accelerators: TDS_ACCELERATORS

		do
			!! accelerators_item

			accelerators ?= tds.current_resource

			accelerators.insert_accelerator (accelerators_item)
			accelerators.set_current_accelerator (accelerators_item)

			tds.set_identifier_type (Accelerators_event)
		end

	post_action is
		do      
			tds.set_identifier_type (Normal)
		end

end -- class ACCELERATORS_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
