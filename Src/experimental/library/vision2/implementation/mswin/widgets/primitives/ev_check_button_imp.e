note
	description: "Eiffel Vision check button. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end

	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			enable_select,
			disable_select,
			default_style,
			interface,
			make,
			internal_default_height,
			set_default_minimum_size,
			set_background_color
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create the check button with no label.
		do
			Precursor
			extra_width := 20
			text_alignment := default_alignment
		end

feature -- Status setting

	set_default_minimum_size
			-- Reset `Current' to its default minimum size.
		do
				-- This extra width only needs to be added if
				-- we are using a large font, hence we do nothing
				-- with the system font.
 			if not has_system_font and not text.is_empty then
 				if attached private_font as l_private_font then
	 				extra_width := 20 + l_private_font.implementation.height // 2
	 			elseif attached private_wel_font as l_private_wel_font then
 					extra_width := 20 + l_private_wel_font.height // 2
 				end
 			end
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	enable_select
			-- Make `is_selected' True.
		do
			{WEL_API}.send_message (wel_item, bm_setcheck, to_wparam (1), to_lparam (0))
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	disable_select
			-- Make `is_selected' False.
		do
			{WEL_API}.send_message (wel_item, bm_setcheck, to_wparam (0), to_lparam (0))
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

feature {NONE} -- Implementation

	internal_default_height: INTEGER
			-- The default minimum height of `Current' with no text.
			-- This is used in set_default_size.
		do
				--|FIXME As soon as we find a nice way to
				--| know how large the check part of `Current'
				--| will be drawn by Windows, we can query this directly.
			Result := 13
		end

	default_style: INTEGER
			-- Not visible or child at creation
		do
			Result := Ws_child | Ws_visible | Ws_group
					| Ws_tabstop | Ws_clipchildren | Ws_clipsiblings
					| Bs_autocheckbox
		end

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CHECK_BUTTON note option: stable attribute end;

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

end -- class EV_CHECK_BUTTON_IMP
