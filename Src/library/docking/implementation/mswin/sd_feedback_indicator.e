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
			on_timer as on_timer_wel_dialog
		export
			{NONE} all
			{ANY} destroy
		end
create
	make

feature {NONE} -- Initlization

	make (a_file_name: STRING; a_parent_window: EV_WINDOW) is
			-- Creation method.
		require
			not_void: a_file_name /= Void
		local
			l_imp: WEL_WINDOW
			l_composite_window: WEL_COMPOSITE_WINDOW
		do
			l_composite_window ?= a_parent_window.implementation
			check not_void: l_composite_window /= Void end
			make_dlg (l_composite_window)

			l_imp := Current
			l_imp.set_ex_style ({WEL_WS_CONSTANTS}.ws_ex_layered)
			file_name := a_file_name

			create timer
			timer.actions.extend (agent on_timer)
			alpha := alpha_step
			timer.set_interval (timer_interval)

			resize (300, 300)
		ensure
			set: file_name = a_file_name
		end

feature -- Command

	set_pixmap_file (a_filename: STRING) is
			-- Set `file_name'.
		do
			file_name := a_filename
			update_layered_window_rgba (alpha)
		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position
		do
			set_x (a_screen_x)
			set_y (a_screen_y)
			show
		end

feature {NONE} -- Implementation

	file_name: STRING
			-- Pixmap file name.

	load_rgba_dib (a_filaname: STRING; a_width, a_height: INTEGER): POINTER is
			-- Load a image which is locate at `a_filename' to RGBA DIB.
		local
			l_c_string: WEL_STRING
		do
			create l_c_string.make (a_filaname)
			c_load_pixmap (l_c_string.item, $a_width, $a_height, $Result)
		ensure
			exists: Result /= Result.default_pointer
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
			l_pixmap: EV_PIXMAP
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
			create l_pixmap
			l_pixmap.set_with_named_file (file_name)
			create l_size.make (l_pixmap.width, l_pixmap.height)

			create l_dc_src.make_by_dc (l_dc)
			l_dc_src.select_object (load_rgba_dib (file_name, l_pixmap.width, l_pixmap.height))
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

	timer: EV_TIMEOUT
			-- Timer to show gradient effect.		

	timer_interval: INTEGER is 100
			-- Interval for `timer'.

	alpha: INTEGER
			-- Current window alpha value.

	alpha_step: INTEGER is 50
			-- Used by `timer', `alpha' increase step.

feature {NONE} -- Externals

	c_load_pixmap (a_filename: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]; a_result: POINTER) is
			-- This functions will allow loading paintlib (www.painlib.de) supported images
			-- into a windows 32-bit RGBA DIB section.
		require
			exist: a_filename /= default_pointer
		external
			"C++ inline use %"imgdecoder.h%""
		alias
			"[
			{
				LPVOID pDecoder;
				LPVOID pImg;
				LPBYTE pBits;
				HBITMAP bitmap;

				ImgNewDecoder (&pDecoder);
				if (!ImgNewDIBFromFile (pDecoder, (LPCTSTR)$a_filename, &pImg)){

					ImgGetHandle (pImg, &bitmap, (LPVOID *)&pBits);

					*(EIF_POINTER*) $a_result = bitmap;

					// PreMultiplyRGBChannels as Windows required
					int l_width, l_height;

					EIF_INTEGER* l_temp;
					l_temp = $a_width;
					l_width = *l_temp;

					l_temp = $a_height;
					l_height = *l_temp;

					for (int y=0; y<l_height; ++y)
					{
						BYTE *pPixel= pBits + l_width * 4 * y;

						for (int x=0; x<l_width ; ++x)
						{
							pPixel[0]= pPixel[0]*pPixel[3]/255;
							pPixel[1]= pPixel[1]*pPixel[3]/255;
							pPixel[2]= pPixel[2]*pPixel[3]/255;

							pPixel+= 4;
						}
					}
				}else
				{
					// Error occured.
				}
			}
			]"
		ensure
			exist: a_result /= default_pointer
		end

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
				HMODULE user32_module = LoadLibrary ("user32.dll");
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
