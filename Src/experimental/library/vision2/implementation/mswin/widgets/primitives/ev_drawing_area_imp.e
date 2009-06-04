note
	description: "EiffelVision drawing area. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			make, interface, destroy, get_dc, release_dc, redraw
		end

	EV_PRIMITIVE_IMP
		undefine
			set_background_color,
			set_foreground_color,
			background_color_internal,
			foreground_color_internal
		redefine
			interface, make, on_left_button_down,
			on_middle_button_down, on_right_button_down,
			destroy
		end

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			wel_set_font,
			wel_font,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_paint,
			on_erase_background,
			class_background,
			default_style,
			class_style
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' empty with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
			-- Set up action sequence connections
			-- and `Precursor' initialization.
		do
			wel_make (default_parent, "Drawing area")

			Precursor {EV_PRIMITIVE_IMP}

			create screen_dc.make (Current)
			internal_paint_dc := screen_dc
			internal_paint_dc.get

			Precursor {EV_DRAWABLE_IMP}

			disable_tabable_from
		end

feature -- Access

	dc: WEL_DC
			-- The device context of the control.
		do
			check internal_paint_dc /= Void end
			Result := internal_paint_dc
		end

feature {NONE} -- Implementation

	in_paint: BOOLEAN
			-- Are we inside an onPaint event?

	release_dc
			-- Release the dc if not already released
		do
			if not in_paint then
				check internal_paint_dc /= Void end
				if internal_paint_dc.exists then
					internal_paint_dc.release
				end

				internal_initialized_font := False
				internal_initialized_text_color := False
			end
		end

	get_dc
			-- Get the dc if not already get.
		do
			if not in_paint then
				check internal_paint_dc /= Void end
				if not internal_paint_dc.exists then
					internal_paint_dc.get
					internal_paint_dc.set_background_transparent
					if attached internal_pen as l_internal_pen then
						internal_paint_dc.select_pen (l_internal_pen)
					else
						internal_paint_dc.select_pen (empty_pen)
					end

					if attached internal_brush as l_internal_brush then
						internal_paint_dc.select_brush (l_internal_brush)
					else
						internal_paint_dc.select_brush (empty_brush)
					end
					if valid_rop2_constant (wel_drawing_mode) then
						internal_paint_dc.set_rop2 (wel_drawing_mode)
					end
				end
			end
		end

	to_be_cleared: BOOLEAN
			-- Should the area be cleared?

	class_background: WEL_BRUSH
			-- Set the class background to NULL in order
			-- to have full control on the WM_ERASEBKG event
			-- (on_erase_background)
		once
			create Result.make_by_pointer (Default_pointer)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Process Wm_erasebkgnd message.
		do
			if to_be_cleared then
				to_be_cleared := False
				paint_dc.fill_rect(invalid_rect, our_background_brush)
			end

				-- Disable the default windows processing.
			disable_default_processing

				-- return a correct value to Windows, i.e. nonzero value
				-- to tell windows no to erase the background.
			set_message_return_value (to_lresult (1))
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
				-- Call registered onPaint actions
			if expose_actions_internal /= Void then
					-- Switch the dc from screen_dc to paint_dc.
				internal_paint_dc := paint_dc
				in_paint := True

					-- Initialise the device for painting.
				dc.set_background_transparent
				internal_initialized_pen := False
				internal_initialized_background_brush := False
				internal_initialized_brush := False
				internal_initialized_text_color := False

				expose_actions_internal.call ([
					invalid_rect.x,
					invalid_rect.y,
					invalid_rect.width,
					invalid_rect.height
					])

					-- Switch back the dc from paint_dc to screen_dc.
				check screen_dc /= Void end
				internal_paint_dc := screen_dc
				in_paint := False

					-- Without disabling it looks like we will not be getting all
					-- the WM_PAINT messages we expected to receive (leaving some
					-- unrefresh part on the drawing area).
				disable_default_processing
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	clear_and_redraw_rectangle (x1, y1, a_width, a_height: INTEGER)
			-- Redraw the rectangle at (`x1',`y1') with width `a_width' and
			-- height `a_height'.
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			wel_rect.set_rect (x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect (wel_rect, True)
		end

	clear_and_redraw
			-- Redraw the application screen
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			invalidate
		end

	redraw_rectangle (x1, y1, a_width, a_height: INTEGER)
			-- Redraw the rectangle at (`x1',`y1') with width
			-- `a_width' and height and `a_height'.
		do
				-- Ask windows to redraw the rectangle
				-- Windows will then call on_paint.
			wel_rect.set_rect (x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect(wel_rect, False)
		end

	redraw
			-- Redraw the application screen
		do
				-- Ask windows to redraw the entire window
				-- Windows will call on_erase_background (which
				-- will do nothing since to_be_cleared = False)
				-- and then on_paint.
			invalidate
		end

	flush
			-- Update immediately the screen if needed.
		do
			update
		end

	default_style: INTEGER
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren + Ws_clipsiblings
		end

	class_style: INTEGER
   			-- Standard style used to create the window class.
   			-- Can be redefined to return a user-defined style.
   		once
			Result := cs_dblclks | cs_owndc
 		end

feature -- Commands.

	destroy
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			Precursor {EV_DRAWABLE_IMP}
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {NONE} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end

feature {EV_DRAWABLE_IMP} -- Internal datas.

	internal_paint_dc: detachable WEL_DC note option: stable attribute end
			-- dc we use when painting

	screen_dc: detachable WEL_CLIENT_DC note option: stable attribute end;
			-- dc we use when painting outside a WM_PAINT message

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




end -- class EV_DRAWING_AREA_IMP









