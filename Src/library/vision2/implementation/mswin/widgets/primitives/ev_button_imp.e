indexing
	description: "EiffelVision push button.%
		% Mswindows implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_BUTTON_IMP
        
inherit
	EV_BUTTON_I

	EV_PRIMITIVE_IMP
		redefine
			plateform_build
		end
       
	EV_BAR_ITEM_IMP
        
	EV_TEXTABLE_IMP
		redefine
			set_default_size
		end
	
	EV_PIXMAPABLE_IMP
		undefine
			pixmap_size_ok
		redefine
			add_pixmap
		end

	EV_FONTABLE_IMP

	WEL_BN_CONSTANTS
		export
			{NONE} all
		end

	WEL_OWNER_DRAW_BUTTON
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_down,
			on_key_up
		redefine
			on_bn_clicked,
			default_process_message
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the label with an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create the label with `txt' as label.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, txt, 0, 0, 0, 0, 0)
			extra_width := 10
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			{EV_PRIMITIVE_IMP} Precursor (par)
			set_font (font)
			set_default_size
		end

feature -- Event - command association

	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is	
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		do
			add_command (Cmd_click, cmd, arg)
		end

feature {NONE} -- Implementation	
	
	extra_width: INTEGER

	set_default_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			-- A minimum width to be sure.
			w := extra_width
	
			-- The pixmap must go in,
			if pixmap_imp /= Void then
				w := w + pixmap_imp.width
				h := h + pixmap_imp.height + 11
			end

			-- the text too.
			if text /= "" then
				fw ?= font.implementation
				check
					font_not_void: fw /= Void
				end
				w := w + fw.string_width (Current, text)
				h := h.max (fw.string_height (Current, text) + 11)
				--7 * fw.string_height (Current, text) // 4 - 2)
			end

			-- Finaly, we set the minimum values.
			set_minimum_width (w)
			set_minimum_height (h)
		end

	on_bn_clicked is
			-- When the button is pressed
		do
			execute_command (Cmd_click, Void)
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
		   -- Process `msg' which has not been processed by
		   -- `process_message'.
		do
			if msg = Wm_erasebkgnd then
				disable_default_processing
			end
 		end

	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container
		do
			{EV_PIXMAPABLE_IMP} Precursor (pixmap)
			set_default_size
		end

	background_brush: WEL_BRUSH is
		do
			!! Result.make_solid (background_color_imp)
		end

	current_state: INTEGER
			-- An Integer to know if the button is up or down.
			-- We us an integer for the toggle buttons.

	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
			-- Called when the system ask to redraw
			-- the container
		local
			action: INTEGER
			dc: WEL_DC
		do
			action := struct.item_action
			dc := struct.dc
			if action = Oda_focus then
				draw_focus (dc)
			elseif action = Oda_select then
				select_action
				dc.fill_rect (client_rect, background_brush)
				draw_edge (dc)
				draw_focus (dc)
				draw_body (dc)
			elseif action = Oda_drawentire then
				dc.fill_rect (client_rect, background_brush)
				if struct.item_state = Ods_focus then
					draw_focus (dc)
				end
				draw_edge (dc)
				draw_body (dc)
			end
		end

	wel_window: WEL_WINDOW is
			-- Window used to create the pixmap : Current
		do
			Result ?= Current
		end

feature {NONE} -- Basic operation

	select_action is
			-- Action to be down when `Oda_select'.
			-- We obtain alway 0 or 1, the two states.
		do
			current_state := (current_state + 1) \\ 2
		end

	is_down: BOOLEAN is
			-- Say if the button is down or not.
		do
			if current_state = 0 then
				Result := False
			else
				Result := True
			end
		end

	draw_edge (dc: WEL_DC) is
			-- Draw the edge of the button.
		do
			if is_down then
				routine_draw_edge (dc, client_rect, Edge_sunken, Bf_rect)
			else
				routine_draw_edge (dc, client_rect, Edge_raised, Bf_rect + Bf_soft)
			end
		end

	draw_focus (dc: WEL_DC) is
			-- Draw the focus line around the button.
		local
			rect: WEL_RECT
		do
			!! rect.make (3, 3, width - 3, height - 3)
			draw_focus_rect (dc, rect)
		end

	draw_body (dc: WEL_DC) is
			-- Draw the body of the button : bitmap + text
		local
			inrect: WEL_RECT
			tx, ty: INTEGER
		do
			-- First, we set the rectangle we will draw in, it depends if the
			-- button is up or down
			if is_down then
				!! inrect.make (5, 6, width - 5, height - 5)
			else
				!! inrect.make (5, 5, width - 5, height - 6)
			end

			-- We select the brushes and color
			dc.set_text_color (foreground_color_imp)
			dc.set_background_color (background_color_imp)

			-- If sensitive, we draw everything normaly.
			if not insensitive then
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					dc.draw_centered_text (text, inrect)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
				elseif text /= "" then
					dc.draw_centered_text (text, inrect)
				end

			-- If insensitive, the text is gray.
			-- We don't set the pixmap gray, because the quality is bad.
			else
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					tx := inrect.left + (inrect.width - dc.string_width (text)) // 2
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2) 
					draw_insensitive_text (dc, text, tx, ty)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp, 0, 0, Srccopy)
				elseif text /= "" then
					tx := inrect.left + (inrect.width - dc.string_width (text)) // 2
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2)
					draw_insensitive_text (dc, text, tx, ty)
				end
			end
		end	

feature {NONE} -- WEL Implementation

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

end -- class EV_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
