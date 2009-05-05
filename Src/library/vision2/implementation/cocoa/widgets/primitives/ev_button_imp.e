indexing
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
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			make,
			set_default_minimum_size,
			is_sensitive,
			enable_sensitive,
			disable_sensitive
		end

	EV_PIXMAPABLE_IMP
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

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create {NS_BUTTON}cocoa_item.new
			button.set_action (
				agent
					do
						select_actions.call ([])
					end )
			align_text_center
		end

	initialize
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			pixmapable_imp_initialize
			Precursor {EV_PRIMITIVE_IMP}
			initialize_events
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?
		do
		end

feature -- Status Setting


	enable_default_push_button
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			top_level_window_imp.window.set_default_button_cell (button.cell)
		end

	disable_default_push_button
			-- Remove the style of the button corresponding
			-- to the default push button.
		do
			top_level_window_imp.window.set_default_button_cell (NULL)
		end

	enable_can_default
			-- Not necessary in Cocoa
		do
		end

	set_text (a_text: STRING_GENERAL) is
			--
		do
			if not text.is_equal (a_text) then
				if a_text.is_empty then
					set_default_minimum_size
				else
					accomodate_text (a_text)
				end
				Precursor {EV_TEXTABLE_IMP} (a_text)
				button.set_title (a_text)
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
			Result := button.is_enabled
		end

	enable_sensitive
			-- Allow the object to be sensitive to user input.
		do
			button.set_enabled (true)
		end

	disable_sensitive
			-- Set the object to ignore all user input.
		do
			button.set_enabled (false)
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

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	button: NS_BUTTON is
			--
		do
			Result ?= cocoa_item
			check
				cocoa_control_initialized: Result /= Void
			end
		end


indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_BUTTON_IMP
