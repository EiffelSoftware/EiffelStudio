indexing
	description: "Stringtable representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STRINGTABLE

inherit
	TDS_RESOURCE
		rename
			make as list_make
		end

creation
	make

feature	-- initialization

	make is
		do
			list_make
			!! strings_list.make
			set_type (R_stringtable)
		end

feature -- Access

	current_string: TDS_STRING
			-- The current parsed string.
	
	strings_list: LINKED_LIST [TDS_STRING]
			-- List of stringtable strings.

feature -- Element change

	set_current_string (a_string: TDS_STRING) is
			-- Set `current_string' to `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			current_string := a_string
		ensure
			current_string_set: current_string = a_string
		end

	
	insert_string (a_string: TDS_STRING) is
			-- Insert `a_string' into `strings_list'
		require
			a_string_not_void: a_string /= Void
		do
			strings_list.extend (a_String)
		ensure
			a_string_inserted: strings_list.count = old strings_list.count + 1
		end

feature -- Code generation

	display is
		local
			stringtable: TDS_STRINGTABLE
		do
			from 
				start
			until 
				after
			loop
				stringtable ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NStringtable : ")
				
				if (stringtable.load_and_mem_attributes /= Void) then
					stringtable.load_and_mem_attributes.display
				end                

				if (stringtable.options /= Void) then
					io.new_line
					stringtable.options.display
				end

				if (stringtable.strings_list /= Void) then
					from 
						stringtable.strings_list.start
					until
						stringtable.strings_list.after
			
					loop
						stringtable.strings_list.item.display
						io.new_line
						stringtable.strings_list.forth
					end
				end

				io.new_line
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		local
			stringtable: TDS_STRINGTABLE
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// STRINGTABLE%N")
			a_resource_file.putstring ("//%N")

			from 
				start
			until 
				after
			loop
				stringtable ?= item

				a_resource_file.putstring ("%NSTRINGTABLE ")

				if (stringtable.load_and_mem_attributes /= Void) then
					stringtable.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				if (stringtable.options /= Void) then
					a_resource_file.new_line
					stringtable.options.generate_resource_file (a_resource_file)
				end


				a_resource_file.putstring ("%NBEGIN")
				if (stringtable.strings_list /= Void) then
					from 
						stringtable.strings_list.start
					until
						stringtable.strings_list.after
			
					loop
						a_resource_file.new_line
						stringtable.strings_list.item.generate_resource_file (a_resource_file)
						stringtable.strings_list.forth
					end
				end
				a_resource_file.putstring ("%NEND")

				a_resource_file.new_line
				forth
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
--			!! tvis.make
--			tvis.set_sort
--			tvis.set_parent (a_parent)
--			!! tv_item.make
--			tv_item.set_text ("Stringtable")
--			tvis.set_tree_view_item (tv_item)
--			a_tree_view.insert_item (tvis)

--			!! tvis.make
--			tvis.set_sort
--			tvis.set_parent (a_tree_view.last_item)
--			!! tv_item.make
--			tv_item.set_text ("Stringtable")
--			tvis.set_tree_view_item (tv_item)
--			a_tree_view.insert_item (tvis)

--			set_tree_view_item (a_tree_view.last_item)
		end

	generate_wel_code is
			-- Generate the eiffel code.
		do
		end

end -- class TDS_STRINGTABLE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
