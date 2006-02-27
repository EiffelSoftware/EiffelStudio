indexing
	description: "EiffelVision toolbar. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_DOCKABLE_TARGET_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_TOOL_BAR_ITEM]
		redefine
			interface
		end

feature -- Status report

	has_vertical_button_style: BOOLEAN is
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.
		deferred
		end

	is_vertical: BOOLEAN is
			-- Is vertical items layout?
		deferred
		end

feature -- Status setting

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		deferred
		ensure
			vertical_button_style_assigned: has_vertical_button_style
		end

	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		deferred
		ensure
			vertical_button_style_not_assigned: not has_vertical_button_style
		end

	enable_vertical is
			-- Enable vertical items layout.
		deferred
		ensure
			vertical_layout:
		end

	disable_vertical is
			-- Disable vertical items layout. Then items will be horizontal layout.
		deferred
		ensure
			not_vertical_layout:
		end

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	insertion_position: INTEGER is
			-- `Result' is index to left of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button. i.e if over button 1, `Result' is 0.
		deferred
		end

	block_selection_for_docking is
			-- Ensure that a tool bar button is not selected as a
			-- result of the transport ending.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_I

