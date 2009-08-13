note
	description: "Objecs that use layered windows to feedback display indicators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		redefine
			dispose
		end

	EV_ANY_HANDLER

create
	make,
	make_for_splash

feature {NONE} -- Initlization

	make (a_pixel_buffer: like pixel_buffer; a_parent_window: EV_WINDOW)
			-- Creation method
		require
			not_void: a_pixel_buffer /= Void
		local
			l_composite_window: detachable WEL_COMPOSITE_WINDOW
		do
			init_common_before (a_pixel_buffer)

			l_composite_window ?= a_parent_window.implementation
			check not_void: l_composite_window /= Void end
			make_dlg (l_composite_window)

			init_common

		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	make_for_splash (a_pixel_buffer: like pixel_buffer)
			-- Creation method for splash screen
		require
			not_void: a_pixel_buffer /= Void
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: detachable EV_APPLICATION_IMP
		do
			create l_env
			if attached l_env.application as l_app then
				l_app_imp ?= l_app.implementation
			else
				check False end -- Implied by application is running
			end

			init_common_before (a_pixel_buffer)

			check not_void: l_app_imp /= Void end
			make_dlg (l_app_imp.silly_main_window)

			init_common
		end

	init_common_before (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Initlize common parts before `default_create'
		require
			not_void: a_pixel_buffer /= Void
		do
			pixel_buffer := a_pixel_buffer
			wel_bitmap := rgba_dib
		ensure
			created: wel_bitmap /= Void
		end

	init_common
			-- Initlize common parts
		do
			set_ex_style ({WEL_WS_CONSTANTS}.ws_ex_layered)
		end

feature -- Command

	show
			-- Show
		local
			l_routine: WEL_WINDOWS_ROUTINES
			l_timer: like timer
		do
			create l_timer
			timer := l_timer
			l_timer.set_interval (timer_interval)

			l_timer.actions.extend (agent on_timer)
			create l_routine
			if l_routine.is_terminal_service then
				-- We disable fading effect in remote desktop
				alpha := 255
			else
				alpha := alpha_step
			end

			wel_show
		end

	set_pixel_buffer (a_pixel_buffer: like pixel_buffer)
			-- Set `pixel_buffer'
		do
			if a_pixel_buffer /= pixel_buffer then
				if should_destroy_bitmap then
					if attached wel_bitmap as l_bitmap then
						l_bitmap.delete
					end
				end
				pixel_buffer := a_pixel_buffer
				wel_bitmap := rgba_dib
				if exists then
					update_layered_window_rgba (alpha)
				end
			end
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position
		do
			set_x (a_screen_x)
			set_y (a_screen_y)
		end

	clear
			-- Disappear with fading effect
		require
			exists: exists
			not_void: is_timer_set
		local
			l_timer: like timer
		do
			l_timer := timer
			check l_timer /= Void end -- Implied by precondition `not_void'
			if not l_timer.is_destroyed then
				l_timer.destroy
			end
			create l_timer
			timer := l_timer
			l_timer.actions.extend (agent on_timer_for_close)
			l_timer.set_interval (timer_interval)
		end

feature -- Query

	is_wel_bitmap_set: BOOLEAN
			-- If `wel_bitmap' created?
		do
			Result := attached wel_bitmap
		end

	is_timer_set: BOOLEAN
			-- If `timer' has been set?
		do
			Result := attached timer
		end

feature {NONE} -- Implementation

	rgba_dib: WEL_BITMAP
			-- Load a image which has RGBA DIB data
		local
			l_imp: detachable EV_PIXEL_BUFFER_IMP
			l_pixmap: detachable EV_PIXMAP_IMP
			l_result: detachable like rgba_dib
		do
			l_imp ?= pixel_buffer.implementation
			check not_void: l_imp /= Void end

			if attached l_imp.gdip_bitmap as l_gdip_bitmap then
				l_result := l_gdip_bitmap.new_bitmap
				should_destroy_bitmap := True
			else
				-- User not have GDI+
				-- It only works in 32 color depth
				if attached l_imp.pixmap as l_imp_pixmap then
					l_pixmap ?= l_imp_pixmap.implementation
					check not_void: l_pixmap /= Void end
					create l_result.make_by_bitmap (l_pixmap.get_bitmap)
					should_destroy_bitmap := False
				else
					check False end -- Implied by `l_imp.gdip_bitmap' not attached, then `Is_gdi_plus_installed' is False
				end
			end
			check l_result /= Void end -- Implied by previous if clause
			Result := l_result
		ensure
			exists: Result /= Void and then Result.exists
		end

	should_destroy_bitmap: BOOLEAN
			-- If we load rgba_dib from EV_PIXMAP we should not destroy WEL_BITMAP
			-- If we load rgba_dib from EV_PIXEL_BUFFER we should destroy WEL_BITMAP

	update_layered_window_rgba (a_alpha: INTEGER)
			-- Call `c_updatelayerwindow' with `a_alpha'
		require
			valid: 0 <= a_alpha and a_alpha <= 255
			set: is_wel_bitmap_set
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
			l_wel_bitmap: like wel_bitmap
		do
			l_window := Current

			-- Prepare destination DC
			create l_dc.make (l_window)

			l_dc.get
			check l_dc /= Void end

			create l_point.make (x, y)

			-- Prepare source DC
			create l_size.make (pixel_buffer.width, pixel_buffer.height)

			create l_dc_src.make_by_dc (l_dc)
			l_wel_bitmap := wel_bitmap
			check l_wel_bitmap /= Void end -- Implied by precondition `set'
			l_dc_src.select_bitmap (l_wel_bitmap)
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

			-- In MSDN, "UpdateLayeredWindow Function" page, it says
			-- if fails, the return value is 0
			if l_result = 0 then
				if l_err.last_error_code /= 0 then
					l_err.display_last_error
				end
			end

			l_dc.unselect_all
			l_dc.delete

			l_dc_src.delete
		end

	on_timer
			-- Handle`timer' actions
		require
			not_void: is_timer_set
		local
			l_timer: like timer
		do
			alpha := alpha + alpha_step
			if not (alpha <= 255) then
				alpha := 255
			end
			l_timer := timer
			check l_timer /= Void end -- Implied by precondition `not_void'
			if exists then
				update_layered_window_rgba (alpha)
			else
				l_timer.destroy
			end
			if alpha >= 255 then
				l_timer.destroy
			end
		ensure
			destroy: alpha >= 255 implies attached timer as le_timer and then le_timer.is_destroyed
		end

	on_timer_for_close
			-- Handle `timer' actions for close
		require
			not_void: is_timer_set
		local
			l_timer: like timer
		do
			alpha := alpha - alpha_step
			if not (alpha >= 0) then
				alpha := 0
			end
			l_timer := timer
			check l_timer /= Void end -- Implied by precondition `not_void'
			if exists then
				update_layered_window_rgba (alpha)
			else
				l_timer.destroy
			end
			if alpha <= 0 then
				l_timer.destroy
				real_destroy
			end
		end

	dispose
			-- <Precursor>
		do
			Precursor {SD_DIALOG}
			if should_destroy_bitmap then
				wel_bitmap := Void
				-- `wel_bitmap' will be destroyed by garbage collector
				-- We can't call wel_bitmap.delete directly, because it'll be called by garbage collector, otherwise it will cause segmentation violation
			end
		end

	wel_bitmap: detachable WEL_BITMAP
			-- Wel bitmap

	timer: detachable EV_TIMEOUT
			-- Timer to show gradient effect

	timer_interval: INTEGER = 50
			-- Interval for `timer'

	alpha: INTEGER
			-- Current window alpha value

	alpha_step: INTEGER = 50
			-- Used by `timer', `alpha' increase step

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixmap to show

feature {NONE} -- Externals

	c_updatelayerwindow (a_wnd: POINTER; a_dest_dc: POINTER; a_point: POINTER; a_size: POINTER; a_src_dc: POINTER; a_point_src: POINTER; a_alpha: INTEGER; a_result: TYPED_POINTER [INTEGER])
			-- Set layered window properties on Windows 2000 and later
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
				// This is not defined in VC6
				// define AC_SRC_ALPHA 0x01
				// define AC_SRC_OVER 0x00
				BLENDFUNCTION blendFunction = {0x00, 0, $a_alpha, 0x01};

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

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
