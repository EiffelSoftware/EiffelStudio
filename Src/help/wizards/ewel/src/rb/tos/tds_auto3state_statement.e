indexing
	description: "Auto3state statement representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_AUTO3STATE_STATEMENT

inherit
	TDS_CONTROL_STATEMENT

	TDS_CONTROL_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature	-- Initialization

	finish_control_setup is
		do
			set_variable_name ("auto3state")
			set_wel_class_name ("WEL_AUTO3STATE")
			set_type (C_auto3state)
		end

feature -- Code generation

	display is
		do
			from 
				start
			until
				after

			loop
				io.new_line
				io.putstring ("AUTO3STATE ")

				io.putstring (item.text)

				io.putstring (" ")
				item.id.display

				io.putstring (" ")
				io.putint (item.x)

				io.putstring (" ")
				io.putint (item.y)

				io.putstring (" ")
				io.putint (item.width)

				io.putstring (" ")
				io.putint (item.height)

				if (item.style /= Void) then
					item.style.display
				end

				if (item.exstyle /= Void) then
					item.exstyle.display
				end

				forth
			end
		end

	generate_resource_file (resource_file: PLAIN_TEXT_FILE) is
			-- generate the resource script file from the tds memory structure
		do
			from 
				start
			until
				after

			loop
				resource_file.putstring ("%N%TAUTO3STATE ")

				resource_file.putstring (item.text)

				resource_file.putstring (", ")
				item.id.generate_resource_file (resource_file)

				resource_file.putstring (", ")
				resource_file.putint (item.x)

				resource_file.putstring (", ")
				resource_file.putint (item.y)

				resource_file.putstring (", ")
				resource_file.putint (item.width)

				resource_file.putstring (", ")
				resource_file.putint (item.height)

				if (item.style /= Void) then
					resource_file.putstring (", ")
					item.style.generate_resource_file (resource_file)
				end

				if (item.exstyle /= Void) then
					resource_file.putstring (", ")
					item.exstyle.generate_resource_file (resource_file)
				end

				forth
			end
		end

end -- class TDS_AUTO3STATE_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

