indexing
	description:
		"Test log output formats"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class LOG_OUTPUT_FORMAT inherit

	CHECK_UTILITY

	TEST_LOGGER
	
feature -- Status report

	is_device_set: BOOLEAN is
			-- Is device set?
		do
			Result := output_device /= Void
		end

	is_log_writable: BOOLEAN is
			-- Is log ready for writing?
		do
			Result := is_device_set
		end
feature -- Status setting

	set_facility (f: LOG_FACILITY) is
			-- Set facility to `f'.
		require
			facility_exists: f /= Void
			device_exists: f.is_device_set
		do
			log := f
		ensure
			facility_set: log = f
			device_set: is_device_set
		end

feature -- Output

	put_string (s: STRING) is
			-- Output `s'.
			-- Map '%N' to `put_new_line'.
		local
			str: STRING
			strout: STRING
			pos: INTEGER
		do
			str := clone (s)
			from until str.is_empty loop
				pos := str.index_of ('%N', 1)
				if pos > 0 then
					strout := str.substring (1, pos - 1)
					str.tail (str.count - pos)
				else
					strout := clone (str)
					str.clear_all
				end
				standard_put_string (strout)
				if pos > 0 then put_new_line end
			end
		end

	put_test_id (t: TESTABLE) is
			-- Output test identification for `t'.
		require
			writable: is_log_writable
			test_exists: t /= Void
		deferred
		end

	put_header (header: STRING) is
			-- Output `header' with underlining.
		require
			non_empty_header: header /= Void and then not header.is_empty
			writable: is_log_writable
		deferred
		end

	put_box (s: STRING; c: CHARACTER) is
			-- Output `s' surrounded by a box out of `c'.
		require
			non_empty_string: s /= Void and then not s.is_empty
			writable: is_log_writable
		deferred
		end

feature {NONE} -- Implementation

	log: LOG_FACILITY
			-- Callback reference to log facility
			
	output_device: IO_MEDIUM is
			-- Device for log output
		do
			Result := log.output_device
		end

	standard_put_string (s: STRING) is
			-- Output `s'.
		require
			non_empty_string: s /= Void and then not s.is_empty
		deferred
		end
	
end -- class LOG_OUTPUT_FORMAT

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
