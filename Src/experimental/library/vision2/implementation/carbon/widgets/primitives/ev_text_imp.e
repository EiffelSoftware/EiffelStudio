note

	description:
		"EiffelVision text area, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		redefine
			interface,
			text_length
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			insert_text,
			initialize,
			create_change_actions,
			dispose,
			text_length,
			default_key_processing_blocked,
			minimum_height,
			minimum_width
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			dispose
		end

	EV_CARBON_TXN
		redefine
			make,
			interface,
			initialize,
			default_key_processing_blocked,
			dispose,
			minimum_height,
			minimum_width
		end

	MACTEXTEDITOR_FUNCTIONS_EXTERNAL
	HIVIEW_FUNCTIONS_EXTERNAL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a carbon text view.
		local
			ret: INTEGER
			struct_ptr: POINTER
			buffer: C_STRING
			point : CGPOINT_STRUCT
			size : CGSIZE_STRUCT
			rect : CGRECT_STRUCT
			a_string: C_STRING
		do
			base_make (an_interface)

			create point.make_new_unshared
			create rect.make_new_unshared
			create size.make_new_unshared

			size.set_height(100)
			size.set_width (100)
			point.set_x (0)
			point.set_y (0)
			rect.set_origin (point.item)
			rect.set_size (size.item)

			ret := hitext_view_create_external (null, 0, kTXNSystemDefaultEncoding, $c_object)
			ret := hiview_set_visible_external (c_object, 1)
			entry_widget := hitext_view_get_txnobject_external (c_object)

			ret := hiview_set_frame_external (c_object, rect.item)
			event_id := app_implementation.get_id (current)  --getting an id from the application
		end

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Hook up the change actions for the text widget
		do
			create Result.default_create
		end

	initialize
			-- Initialize `Current'
		do
			enable_word_wrapping
			set_editable (True)
			set_background_color ((create {EV_STOCK_COLORS}).white)
			initialize_buffer_events
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

	initialize_buffer_events
			-- Initialize events for `Current'
		do

		end

feature -- Status report

	line_number_from_position (i: INTEGER): INTEGER
			-- Line containing caret position `i'.
		local
			ret: INTEGER
			point: POINTER
		do
			--ret := txnoffset_to_hipoint (entry_widget, i, $point)

		end

feature -- Access

	line (a_line: INTEGER): STRING_32
			-- Returns the content of line `a_line'.
		do

		end

	first_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the first character on line `a_line'.
		do

		end

	last_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the last character on line `a_line'.
		do

		end

feature -- Status report

	text_length: INTEGER
			-- Number of characters in `Current'
		do
			Result := get_text_length (entry_widget, kTXNStartOffset, kTXNEndOffset)

		end

	line_count: INTEGER
			-- Number of display lines present in widget.
		do
			Result := line_number_from_position (kTXNEndOffset+1)
		end

	current_line_number: INTEGER
			-- Returns the number of the display line the cursor currently
			-- is on.
		do
			Result := line_number_from_position (caret_position)
		end

	has_word_wrapping: BOOLEAN
			-- Does `Current' have word wrapping enabled?

feature -- Status setting

feature -- Basic operation

	scroll_to_line (i: INTEGER)
			-- Scroll `Current' to line number `i'
		do

		end

	scroll_to_end
			-- Scroll to the last line position of `Current'.
		do
		end

	enable_word_wrapping
			-- Enable word wrapping for `Current'
		do
			has_word_wrapping := true
		end

	disable_word_wrapping
			-- Disable word wrapping for `Current'
		do
			has_word_wrapping := False
		end

feature -- Minimum size

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 1 -- Hardcoded, TODO calculate a meaningful height depending on the content
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 40 -- Hardcoded, TODO calculate a meaningful width depending on the content
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN
			--	Does `a_key' require default key processing to be blocked?
		do

		end

	dispose
			-- Clean up `Current'
		do
			precursor {EV_CARBON_TXN}
		end

	on_change_actions
			-- The text within the widget has changed.
		do

		end

	visual_widget: POINTER
			do
				Result := entry_widget
			end

	text_view: POINTER
		-- Pointer to the ??? widget

	scrolled_window: POINTER
		-- Pointer to the ???

	text_buffer: POINTER
			-- Pointer to the ???

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT;

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_TEXT_IMP

