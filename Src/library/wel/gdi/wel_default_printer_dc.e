indexing
	description: "Device context to use the default printer which is %
		%connected."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEFAULT_PRINTER_DC

inherit
	WEL_PRINTER_DC

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make a dc associated to the default printer.
			-- If there is no default printer connected, `exists'
			-- is equal to False.
		local
			loc_driver, loc_device, loc_output: WEL_STRING
		do
			retrieve_default_printer
			create loc_device.make (device)
			create loc_driver.make (driver)
			create loc_output.make (output)
			item := cwin_create_dc (loc_driver.item, loc_device.item,
				loc_output.item, default_pointer)
		end

feature -- Basic operations

	retrieve_default_printer is
			-- Retrieve the default printer installed and set
			-- `device', `driver', `output'.
		local
			windows: WEL_STRING
			a_device: WEL_STRING
			a_printer: WEL_STRING
			options: WEL_STRING
			printer: STRING
			device_count: INTEGER
			nb: INTEGER
		do
			create windows.make (Windows_const)
			create a_device.make (Device_const)
			create options.make (Options_const)
			create printer.make (Max_printer_name)
			printer.fill_blank
			create a_printer.make (printer)
			nb := cwin_get_profile_string (windows.item,
				a_device.item, options.item, a_printer.item,
				Max_printer_name)
			printer := a_printer.string
			printer.head (nb)
			if printer.is_equal (Options_const) then
				-- There is no default printer connected.
				-- Let's create empty strings.
				create device.make (0)
				create driver.make (0)
				create output.make (0)
			else
				-- There is a default printer connected.
				-- Let's parse the string and find the device,
				-- driver and output fields.
				device := printer.substring (1,
					printer.index_of (Comma_const, 1) - 1)
				device_count := device.count
				driver := printer.substring (device_count + 2,
					printer.index_of (Comma_const, device_count + 2) - 1)
				output := printer.substring (device_count + driver.count + 3,
					printer.count)
			end
		end

feature -- Access

	device: STRING
			-- Default printer device installed

	driver: STRING
			-- Default printer driver installed

	output: STRING
			-- Device name for the physical output medium

feature {NONE} -- Implementation

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

invariant
	device_not_void: device /= Void
	driver_not_void: driver /= Void
	output_not_void: output /= Void

end -- class WEL_DEFAULT_PRINTER_DC


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

