indexing
	description: "Animated-cursor representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ANICURSOR

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
			set_type (R_anicursor)
        	end

feature -- Code generation

	display is
			-- Display the tds.
		local
			the_cursor: TDS_ANICURSOR
		do
			from 
				start
			until 
				after
			loop
				the_cursor ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NAnicursor ID: ")
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
			a_resource_file.putstring ("// ANICURSOR%N")
			a_resource_file.putstring ("//%N%N")
			
			from 
				start
			until 
				after
			loop
				the_cursor ?= item

				the_cursor.id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" ANICURSOR ")

				if (the_cursor.load_and_mem_attributes /= Void) then
					the_cursor.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				a_resource_file.putstring (the_cursor.filename)
				a_resource_file.put_new_line
				forth
			end

			a_resource_file.new_line
		end

	generate_tree_view (a_tree_view: WEL_TREE_VIEW; a_parent: POINTER) is
			-- Generate `a_tree_view' control from the tds memory structure.
		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
			parent: POINTER
		do
			!! tvis.make
			tvis.set_sort
			tvis.set_parent (a_parent)
			!! tv_item.make
			tv_item.set_text ("Anicursor")
			tvis.set_tree_view_item (tv_item)
			a_tree_view.insert_item (tvis)

			from
				parent := a_tree_view.last_item
				set_tree_view_item (parent)
				start
			until
				after
			loop
				item.id.generate_tree_view (a_tree_view, parent)
				item.set_tree_view_item (a_tree_view.last_item)
				forth
			end 
		end

	generate_wel_code is
			-- Generate the eiffel code.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TDS_ANICURSOR

