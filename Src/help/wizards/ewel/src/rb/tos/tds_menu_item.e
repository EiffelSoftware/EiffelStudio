indexing
	description: "Menu item representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_MENU_ITEM

creation
	make

feature -- Initialization

	make is
		do
			is_separator := false
			!! command_id
		end

feature  -- Access

	text: STRING
			-- Text caption of the menu item.

	command_id: TDS_ID
			-- Id of the associated menu item command.

	flags: LINKED_LIST [STRING]
			-- 

	is_separator: BOOLEAN
			-- Is the menu item a separator?
			
	
	popup_menu: TDS_MENU
			-- Link to the popup-menu.

feature -- Element change

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'
		require
			a_text_exists: a_text /= Void and then a_text.count > 0
		do
			text := clone (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_command_id (a_command_id: STRING) is
			-- Set `command_id' to `a_command_id'
		require
			a_command_id_exits: a_command_id /= Void and then a_command_id.count > 0
		do
			command_id.set_id (a_command_id)
		end

	insert_flags (a_flag: STRING) is
			-- Insert `a_flag' into `flags'.
		require
			a_flag_exists: a_flag /= Void and then a_flag.count > 0
		do
			if (flags = Void) then
				!! flags.make
			end

			flags.extend (clone (a_flag))
		end

	set_separator is
			-- Make the menu item a separator item.
		do
			is_separator := true
		ensure
			is_separator_set: is_separator
		end

	set_popup_menu (a_menu: TDS_MENU)is
			-- Set `popup_menu' to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			popup_menu := a_menu
		ensure
			popup_menu_set: popup_menu = a_menu
		end

feature -- Code generation

	display is
		do
			if (not is_separator) then
				if (text /= Void) and (popup_menu /= Void) then
					io.putstring (text)
				elseif (text /= Void) then
					io.putstring (text)
					io.putstring (" ")
					command_id.display
				end

				if (flags /= Void) then
					io.putstring (" FLAGS = ")
					from
						flags.start
					until 
						flags.after

					loop
						io.putstring (flags.item)
						io.putstring (" ")

						flags.forth
					end
				end

				if (popup_menu /= Void) then
					io.new_line
					io.putstring ("Popup-Menu :%N")
					popup_menu.display_popup
					io.putstring ("End Popup-menu")
				end
			else
				io.putstring ("SEPARATOR")
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (not is_separator) then
				if (popup_menu /= Void) then
					a_resource_file.putstring ("%N%TPOPUP ")
				else
					a_resource_file.putstring ("%N%TMENUITEM ")
				end

				if (text /= Void) and (popup_menu /= Void) then
					a_resource_file.putstring (text)
				elseif (text /= Void) then
					a_resource_file.putstring (text)
					a_resource_file.putstring (", ")
					command_id.generate_resource_file (a_resource_file)
				end

				if (flags /= Void) then
					a_resource_file.putstring (", ")

					from
						flags.start
					until 
						flags.after

					loop
						a_resource_file.putstring (flags.item)
						a_resource_file.putstring (" ")

						flags.forth
					end
				end

				if (popup_menu /= Void) then
					a_resource_file.putstring ("%N%TBEGIN")
					popup_menu.generate_resource_file_popup (a_resource_file)
					a_resource_file.putstring ("%N%TEND")
				end
			else
				a_resource_file.putstring ("%N%TMENUITEM SEPARATOR")
			end
		end

end -- class TDS_MENU_ITEM

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
