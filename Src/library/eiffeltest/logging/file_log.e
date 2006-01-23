indexing
	description:
		"Log facilities logging test results into a file"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_LOG inherit

	LOG_FACILITY
		redefine
			output_device, open, close
		end

create

	make

feature {NONE} -- Initialization

	make (f: FILE) is
			-- Create file log to `f'.
		require
			file_exists: f /= Void
			writable: f.is_writable
		do
			output_device := f
		ensure
			device_set: output_device = f
		end

feature {NONE} -- Implementation

	output_device: FILE
			-- Device for log output

	open is
			-- Open device.
		do
			if not output_device.is_open_write then
				output_device.open_write
			end
		end

	close is
			-- Close device
		do
			output_device.close
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FILE_LOG

