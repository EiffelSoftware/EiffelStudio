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
			-- Make a dc associated to the default printer.
		local
			loc_driver, loc_device, loc_output: ANY
		do
			retrieve_default_printer
			loc_device := device.to_c
			loc_driver := driver.to_c
			loc_output := output.to_c
			item := cwin_create_dc ($loc_driver, $loc_device,
				$loc_output, default_pointer)
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

	retrieve_default_printer is
			-- Retrieve the default printer installed and set
			-- `device', `driver', `output'.
		local
			windows: ANY
			a_device: ANY
			a_printer: ANY
			options: ANY
			printer: STRING
			device_count: INTEGER
		do
			windows := Windows_const.to_c
			a_device := Device_const.to_c
			options := Options_const.to_c
			!! printer.make (Max_printer_name)
			printer.fill_blank
			a_printer := printer.to_c
			printer.head (cwin_get_profile_string ($windows,
				$a_device, $options, $a_printer,
				Max_printer_name))
			device := printer.substring (1,
				printer.index_of (Comma_const, 1) - 1)
			device_count := device.count
			driver := printer.substring (device_count + 2,
				printer.index_of (Comma_const, device_count + 2) - 1)
			output := printer.substring (device_count + driver.count + 3,
				printer.count)
		end

feature -- Access

	device: STRING
			-- Default printer device installed

	driver: STRING
			-- Default printer driver installed

	output: STRING
			-- Device name for the physical output medium

feature {NONE} -- Implementation

	destroy_item is
		do
			cwin_delete_dc (item)
			item := default_pointer
		end

	Windows_const: STRING is "windows"

	Device_const: STRING is "device"

	Comma_const: CHARACTER is ','

	Options_const: STRING is ",,,"

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

invariant

	device_not_void: device /= Void
	driver_not_void: driver /= Void
	output_not_void: output /= Void

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
