indexing
	description: "String item representation in the tds_stringtable"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STRING

creation
	make

feature -- Initialization

	make is
		do
			!! text_id
		end

feature	-- Access
	
	text_id: TDS_ID
			-- Id of the stringtable item.

	text: STRING
			-- Text of the stringtable item.


feature -- Element change

	set_id (a_id: STRING) is
			-- Set properly `a_id' to the current object.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			if (a_id.is_integer) then
				text_id.set_number_id (a_id.to_integer)
			else
				text_id.set_name_id (a_id)
			end
		end

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void and then a_text.count > 0
		do
			text := clone (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Code generation

	display is
		do
			text_id.display
			io.putstring (" : ")
			io.putstring (text)
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			text_id.generate_resource_file (a_resource_file)
			a_resource_file.putstring (", ")
			a_resource_file.putstring (text)
		end

end -- class TDS_STRING

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
