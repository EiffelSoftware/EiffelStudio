indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Strings_list_element -> stringID "," string_value

class STRINGS_LIST_ELEMENT

inherit
	S_STRINGS_LIST_ELEMENT
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
			stringtable_element: TDS_STRING
			stringtable: TDS_STRINGTABLE
		do
			!! stringtable_element.make

			stringtable ?= tds.current_resource

                        stringtable.insert_string (stringtable_element)
			stringtable.set_current_string (stringtable_element)

			tds.set_identifier_type (Stringtable_id)
		end

	post_action is
		do      
			tds.set_identifier_type (Normal)
		end

end -- class STRINGS_LIST_ELEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
