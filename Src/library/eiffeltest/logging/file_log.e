indexing
	description:
		"Log facilities logging test results into a file"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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
			output_device.open_write
		end

	close is
			-- Close device
		do
			output_device.close
		end

end -- class FILE_LOG

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
