note
	description:
		"Eiffel Vision button. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		select
			copy
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			set_default_minimum_size,
			is_sensitive,
			enable_sensitive,
			disable_sensitive,
			dispose
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface,
			make,
			set_pixmap
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			make,
			set_text,
			align_text_left,
			align_text_center,
			align_text_right
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			make
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface
		end

	NS_BUTTON
		rename
			make as cocoa_make,
			initialize as cocoa_initialize,
			font as cocoa_font,
			alignment as cocoa_alignment,
			set_font as cocoa_set_font,
			copy as cocoa_copy
		redefine
			mouse_down,
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			Precursor {EV_PRIMITIVE_IMP}

			cocoa_make
			cocoa_item := current
			set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			align_text_center

			enable_tabable_to
			enable_tabable_from
			initialize_events
			pixmapable_imp_initialize

			set_action (agent select_actions.call ([]))
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?
		do
			Result := top_level_window_imp.default_button_cell /= void and then top_level_window_imp.default_button_cell.is_equal (cell)
		end

feature -- Status Setting

	align_text_left
			-- <Precursor>
		do
			Precursor
			set_alignment ({NS_CONTROL}.left_text_alignment)
		end

	align_text_center
			-- <Precursor>
		do
			Precursor
			set_alignment ({NS_CONTROL}.center_text_alignment)
		end

	align_text_right
			-- <Precursor>
		do
			Precursor
			set_alignment ({NS_CONTROL}.right_text_alignment)
		end

	enable_default_push_button
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			set_key_equivalent ("%R")
			--top_level_window_imp.window.set_default_button_cell (cell)
		end

	disable_default_push_button
			-- Remove the style of the button corresponding
			-- to the default push button.
		do
			if attached top_level_window_imp then
				top_level_window_imp.window.set_default_button_cell (void)
			end
		end

	enable_can_default
			-- Not necessary in Cocoa ??
		do
		end

	set_text (a_text: STRING_GENERAL)
			--
		do
			if not text.is_equal (a_text) then
				if a_text.is_empty then
					set_default_minimum_size
				else
					accomodate_text (a_text)
				end
				Precursor {EV_TEXTABLE_IMP} (a_text)
				set_title (a_text)
			end
		end

feature -- Measurement

	set_default_minimum_size
			-- Reset `Current' to its default minimum size.
		do
			-- TODO: This is not very smart at the moment!
			-- Caluclate dynamically (this depends on the button style and the text)
			accomodate_text (" ")
		end

	accomodate_text (a_text: STRING_GENERAL)
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
		do
			t := internal_font.string_size (a_text)
			a_width := t.width
			a_height := t.height
			internal_set_minimum_size (a_width.abs + 30, a_height.abs + 10)
		end

feature -- Sensitivity

	is_sensitive: BOOLEAN
			-- Is the object sensitive to user input.
		do
			Result := is_enabled
		end

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		do
			set_enabled (True)
			set_needs_display (True)
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		do
			set_enabled (False)
			set_needs_display (True)
		end

feature {NONE} -- implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		do
		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	mouse_down (a_event: NS_EVENT)
		local
			x, y: INTEGER
			l_screen_x, l_screen_y: INTEGER
		do
			x := a_event.location_in_window.x
			y := a_event.location_in_window.y
			pointer_button_press_actions.call ([x, y, 0, 0.0, 0.0, 0.0, l_screen_x, l_screen_y])
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
		do
			if attached {EV_PIXMAP_IMP} a_pixmap.implementation as pixmap_imp then
--				set_bezel_style ({NS_BUTTON}.rectangular_square_bezel_style)
--				set_image (pixmap_imp.image)
			end
		end

feature {EV_ANY_I} -- implementation

	dispose
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {NS_BUTTON}
		end

	interface: detachable EV_BUTTON note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_BUTTON_IMP
