note
	description:
		"Eiffel Vision frame. Cocoa implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			interface,
			make
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			make,
			set_text
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			a_font: EV_FONT
		do
			create {NS_BOX}cocoa_item.make
			box.set_title_position ({NS_BOX}.no_title)

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

	set_text (a_text: STRING_GENERAL)
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			if a_text /= void and then not a_text.is_empty then
				box.set_title_position ({NS_BOX}.at_top)
				box.set_title (a_text)
			else
				box.set_title_position ({NS_BOX}.no_title)
			end
		end


feature -- Layout

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				mw := item_imp.minimum_width
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
			if item_imp /= Void and item_imp.is_show_requested then
				mh := item_imp.minimum_height
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
			if item_imp /= Void and item_imp.is_show_requested then
				mw := item_imp.minimum_width
				mh := item_imp.minimum_height
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

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_FRAME note option: stable attribute end;
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FRAME_IMP

