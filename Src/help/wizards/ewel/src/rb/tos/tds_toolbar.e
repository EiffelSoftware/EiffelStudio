indexing
	description: "Toolbar representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_TOOLBAR

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
			!! button_list.make
			set_type (R_toolbar)
		end

feature -- Access

	width: INTEGER
			-- Width of the toolbar button.

	height: INTEGER 
			-- Height of the toolbar button.

	button_list: LINKED_LIST [TDS_ID]
			-- List of toolbar's buttons in the current parsed TOOLBAR resource.


feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		do
			height := a_height
		ensure
			height_set: height = a_height
		end

	insert_button (a_button: TDS_ID) is
			-- Insert `a_button' in the `button_list'
			-- If `a_button' is Void, we considere that it's a separator.
		do
			button_list.extend (a_button)
		ensure
			a_button_inserted: button_list.count = old button_list.count + 1
		end

feature -- Code generation

	display is                     
		local
			toolbar: TDS_TOOLBAR
		do
			from 
				start
			until 
				after
			loop
				toolbar ?= item

				io.putstring ("%N------------------------------------")
				io.putstring ("%NToolbar : ")
				toolbar.id.display
				
				if (toolbar.load_and_mem_attributes /= Void) then
					toolbar.load_and_mem_attributes.display
				end                

				if (toolbar.options /= Void) then
					io.new_line
					toolbar.options.display
				end

                                io.putint( toolbar.width)
				io.putstring (" ")
				io.putint (toolbar.height)
				io.putstring (" ")

				if (toolbar.button_list /= Void) then
					from 
						toolbar.button_list.start
					until
						toolbar.button_list.after
			
					loop
						if toolbar.button_list.item /= Void then
							toolbar.button_list.item.display
						else
							io.putstring ("SEPARATOR")
						end
						io.new_line
						toolbar.button_list.forth
					end
				end

				io.new_line
				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		local
			toolbar: TDS_TOOLBAR
		do
			a_resource_file.putstring ("%N////////////////////////////////////////////////////////////////%N")
			a_resource_file.putstring ("//%N")
			a_resource_file.putstring ("// TOOLBAR%N")
			a_resource_file.putstring ("//%N")

			from 
				start
			until 
				after
			loop
				toolbar ?= item

				toolbar.id.generate_resource_file (a_resource_file)
				a_resource_file.putstring (" TOOLBAR ")
				
				if (toolbar.load_and_mem_attributes /= Void) then
					toolbar.load_and_mem_attributes.generate_resource_file (a_resource_file)
				end                

				if (toolbar.options /= Void) then
					toolbar.options.generate_resource_file (a_resource_file)
				end

				a_resource_file.putint (toolbar.width)
				a_resource_file.putstring (", ")
				a_resource_file.putint (toolbar.height)

				a_resource_file.putstring ("%NBEGIN")

				if (toolbar.button_list /= Void) then
					from 
						toolbar.button_list.start
					until
						toolbar.button_list.after
			
					loop
						if toolbar.button_list.item /= Void then
        						a_resource_file.putstring ("%N%TBUTTON%T")
							toolbar.button_list.item.generate_resource_file (a_resource_file)
						else
							a_resource_file.putstring ("%N%TSEPARATOR")
						end
						toolbar.button_list.forth
					end
				end

				a_resource_file.putstring ("%NEND%N%N")

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
-- 			!! tvis.make
-- 			tvis.set_sort
-- 			tvis.set_parent (a_parent)
-- 			!! tv_item.make
-- 			tv_item.set_text ("Toolbar")
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
end -- class TDS_STRINGTABLE

