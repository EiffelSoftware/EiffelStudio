indexing
	description: "Load and memory attributes representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_LOAD_AND_MEM_ATTRIBUTES

inherit
	LINKED_LIST [STRING]

creation
	make

feature -- Code generation

	display is
		do
			io.putstring ("%NLoad and Mem attributes : ")

			from
				start
			until
				after
			loop
				io.putstring (item)
				io.putstring (" ")

				forth
			end
			io.new_line
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			from
				start
			until
				after
			loop
				a_resource_file.putstring (item)
				a_resource_file.putstring (" ")

				forth
			end
		end

end -- class TDS_LOAD_AND_MEM_ATTRIBUTES

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
