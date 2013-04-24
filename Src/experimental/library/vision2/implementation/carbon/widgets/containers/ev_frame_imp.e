note
	description:
		"Eiffel Vision frame. Carbon implementation"
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
			child_offset_top,
			minimum_height,
			minimum_width,
			child_offset_bottom,
			child_offset_right,
			child_offset_left
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			initialize
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create frame.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_right (100)
			rect.set_bottom (50)
			ret := create_group_box_control_external (null, rect.item, null, (True).to_integer, $ptr)
			set_c_object ( ptr )

			event_id := app_implementation.get_id (current)
		end

	initialize
			-- Initialize `Current'.
		local
			a_font: EV_FONT
		do
		--	set_style (Ev_frame_etched_in)
			align_text_left
			create a_font.default_create
			a_font.set_height (10)
			set_font (a_font)
			Precursor {EV_CELL_IMP}
		end

feature -- layout information

	child_offset_top: INTEGER
			--
		do
			Result := child_offset_bottom + font.height + 1
		end
	child_offset_bottom: INTEGER
	do
		Result := 4
	end

	child_offset_right: INTEGER
	do
		Result := 4
	end

	child_offset_left: INTEGER
	do
		Result := 4
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

	minimum_width: INTEGER
		local
			a,b: INTEGER
		do
			Result :=buffered_minimum_width.max (font.width * text.count)

		end

	minimum_height: INTEGER
		local
			a,b: INTEGER
		do
			Result := buffered_minimum_height
		end



feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME;
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_FRAME_IMP

