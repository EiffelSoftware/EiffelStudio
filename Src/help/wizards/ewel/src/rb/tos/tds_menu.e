indexing
	description: "Menu representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_MENU

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

creation
	make

feature -- Initialization

	make is
			-- Create a new menu resource in the tds
			-- and create the associated `items_list'.
		do
			list_make
			!! items_list.make
			set_type (R_menu)
		end

	make_current_menu is
		do
			!! current_menu.make
		end

feature -- Access
	
	current_menu: LINKED_STACK [TDS_MENU]
			-- The current parsed menu.

	current_item: TDS_MENU_ITEM
			-- The curent parsed item in the menu.

	items_list: LINKED_LIST [TDS_MENU_ITEM]
			-- List of menu items.

	is_popup: BOOLEAN
			-- Is the current menu a popup menu?


feature -- Element change

	set_current_item (a_item: TDS_MENU_ITEM) is
			-- Set `current_item' to `a_item'.
		require
			a_item_not_void: a_item /= Void
		do
			current_item := a_item
		ensure
			current_item_set: current_item = a_item
		end

	set_is_popup (a_value: BOOLEAN) is
			-- Set `is_popup' to `a_value'.
		do
			is_popup := a_value
		ensure
			is_popup_set: is_popup = a_value
		end

	insert_item (a_menu_item: TDS_MENU_ITEM) is
			-- Insert `a_menu_item' in the menu.
		require
			a_menu_item_not_void: a_menu_item /= Void
		do
			items_list.extend (a_menu_item)
		ensure
			a_menu_item_inserted: items_list.count = old items_list.count + 1
		end

feature -- Code generation

	display is
			-- Display the tds.
		local
			menu: TDS_MENU
		do
			from 
				start
			until 
				after
			loop
				menu ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NMenu ID : ")
				menu.id.display

				if (menu.load_and_mem_attributes /= Void) then
					menu.load_and_mem_attributes.display
				end                

				if (menu.options /= Void) then
					io.new_line
					menu.options.display
				end

				if (menu.items_list /= Void) then
					from 
						menu.items_list.start
					until
						menu.items_list.after
			
					loop
						menu.items_list.item.display
						io.new_line
						menu.items_list.forth
					end
				end

				io.new_line
				forth
			end
		end

	display_popup is
		do
			if (items_list /= Void) then
				from 
					items_list.start
				until
					items_list.after
		
				loop
					items_list.item.display
					io.new_line
                                        items_list.forth
				end
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		local
			menu: TDS_MENU
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// MENU%N")
			a_resource_file.putstring ("//%N")

			from 
				start
			until 
				after
			loop
				menu ?= item

				a_resource_file.new_line
				menu.id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" MENU ")

				if (menu.load_and_mem_attributes /= Void) then
					menu.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				if (menu.options /= Void) then
					a_resource_file.new_line
					menu.options.generate_resource_file (a_resource_file)
				end

				a_resource_file.putstring ("%NBEGIN")

				if (menu.items_list /= Void) then
					from 
						menu.items_list.start
					until
						menu.items_list.after
			
					loop
						menu.items_list.item.generate_resource_file (a_resource_file)
						menu.items_list.forth
					end
				end

				a_resource_file.putstring ("%NEND")

				a_resource_file.new_line
				forth
			end			
		end

	generate_resource_file_popup (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (items_list /= Void) then
				from 
					items_list.start
				until
					items_list.after
		
				loop
					items_list.item.generate_resource_file (a_resource_file)
                                        items_list.forth
				end
			end
		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
			-- Generate `a_tree_view' control from the tds memory structure.
		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
			parent: POINTER
			a_parent: POINTER
		do
			!! tvis.make
			tvis.set_sort
			tvis.set_parent (a_parent)
			!! tv_item.make
			tv_item.set_text ("Menu")
			tvis.set_tree_view_item (tv_item)
--			a_tree_view.insert_item (tvis)

			from
--				parent := a_tree_view.last_item
--				set_tree_view_item (parent)
				start
			until
				after
			loop
--				item.id.generate_tree_view (a_tree_view, parent)
--				item.set_tree_view_item (a_tree_view.last_item)
				forth
			end 
		end

	generate_wel_code is
			-- Generate the eiffel code.
		do
		end

end -- class TDS_MENU

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
