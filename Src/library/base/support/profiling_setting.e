indexing

	description: "[
			Objects that manage the Eiffel profiler. You can start and
			stop the Eiffel profiler whenever you want to. It only works
			if `profile (yes)' is enabled in your Ace file.
		]"

	date: "$Date$"
	revision: "$Revision$"

class
	PROFILING_SETTING

create
	make

feature -- Initialization

	make is
			-- Compute value of `is_profiler_enabled' for all instances of
			-- Current class.
		local
			tmp: BOOLEAN
		do
			tmp := is_profiler_enabled
		end

feature -- Status report

	is_profiling: BOOLEAN is
			-- Is profiler currently enabled?
		do
			Result := c_prof_enabled > 0
		end

feature -- Status setting

	start_profiling is
			-- Start profiling.
		do
			if is_profiler_enabled then
				set_prof_enabled
			end
		end

	stop_profiling is
			-- Stop profiling
		do
			if is_profiler_enabled then
				set_prof_disabled
			end
		end

feature -- Validity

	is_profiler_enabled: BOOLEAN is
			-- Is profiler enabled upon launch time?
		once
			Result := is_profiling
		end
		
feature {NONE} -- Implementation

	c_prof_enabled: INTEGER is
			-- C variables which gives the status on the profiler.
		external
			"C [macro %"eif_project.h%"]"
		alias
			"egc_prof_enabled"
		end

	set_prof_enabled is
			-- Enable profiler.
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"egc_prof_enabled = 3"
		end

	set_prof_disabled is
			-- Disable profiler.
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"egc_prof_enabled = 0"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PROFILING_SETTING



