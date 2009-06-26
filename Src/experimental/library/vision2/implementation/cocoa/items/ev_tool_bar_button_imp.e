note
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			update_for_pick_and_drop
		redefine
			interface,
			make,
			set_pixmap,
			cocoa_view
		end

	EV_DOCKABLE_SOURCE_IMP
		redefine
			interface
		end

	EV_SENSITIVE_IMP
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_NS_VIEW
		redefine
			interface,
			cocoa_view
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization of button box and events.
		do
			set_vertical_button_style
			create button.make
			--button.set_bezel_style ({NS_BUTTON}.rectangular_square_bezel_style)
			cocoa_view := button
			pixmapable_imp_initialize
			button.set_action (agent select_actions.call ([]))
			set_is_initialized (True)
		end

feature -- Measurement

	minimum_height: INTEGER = 20

	minimum_width: INTEGER = 20

feature -- Status Report

	has_vertical_button_style: BOOLEAN
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.

	is_vertical: BOOLEAN
			-- Are the buttons in `Current' arranged vertically?
		do
			if attached {EV_TOOL_BAR_IMP} parent as tool_bar_imp then
				Result := tool_bar_imp.is_vertical
			end
		end

	has_text: BOOLEAN
			-- Does the button have a text?
		do
		end

	has_pixmap: BOOLEAN
			-- Does the button have a pixmap?
		do
			Result := (pixmap /= Void)
		end

feature -- Access

	gray_pixmap: detachable EV_PIXMAP
			-- Image displayed on `Current'.

feature -- Element change

	disable_sensitive_internal
			--
		do

		end


	enable_sensitive_internal
			--
		do

		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			button.set_string_value (a_text)
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			-- First load the pixmap into the button
			pixmap_imp ?= a_pixmap.implementation
			check pixmap_imp /= void end
			button.set_image (pixmap_imp.image)
			-- TODO update minimum width
		end

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
			set_pixmap (a_gray_pixmap)
		end

	remove_gray_pixmap
			-- Make `pixmap' `Void'.
		do
			remove_pixmap
		end

	set_vertical_button_style
			-- If vertical button style is set, then text is placed below the pixmap (as opposed to 'to the right of')
		do
		end

	disable_vertical_button_style
			-- If vertical button style is disabled, then text is placed to the right of the pixmap (as opposed to 'below')
		do
		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	text_width: INTEGER
			-- Get the width (in pixel) of the text
		do
		end

	call_select_actions
			-- Call the select_actions for `Current'
		do
		end

	in_select_actions_call: BOOLEAN
		-- Is `Current' in the process of having its select actions called

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
		do
			create Result
		end

	create_drop_down_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- 	Create a drop down action sequence.
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	char_length: INTEGER = 5;
	char_height: INTEGER = 15;
	padding: INTEGER = 10;

feature {LAYOUT_INSPECTOR, EV_ANY_I} -- Implementation

	button: NS_BUTTON;

	cocoa_view: NS_VIEW

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_BUTTON note option: stable attribute end;

end -- class EV_TOOL_BAR_BUTTON_IMP
