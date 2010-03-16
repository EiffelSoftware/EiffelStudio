note
	description: "Device context to use the default printer which is %
		%connected."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEFAULT_PRINTER_DC

inherit
	WEL_PRINTER_DC

create
	make

feature {NONE} -- Initialization

	make
			-- Make a dc associated to the default printer.
			-- If there is no default printer connected, `exists'
			-- is equal to False.
		local
			loc_driver, loc_device, loc_output: WEL_STRING
		do
			create device.make_empty
			create driver.make_empty
			create output.make_empty
			retrieve_default_printer
			create loc_device.make (device)
			create loc_driver.make (driver)
			create loc_output.make (output)
			item := cwin_create_dc (loc_driver.item, loc_device.item,
				loc_output.item, default_pointer)
		end

feature -- Basic operations

	retrieve_default_printer
			-- Retrieve the default printer installed and set
			-- `device', `driver', `output'.
		local
			windows: WEL_STRING
			a_device: WEL_STRING
			a_printer: WEL_STRING
			options: WEL_STRING
			printer: STRING_32
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
			printer := a_printer.substring (1, nb)
			if printer.is_equal (Options_const) then
				-- There is no default printer connected.
				-- Nothing to be done
			else
				-- There is a default printer connected.
				-- Let's parse the string and find the device,
				-- driver and output fields.
				device := printer.substring (1, printer.index_of (Comma_const, 1) - 1)
				device_count := device.count
				driver := printer.substring (device_count + 2,
					printer.index_of (Comma_const, device_count + 2) - 1)
				output := printer.substring (device_count + driver.count + 3,
					printer.count)
			end
		end

feature -- Access

	device: STRING_32
			-- Default printer device installed

	driver: STRING_32
			-- Default printer driver installed

	output: STRING_32
			-- Device name for the physical output medium

feature {NONE} -- Implementation

	Windows_const: STRING = "windows"

	Device_const: STRING = "device"

	Comma_const: CHARACTER = ','

	Options_const: STRING = ",,,"

	Max_printer_name: INTEGER = 255

feature {NONE} -- Externals

	cwin_get_profile_string (section, entry, def, dest: POINTER;
			size: INTEGER): INTEGER
			-- SDK GetProfileString
		external
			"C [macro <wel.h>] (LPCTSTR, LPCTSTR, LPCTSTR, LPTSTR, %
				%int): DWORD"
		alias
			"GetProfileString"
		end

invariant
	device_not_void: device /= Void
	driver_not_void: driver /= Void
	output_not_void: output /= Void

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




end -- class WEL_DEFAULT_PRINTER_DC

