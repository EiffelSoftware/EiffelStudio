note
	description: "Eiffel Vision frame. Cocoa implementation"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CELL_IMP
		redefine
			interface,
			make,
			compute_minimum_height,
			compute_minimum_width,
			compute_minimum_size
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			a_font: EV_FONT
			l_box: NS_BOX
		do
			create l_box.make
			l_box.set_title_position ({NS_BOX}.no_title)
			cocoa_view := l_box

			align_text_left
			create a_font.default_create
			a_font.set_height (10)
			set_font (a_font)
			set_is_initialized (True)
			style := {EV_FRAME_CONSTANTS}.Ev_frame_etched_in
			initialize
		end

feature -- Access

	style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.

feature -- Element change

	set_style (a_style: INTEGER)
			-- Assign `a_style' to `style'.
		do
			if a_style = {EV_FRAME_CONSTANTS}.Ev_frame_lowered or a_style = {EV_FRAME_CONSTANTS}.Ev_frame_etched_in then
				box.set_border_type ({NS_BOX}.bezel_border)
			else
				box.set_border_type ({NS_BOX}.groove_border)
			end
			style := a_style
		end

	set_text (a_text: READABLE_STRING_GENERAL)
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			if a_text /= void and then not a_text.is_empty then
				box.set_title_position ({NS_BOX}.at_top)
				box.set_title (a_text)
			else
				box.set_title_position ({NS_BOX}.no_title)
			end
		end

	set_border_width (value: INTEGER)
			-- Make `value' the new border width of `Current'.
		do
			border_width := value
		end

feature -- Layout

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
			end
			mw := mw + client_x --+ border_width
			--mw := mw.max (text_width + 2 * Text_padding)			
			internal_set_minimum_width (mw)
		end

	compute_minimum_height
			-- Recompute the minimum_width of `Current'.
		local
			mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := l_item_imp.minimum_height
			end
			mh := mh + client_y
			internal_set_minimum_height (mh)
		end

	compute_minimum_size
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		local
			mw, mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
				mh := l_item_imp.minimum_height
			end
			mh := mh + client_y
			mw := mw + client_x --+ border_width
			--mw := mw.max (text_width + 2 * Text_padding)
			internal_set_minimum_size (mw, mh)
		end

	client_x: INTEGER = 14;

	client_y: INTEGER
		do
			if box.title_position = {NS_BOX}.no_title then
				Result := 14
			else
				Result := 18
			end
		end

	box: NS_BOX
		do
			check attached {NS_BOX} cocoa_view as l_result then
				Result := l_result
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FRAME note option: stable attribute end;
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_FRAME_IMP
