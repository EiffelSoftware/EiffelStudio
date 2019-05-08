note
	description: "Encapsulation of the PRINTER_INFO_2 Windows structure giving some printer details."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINTER_INFO_2

inherit
	WEL_STRUCTURE

create
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_size: INTEGER)
			-- Initialize Current with a size larger than `structure_size'
		local
			l_null_ptr: POINTER
		do
			if a_size >= structure_size then
				item := item.memory_calloc (1, a_size)
				if item = l_null_ptr then
					(create {EXCEPTIONS}).raise ("No more memory")
				end
				shared := False
			end
		end

feature -- Access

	server_name: detachable WEL_STRING
			-- String identifying the server that controls the printer.
			-- If this string is Void, the printer is controlled locally.
		require
			exists: exists
		local
			l_ptr: POINTER
		do
			l_ptr := c_server_name (item)
			if l_ptr /= default_pointer then
				create Result.make_by_pointer (l_ptr)
			end
		end

	printer_name: WEL_STRING
			-- Name of printer.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_printer_name (item))
		end

	share_name: WEL_STRING
			-- Sharepoint for the printer.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_share_name (item))
		end

	port_name: WEL_STRING
			-- Port(s) used to transmit data to the printer.
			-- If a printer is connected to more than one port,
			-- the names of each port must be separated by
			-- commas (for example, "LPT1:,LPT2:,LPT3:").
		require
			exists: exists
		do
			create Result.make_by_pointer (c_port_name (item))
		end

	driver_name: WEL_STRING
			-- Name of printer driver.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_driver_name (item))
		end

	comment: WEL_STRING
			-- Description of printer.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_comment (item))
		end

	location: WEL_STRING
			-- Physical location of the printer (for example, "Bldg. 38, Room 1164").
		require
			exists: exists
		do
			create Result.make_by_pointer (c_location (item))
		end

	sep_file: WEL_STRING
			 -- Name of the file used to create the separator page.
			 -- This page is used to separate print jobs sent to the printer.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_sep_file (item))
		end

	print_processor: WEL_STRING
			-- Name of the print processor used by the printer.
			-- You can use the `EnumPrintProcessors' function to obtain a list
			-- of print processors installed on a server.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_print_processor (item))
		end

	data_type: WEL_STRING
			-- Data type used to record the print job.
			-- You can use the `EnumPrintProcessorDatatypes' function to
			-- obtain a list of data types supported by a specific print processor.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_data_type (item))
		end

	parameters: WEL_STRING
			 -- Default print-processor parameters.
		require
			exists: exists
		do
			create Result.make_by_pointer (c_parameters (item))
		end

	attributes: INTEGER
			-- Printer attributes.
		require
			exists: exists
		do
			Result := c_attributes (item)
		end

	priority: INTEGER
			-- Priority value that the spooler uses to route print jobs.
		require
			exists: exists
		do
			Result := c_priority (item)
		end

	default_priority: INTEGER
			-- Default priority value assigned to each print job.
		require
			exists: exists
		do
			Result := c_default_priority (item)
		end

	start_time: INTEGER
 			-- Earliest time at which the printer will print a job.
			-- This value is expressed as minutes elapsed since 12:00 AM GMT (Greenwich Mean Time).
		require
			exists: exists
		do
			Result := c_start_time (item)
		end

	until_time: INTEGER
			-- Latest time at which the printer will print a job.
			-- This value is expressed as minutes elapsed since 12:00 AM GMT (Greenwich Mean Time).
		require
			exists: exists
		do
			Result := c_until_time (item)
		end

	status: INTEGER
			-- Printer status.
		require
			exists: exists
		do
			Result := c_status (item)
		end

	jobs: INTEGER
	 		-- Number of print jobs that have been queued for the printer.
		require
			exists: exists
		do
			Result := c_jobs (item)
		end

	average_ppm: INTEGER
			-- Average number of pages per minute that have been printed on the printer.
		require
			exists: exists
		do
			Result := c_average_ppm (item)
		end

feature -- Measurements

	structure_size: INTEGER
			-- <Precursor>
		do
			Result := c_structure_size
		end

feature {NONE} -- C externals

	c_structure_size: INTEGER
			-- Implementation of `c_structure_size`.
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return sizeof(PRINTER_INFO_2);"
		end

	c_server_name (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pServerName;"
		end

	c_printer_name (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pPrinterName;"
		end

	c_share_name (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pShareName;"
		end

	c_port_name (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pPortName;"
		end

	c_driver_name (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pDriverName;"
		end

	c_comment (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pComment;"
		end

	c_location (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pLocation;"
		end

	c_dev_mode (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pDevMode;"
		end

	c_sep_file (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pSepFile;"
		end

	c_print_processor (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pPrintProcessor;"
		end

	c_data_type (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pDatatype;"
		end

	c_parameters (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pParameters;"
		end

	c_security_descriptor (a_item: POINTER): POINTER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->pSecurityDescriptor;"
		end

	c_attributes (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->Attributes;"
		end

	c_priority (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->Priority;"
		end

	c_default_priority (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->DefaultPriority;"
		end

	c_start_time (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->StartTime;"
		end

	c_until_time (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->UntilTime;"
		end

	c_status (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->Status;"
		end

	c_jobs (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->cJobs;"
		end

	c_average_ppm (a_item: POINTER): INTEGER
		external
			"C inline use <windows.h>, <winspool.h>"
		alias
			"return ((PRINTER_INFO_2 *) $a_item)->AveragePPM;"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
