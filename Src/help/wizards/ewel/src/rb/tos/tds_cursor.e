indexing
	description: "Cursor representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_CURSOR

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

creation
	make

feature	-- Initialization

	make is
		do
			list_make
			set_type (R_cursor)
        	end

feature -- Code generation

	display is
			-- Display the tds.
		local
			the_cursor: TDS_CURSOR
		do
			from 
				start
			until 
				after
			loop
				the_cursor ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NCursor ID: ")
				the_cursor.id.display

				if (the_cursor.load_and_mem_attributes /= Void) then
					the_cursor.load_and_mem_attributes.display
				end                

				io.putstring ("%Nfilename = ")
				io.putstring (the_cursor.filename)

				io.new_line
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		local
			the_cursor: TDS_CURSOR
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// CURSOR%N")
			a_resource_file.putstring ("//%N%N")
			
			from 
				start
			until 
				after
			loop
				the_cursor ?= item

				the_cursor.id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" CURSOR ")

				if (the_cursor.load_and_mem_attributes /= Void) then
					the_cursor.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				a_resource_file.putstring (the_cursor.filename)
				forth
			end

			a_resource_file.new_line
		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is
			-- Generate `a_tree_view' control from the tds memory structure.
		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
			parent: POINTER
			a_parent: POINTER
		do
-- 			!! tvis.make
-- 			tvis.set_sort
-- 			tvis.set_parent (a_parent)
-- 			!! tv_item.make
-- 			tv_item.set_text ("Cursor")
-- 			tvis.set_tree_view_item (tv_item)
-- 			a_tree_view.insert_item (tvis)
-- 
-- 			from
-- 				parent := a_tree_view.last_item
-- 				set_tree_view_item (parent)
-- 				start
-- 			until
-- 				after
-- 			loop
-- 				item.id.generate_tree_view (a_tree_view, parent)
-- 				item.set_tree_view_item (a_tree_view.last_item)
-- 				forth
-- 			end 
		end

	generate_wel_code is
			-- Generate the eiffel code.
		do
		end

end -- class TDS_CURSOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
