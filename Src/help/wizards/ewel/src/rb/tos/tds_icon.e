indexing
	description: "Icon representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ICON

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
			set_type (R_icon)
		end

feature -- Code generation

	display is
			-- Display the tds.
		local
			icon: TDS_ICON
		do
			from 
				start
			until 
				after
			loop
				icon ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NIcon ID : ")
				icon.id.display

				if (icon.load_and_mem_attributes /= Void) then
					icon.load_and_mem_attributes.display
				end                

				io.putstring ("%Nfilename = ")
				io.putstring (icon.filename)

				io.new_line
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		local
			icon: TDS_ICON
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// ICON%N")
			a_resource_file.putstring ("//%N%N")
			
			from 
				start
			until 
				after
			loop
				icon ?= item

				icon.id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" ICON ")


				if (icon.load_and_mem_attributes /= Void) then
					icon.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				a_resource_file.putstring (icon.filename)
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
-- 			tv_item.set_text ("Icon")
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

end -- class TDS_ICON

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
