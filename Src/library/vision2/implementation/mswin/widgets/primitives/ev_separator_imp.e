indexing 
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
			interface
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			on_getdlgcode
		redefine
			default_style,
			background_brush,
			on_erase_background
		end

feature {NONE} -- Initialization

 	make (an_interface: like interface) is
 			-- Make `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "EV_SEPARATOR")
 		end

feature {NONE} -- WEL Implementation

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background.
		do
			if exists then
				create Result.make_solid (wel_background_color)
			end
		end

	default_style: INTEGER is
			-- Default style of `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren
				+ Ws_clipsiblings
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

feature {EV_ANY_I}

	interface: EV_SEPARATOR;

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




end -- class EV_SEPARATOR_IMP

