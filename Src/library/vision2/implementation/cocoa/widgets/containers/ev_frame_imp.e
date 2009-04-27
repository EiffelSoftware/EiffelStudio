indexing
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
		undefine
			make
		redefine
			interface,
			initialize,
			compute_minimum_height,
			compute_minimum_width,
			compute_minimum_size
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			initialize,
			set_text
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create frame.
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.new
			box.set_title_position ({NS_BOX}.no_title)
		end

	initialize
			-- Initialize `Current'.
		local
			a_font: EV_FONT
		do
			align_text_left
			create a_font.default_create
			a_font.set_height (10)
			set_font (a_font)
			Precursor {EV_CELL_IMP}
		end

feature -- Access

	style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		do
			Result := {EV_FRAME_CONSTANTS}.Ev_frame_etched_in
		end

feature -- Element change

	set_style (a_style: INTEGER)
			-- Assign `a_style' to `style'.
		do
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
			--mw := mw + client_x + border_width
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
			--mw := mw + client_x + border_width
			--mw := mw.max (text_width + 2 * Text_padding)			
			internal_set_minimum_size (mw, mh)
		end

	client_y: INTEGER is 22;

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME;
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FRAME_IMP

