indexing
	description:
		"Log facilities logging test results into a file"

	status:	"See note at end of class"
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

end -- class FILE_LOG

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
