indexing
	description: "Objects that lets user select a line style."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINE_STYLE_CHOOSER

inherit
	EV_COMBO_BOX
		
create
	make
		
feature {NONE} -- Initialization

	make is
			-- Create a LINE_STYLE_CHOOSER
		local
			l_item: EV_LIST_ITEM
			pixmap: EV_PIXMAP
			i, j: INTEGER
			item_data: TUPLE [INTEGER, BOOLEAN]
			dashed: BOOLEAN
		do
			default_create
			
			
			from
				j := 1
				dashed := False
			until
				j > 2
			loop
				from
					i := 1
				until
					i > 10
				loop
					create l_item
					create pixmap.make_with_size (50, 15)
					pixmap.set_line_width (i)
					if dashed then
						pixmap.enable_dashed_line_style
					end
					pixmap.draw_segment (0, pixmap.height // 2, pixmap.width, pixmap.height // 2)
					l_item.set_pixmap (pixmap)
					l_item.set_text (i.out+ " pxl")
					create item_data
					item_data.put_integer (i, 1)
					item_data.put_boolean (dashed, 2)
					l_item.set_data (item_data)
					extend (l_item)
					i := i * 2
				end
				dashed := not dashed
				j := j + 1
			end
			create l_item
			create pixmap.make_with_size (50, 15)
			l_item.set_pixmap (pixmap)
			l_item.set_text ("0 pxl")
			create item_data
			item_data.put_integer (0, 1)
			item_data.put_boolean (False, 2)
			l_item.set_data (item_data)
			extend (l_item)
		end
		
feature -- Access

	line_width: INTEGER is
			-- Selected line width.
		local
			item_data: TUPLE [INTEGER, BOOLEAN]
		do
			item_data ?= selected_item.data
			Result := item_data.integer_item (1)
		end

	is_dashed_line_style: BOOLEAN is
			-- Is dashed line style selected?
		local
			item_data: TUPLE [INTEGER, BOOLEAN]
		do
			item_data ?= selected_item.data
			Result := item_data.boolean_item (2)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class LINE_STYLE_CHOOSER
