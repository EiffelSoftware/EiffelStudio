indexing
	description: "Device context to use the default printer which is %
		%connected."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEFAULT_PRINTER_DC

inherit
	WEL_DC

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make a printer dc
		local
			loc_driver, loc_device: ANY
		do
			loc_device := device.to_c
			loc_driver := driver.to_c
			item := cwin_create_dc ($loc_driver, $loc_device,
				default_pointer, default_pointer)
		end

feature -- Basic operations

	start_document (title: STRING) is
			-- Start the job `title' on the printer
		require
			exists: exists
			title_not_void: title /= Void		
		local
			a: ANY
		do
			a := title.to_c
			cwin_escape (item, Startdoc, title.count, $a,
				default_pointer)
		end

	new_frame is
			-- Send a new frame to the printer
		require
			exists: exists
		do
			cwin_escape (item, Newframe, 0, default_pointer,
				default_pointer)
		end

	end_document is
			-- End the job on the printer
		require
			exists: exists
		do
			cwin_escape (item, Enddoc, 0, default_pointer,
				default_pointer)
		end

feature -- Status report

	device: STRING is 
			-- Default printer device installed
		local
			a, c: ANY
			pointer_result: POINTER
		once
			!! Result.make (0)
			a := printer.to_c
			c := Comma_const.to_c
			pointer_result := c_strtok ($a, $c)
			check
				pointer_result_not_null:
					pointer_result /= default_pointer
			end
			Result.from_c (pointer_result)
		ensure
			result_not_void: Result /= Void
		end

	driver: STRING is
			-- Default printer driver installed
		local
			c: ANY
			pointer_result: POINTER
		once
			!! Result.make (0)
			c := Comma_const2.to_c
			pointer_result := c_strtok (default_pointer, $c)
			check
				pointer_result_not_null:
					pointer_result /= default_pointer
			end
			Result.from_c (pointer_result)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	printer: STRING is
			-- Default printer installed
		local
			windows: ANY
			a_device: ANY
			a_printer: ANY
			options: ANY
		do
			windows := Windows_const.to_c
			a_device := Device_const.to_c
			options := Options_const.to_c
			!! Result.make (Max_printer_name)
			Result.fill_blank
			a_printer := Result.to_c
			Result.head (cwin_get_profile_string ($windows,
				$a_device, $options, $a_printer,
				Max_printer_name))
		ensure
			result_not_void: Result /= Void
		end

	destroy_item is
		do
			cwin_delete_dc (item)
			item := default_pointer
		end

	Windows_const: STRING is "windows"

	Device_const: STRING is "device"

	Options_const: STRING is ",,,"

	Comma_const: STRING is ","

	Comma_const2: STRING is ", "

	Max_printer_name: INTEGER is 255

feature {NONE} -- Externals

	cwin_get_profile_string (section, entry, def, dest: POINTER;
			size: INTEGER): INTEGER is
			-- SDK GetProfileString
		external
			"C [macro <wel.h>] (LPCSTR, LPCSTR, LPCSTR, LPSTR, %
				%int): DWORD"
		alias
			"GetProfileString"
		end

	cwin_escape (dc: POINTER; escape_code, size: INTEGER; 
			input_struct, output_struct: POINTER) is
			-- SDK Escape
		external
			"C [macro <wel.h>] (HDC, int, int, LPCSTR, %
				%void *)"
		alias
			"Escape"
		end

	c_strtok (arg1, arg2: POINTER): POINTER is
			-- strtok C function
		external
			"C [macro <string.h>] (char *, char *): char *"
		alias
			"strtok"
		end	

	Startdoc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"STARTDOC"
		end

	Enddoc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ENDDOC"
		end

	Newframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"NEWFRAME"
		end

end -- class WEL_DEFAULT_PRINTER_DC

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
