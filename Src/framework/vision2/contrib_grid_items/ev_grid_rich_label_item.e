note
	description: "[
		Cell consisting of a text label with optional pixmap.
		The rules governing the position of `text' and `pixmap' in relation to `Current' are as follows:

		Both `text' and `pixmap' are always drawn completely within the area goverened by `left_border', `right_border',
		`top_border' and `bottom_border', which will be referred to as the "redraw_client_area" in this description.
		Note that `text' may be automatically ellipsized (clipped with three dots) to ensure this.

		`pixmap' is always displayed to the very left edge of "redraw_client_area" and centered vertically. The only method
		of overriding this behavior is to set a custom `layout_procedure'.

		`text' may be aligned within "redraw_client_area" via the following features: 'align_text_left', `align_text_center',
		`align_text_right', `align_text_top', `align_text_vertically_center' and `align_text_bottom'. Note that the text
		alignment has no effect on the position of the pixmap which follows the rules listed above.

		A `layout_procedure' may be set which permits you to override the position of `text' and `pixmap' by computing the redraw
		positions manually. The drawing is clipped to "redraw_client_area' although there is no restriction on the positions that
		may be set for `text' and `pixmap'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_RICH_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			initialize,
			create_implementation,
			create_interface_objects,
			implementation
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create formats.make
		end

	initialize
			-- Mark `Current' as initialized.
		do
			Precursor {EV_GRID_LABEL_ITEM}
		end

feature -- Status Setting

	add_formatted_text (a_text: STRING_GENERAL; a_color: detachable EV_COLOR; a_font: detachable EV_FONT)
		require
			a_text_non_empty: a_text /= Void and then not a_text.is_empty
			not_destroyed: not is_destroyed
		local
			l_current_text: like text
			l_offset: INTEGER
		do
			l_current_text := text
			l_offset := l_current_text.count + 1
			l_current_text.append_string_general (a_text)
			set_formatting ([l_offset, a_color, a_font])
		end

	add_formatting,	set_formatting (a_format: TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT])
		require
			not_destroyed: not is_destroyed
			a_formats_not_void: a_format /= Void
		local
			l_formats: like formats
		do
			l_formats := formats
			if l_formats.count = 0 and a_format.offset > 0 then
				l_formats.extend ([1, Void, Void])
			end
			l_formats.extend (a_format)
			implementation.string_size_changed
		end

	clear_formatting
		do
			formats.wipe_out
		end

feature -- Status report

	formats: LINKED_LIST [TUPLE [offset: INTEGER; color: detachable EV_COLOR; font: detachable EV_FONT]]
		-- Formats appearance for `Current'.

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_RICH_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_RICH_LABEL_ITEM_I} implementation.make
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




end

