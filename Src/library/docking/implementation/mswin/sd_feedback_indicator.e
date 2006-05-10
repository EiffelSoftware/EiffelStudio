indexing
	description: "Objecs that use layered windows to feedback display indicators"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_INDICATOR

inherit
	SD_DIALOG
		rename
			parent as parent_dialog,
			make as make_dlg,
			on_timer as on_timer_wel_dialog,
			destroy as real_destroy,
			show as wel_show
		export
			{NONE} all
			{ANY} exists
		end

create
	make

feature {NONE} -- Initlization

	make (a_pixmap: EV_PIXMAP; a_parent_window: EV_WINDOW) is
			-- Creation method.
		require
			not_void: a_pixmap /= Void
		local
			l_composite_window: WEL_COMPOSITE_WINDOW
		do
			l_composite_window ?= a_parent_window.implementation
			check not_void: l_composite_window /= Void end
			make_dlg (l_composite_window)

			set_ex_style ({WEL_WS_CONSTANTS}.ws_ex_layered)

			pixmap := a_pixmap
		ensure
			set: pixmap = a_pixmap
		end

feature -- Command

	show is
			-- Show
		do
			create timer
			timer.set_interval (timer_interval)

			timer.actions.extend (agent on_timer)
			alpha := alpha_step

			wel_show
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		do
			pixmap := a_pixmap
			if exists then
				update_layered_window_rgba (alpha)
			end
		ensure
			set: pixmap = a_pixmap
		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position
		do
			set_x (a_screen_x)
			set_y (a_screen_y)
		end

	destroy is
			-- Redefine with fading effect.
		require
			exists: exists
		do
			if not timer.is_destroyed then
				timer.destroy
			end
			create timer
			timer.actions.extend (agent on_timer_for_close)
			timer.set_interval (timer_interval)
		end

feature {NONE} -- Implementation

	load_rgba_dib: WEL_BITMAP is
			-- Load a image which is locate at `a_filename' to RGBA DIB.
		local
			l_imp: EV_PIXMAP_IMP
		do
			l_imp ?= pixmap.implementation
			check not_void: l_imp /= Void end
			create Result.make_by_bitmap (l_imp.get_bitmap)
		ensure
			exists: Result /= Void and then Result.exists
		end

	update_layered_window_rgba (a_alpha: INTEGER) is
			-- Call `c_updatelayerwindow' with `file_name'.
		require
			valid: 0 <= a_alpha and a_alpha <= 255
		local
			l_window: WEL_WINDOW
			l_result: INTEGER
			-- Destination DC
			l_dc: WEL_WINDOW_DC
			l_point: WEL_POINT
			l_size: WEL_SIZE
			-- Source
			l_dc_src: WEL_MEMORY_DC
			l_point_src: WEL_POINT
			-- Misc
			l_err: WEL_ERROR
		do
			l_window := Current

			-- Prepare destination DC
			create l_dc.make (l_window)

			l_dc.get
			check l_dc /= Void end

			create l_point.make (x, y)

			-- Prepare source DC
			create l_size.make (pixmap.width, pixmap.height)

			create l_dc_src.make_by_dc (l_dc)
			l_dc_src.select_bitmap (load_rgba_dib)
			check l_dc_src.exists end

			create l_point_src.make (0, 0)

			create l_err
			l_err.reset_last_error_code
			-- Call updateLayeredWindow function
			check l_window.exists end
			check l_dc.exists end
			check l_point.exists end
			check l_size.exists end
			check l_dc_src.exists end
			check l_point_src.exists end

			c_updatelayerwindow (l_window.item, l_dc.item, l_point.item, l_size.item, l_dc_src.item, l_point_src.item, a_alpha, $l_result)

			if l_err.last_error_code /= 0 then
				l_err.display_last_error
			end

			l_dc.unselect_all
			l_dc.delete

			l_dc_src.delete
		end

	on_timer is
			-- Handle`timer' actions.
		do
			alpha := alpha + alpha_step
			if not (alpha <= 255) then
				alpha := 255
			end
			if exists then
				update_layered_window_rgba (alpha)
			else
				timer.destroy
			end
			if alpha >= 255 then
				timer.destroy
			end
		ensure
			destroy: alpha >= 255 implies timer.is_destroyed
		end

	on_timer_for_close is
			-- Handle `timer' actions for close.
		do
			alpha := alpha - alpha_step
			if not (alpha >= 0) then
				alpha := 0
			end
			if exists then
				update_layered_window_rgba (alpha)
			else
				timer.destroy
			end
			if alpha <= 0 then
				timer.destroy
				real_destroy
			end
		end

	timer: EV_TIMEOUT
			-- Timer to show gradient effect.	

	timer_interval: INTEGER is 50
			-- Interval for `timer'.

	alpha: INTEGER
			-- Current window alpha value.

	alpha_step: INTEGER is 50
			-- Used by `timer', `alpha' increase step.

	pixmap: EV_PIXMAP
			-- Pixmap to show.

feature {NONE} -- Externals

	c_updatelayerwindow (a_wnd: POINTER; a_dest_dc: POINTER; a_point: POINTER; a_size: POINTER; a_src_dc: POINTER; a_point_src: POINTER; a_alpha: INTEGER; a_result: TYPED_POINTER [INTEGER]) is
			-- Set layered window properties on Windows 2000 and later.
		require
			exist: a_wnd /= default_pointer
			exist: a_dest_dc /= default_pointer
			exist: a_point /= default_pointer
			exist: a_size /= default_pointer
			exist: a_src_dc /= default_pointer
			exist: a_point_src /= default_pointer
			valid: 0 <= a_alpha and a_alpha <= 255
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				BLENDFUNCTION blendFunction = {AC_SRC_OVER, 0, $a_alpha, AC_SRC_ALPHA};

				FARPROC update_layered_window = NULL;
				HMODULE user32_module = LoadLibrary (L"user32.dll");
				if (user32_module) {
					update_layered_window = GetProcAddress (user32_module, "UpdateLayeredWindow");
					if (update_layered_window) {
						// ULW_ALPHA = 0x00000002
						// ULW_COLORKEY = $00000001;
						*(EIF_INTEGER *) $a_result =
							(FUNCTION_CAST_TYPE(BOOL, WINAPI, (HWND, HDC, POINT *, SIZE *, HDC, POINT *, COLORREF, BLENDFUNCTION *, DWORD)) update_layered_window)
								((HWND)$a_wnd,
								 (HDC)$a_dest_dc,
								 (POINT*)$a_point,
								 (SIZE *)$a_size,
								 (HDC) $a_src_dc,
								 (POINT *) $a_point_src,
 								 0,
								 (BLENDFUNCTION *) &blendFunction,
								 (DWORD) 0x00000002);
					}else
					{
						// Handle windows 98 and windows Nt here.
					}
				}
			}
			]"
		end

end
