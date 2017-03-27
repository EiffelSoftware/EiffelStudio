note
	description: "EiffelVision horizontal separator. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface,
			make,
			on_size
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			default_style,
			background_brush,
			on_erase_background
		end

feature -- Initialization

 	old_make (an_interface: attached like interface)
 			-- Make `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
 		end

	make
		do
			wel_make (default_parent, "EV_SEPARATOR")
			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
			disable_tabable_to
		end

feature -- Access

	background_brush: detachable WEL_BRUSH
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background.
		do
			if exists then
				create Result.make_solid (wel_background_color)
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- Default style of `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren
				+ Ws_clipsiblings
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	on_size (size_type, a_width, a_height: INTEGER_32)
			-- Wm_size message
		do
			if parent /= Void then
					-- We make sure that separators are redrawn
					-- on reallocation
				invalidate_without_background
			end
			Precursor (size_type, a_width, a_height)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_SEPARATOR_IMP
