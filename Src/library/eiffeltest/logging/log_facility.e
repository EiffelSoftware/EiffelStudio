indexing
	description:
		"Log facilities logging test results"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LOG_FACILITY inherit

	TEST_LOGGER

	FORMAT_FACTORY

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

create
	
	-- Class intended for use as base class only; no instantiation.

feature -- Access

	supported_formats: ARRAY [STRING] is
			-- Output formats supported by log facility
		do
			Result := format_factory.available_products
		ensure
			non_void_result: Result /= Void
			non_empty_result: not Result.is_empty
		end

feature -- Status report

	is_device_set: BOOLEAN is
			-- Is output device set?
		do
			Result := output_device /= Void
		end

	is_format_set: BOOLEAN is
			-- Is output format set?
		do
			Result := output_format /= Void
		end

	is_format_supported (f: STRING): BOOLEAN is
			-- Is format `f' supported?
		require
			format_string: f /= Void and then not f.is_empty
		do
			Result := format_factory.has_product (f)
		end
		
	is_log_writable: BOOLEAN is
			-- Is log ready for writing?
		do
			Result := is_device_set and is_format_set
		end

feature -- Status setting

	set_format (f: STRING) is
			-- Set format to `f'.
		require
			device_set: is_device_set
			non_empty_format_string: f /= Void and then not f.is_empty
			format_supported: is_format_supported (f)
		do
			format_factory.select_product (f)
			output_format := format_factory.product
			output_format.set_facility (Current)
		ensure
			format_set: is_format_set
			format_device_set: output_format.is_device_set
		end

feature -- Output

	put_evaluation (d: TEST_DRIVER) is
			-- Output evaluation from driver `d'
		do
			open
			output_format.put_evaluation (d)
		end

	put_string (s: STRING) is
			-- Output `s'.
		do
			open
			output_format.put_string (s)
		end

	put_summary (t: TESTABLE) is
			-- Output result summary for `t'.
		do
			open
			output_format.put_summary (t)
		end
	
	put_container_results (t: TEST_CONTAINER) is
			-- Output statistic information about tests contained in `t'.
		do
			open
			output_format.put_container_results (t)
		end

	put_failure_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output failure information of `run' for `t'.
		do
			open
			output_format.put_failure_information (t, run)
		end

	put_timing_information (t: SINGLE_TEST; run: INTEGER) is
			-- Output timing information for `run' of test `t'.
		do
			open
			output_format.put_timing_information (t, run)
		end

	put_new_line is
			-- Output new line.
		do
			open
			output_format.put_new_line
		end
		
feature {LOG_OUTPUT_FORMAT} -- Implementation

	output_device: IO_MEDIUM
			-- Device for log output

feature {NONE} -- Implementation

	output_format: LOG_OUTPUT_FORMAT
			-- Format of log output
	
	open is
			-- Open log.
		do
		end

	close is
			-- Close log.
		do
		end

	dispose is
			-- Dispose on cleanup.
		do
			close
		end

invariant

	device_set_definition: is_device_set = (output_device /= Void)
	format_set_definiton: is_format_set = (output_format /= Void)

end -- class LOG_FACILITY

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
