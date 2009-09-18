note
	description: "Summary description for {SD_FEEDBACK_INDICATOR_IMP}."
	date: "$Date$"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_INDICATOR_IMP

inherit
	EV_POPUP_WINDOW_IMP
		rename
			on_timer as on_timer_wel,
			set_position as set_position_vision2,
			show as wel_show
		redefine
			default_ex_style,
			interface,
			dispose,
			class_name
		end

	SD_FEEDBACK_INDICATOR_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update,
			disconnect_from_window_manager
		redefine
			interface
		select
			set_position,
			show
		end

create
	make

feature {NONE} -- Intialization

	init_common (a_pixel_buffer: EV_PIXEL_BUFFER; a_parent_window: WEL_WINDOW)
			-- Initlize common parts
		do
			pixel_buffer := a_pixel_buffer
			wel_bitmap := rgba_dib
		end

feature {NONE}  -- Redefine

	class_name: STRING_32
			-- <Precursor>
		do
			Result := "SD_FEEDBACK_INDICATOR_IMP"
		end

	default_ex_style: INTEGER
			-- <Precursor>
		do
			Result := Precursor {EV_POPUP_WINDOW_IMP} | {WEL_WS_CONSTANTS}.Ws_ex_noactivate | {WEL_WS_CONSTANTS}.Ws_ex_layered
							 | {WEL_WS_CONSTANTS}.Ws_ex_topmost
		end

	interface: SD_FEEDBACK_INDICATOR
			-- <Precursor>

feature -- Command

	show
			-- Show
		local
			l_routine: WEL_WINDOWS_ROUTINES
		do
			create timer
			timer.set_interval (timer_interval)

			timer.actions.extend (agent on_timer)
			create l_routine
			if l_routine.is_terminal_service then
				-- We disable fading effect in remote desktop
				alpha := 255
			else
				alpha := alpha_step
			end

			wel_show
		end

	clear
			-- Disappear with fading effect
		do
			if not timer.is_destroyed then
				timer.destroy
			end
			create timer
			timer.actions.extend (agent on_timer_for_close)
			timer.set_interval (timer_interval)
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position
		do
			set_position_vision2 (a_screen_x, a_screen_y)
		end

	set_pixel_buffer (a_pixel_buffer: like pixel_buffer)
			-- Set `pixel_buffer'
		do
			if a_pixel_buffer /= pixel_buffer then
				if should_destroy_bitmap then
					wel_bitmap.delete
				end
				pixel_buffer := a_pixel_buffer
				wel_bitmap := rgba_dib
				if exists then
					update_layered_window_rgba (alpha)
				end
			end
		end

feature {NONE} -- Implementation

	rgba_dib: WEL_BITMAP
			-- Load a image which has RGBA DIB data
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_pixmap: EV_PIXMAP_IMP
			l_gdip_bitmap: WEL_GDIP_BITMAP
		do
			l_imp ?= pixel_buffer.implementation
			check not_void: l_imp /= Void end

			if l_imp.gdip_bitmap /= Void then
				l_gdip_bitmap := l_imp.gdip_bitmap
				Result := l_gdip_bitmap.new_bitmap
				should_destroy_bitmap := True
			else
				-- User not have GDI+
				-- It only works in 32 color depth
				l_pixmap ?= l_imp.pixmap.implementation
				check not_void: l_pixmap /= Void end
				create Result.make_by_bitmap (l_pixmap.get_bitmap)
				should_destroy_bitmap := False
			end

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

			create l_point.make (screen_x, screen_y)

			-- Prepare source DC
			create l_size.make (pixel_buffer.width, pixel_buffer.height)

			create l_dc_src.make_by_dc (l_dc)
			l_dc_src.select_bitmap (wel_bitmap)
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

	on_timer_for_close
			-- Handle `timer' actions for close
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
				destroy
			end
		end

	dispose
			-- <Precursor>
		do
			Precursor {EV_POPUP_WINDOW_IMP}
			if should_destroy_bitmap then
				wel_bitmap := Void
				-- `wel_bitmap' will be destroyed by garbage collector
				-- We can't call wel_bitmap.delete directly, because it'll be called by garbage collector, otherwise it will cause segmentation violation
			end
		end

	wel_bitmap: WEL_BITMAP
			-- Wel bitmap

	timer: EV_TIMEOUT
			-- Timer to show gradient effect

	timer_interval: INTEGER = 50
			-- Interval for `timer'

	alpha: INTEGER
			-- Current window alpha value

	alpha_step: INTEGER = 50
			-- Used by `timer', `alpha' increase step

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
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
