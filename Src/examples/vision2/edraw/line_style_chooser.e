note
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

	make
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

	line_width: INTEGER
			-- Selected line width.
		do
			if attached selected_item as l_item and then attached {TUPLE [width: INTEGER; is_dashed_line: BOOLEAN]} l_item.data as l_data then
				Result := l_data.width
			end
		end

	is_dashed_line_style: BOOLEAN
			-- Is dashed line style selected?
		do
			if attached selected_item as l_item and then attached {TUPLE [width: INTEGER; is_dashed_line: BOOLEAN]} l_item.data as l_data then
				Result := l_data.is_dashed_line
			end
		end

note
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
