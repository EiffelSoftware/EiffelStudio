note
	description: "[
			Objects that manage the Eiffel profiler. You can start and
			stop the Eiffel profiler whenever you want to. It only works
			if `profile (yes)' is enabled in your project configuration file.
			Also disabling the profiler should be done at the same place
			where you enabled it otherwise you might corrupt the profiling data.
			To use this functionality effectively, make sure that the first instruction
			in your program calls `stop_profiling', and that the last executed instruction
			calls `start_profiling', otherwise no profile information will be generated.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

	date: "$Date$"
	revision: "$Revision$"

class
	PROFILING_SETTING

create
	make

feature -- Initialization

	make
			-- Compute value of `is_profiler_enabled' for all instances of
			-- Current class.
		do
			is_profiler_enabled.do_nothing
		end

feature -- Status report

	is_profiling: BOOLEAN
			-- Is profiler currently enabled?
		do
			Result := c_prof_enabled > 0
		end

feature -- Status setting

	start_profiling
			-- Start profiling.
		do
			if is_profiler_enabled then
				set_prof_enabled
			end
		end

	stop_profiling
			-- Stop profiling
		do
			if is_profiler_enabled then
				set_prof_disabled
			end
		end

feature -- Validity

	is_profiler_enabled: BOOLEAN
			-- Is profiler enabled upon launch time?
		once
			Result := is_profiling
		end

feature {NONE} -- Implementation

	c_prof_enabled: INTEGER
			-- C variables which gives the status on the profiler.
		do
			check
				not_implemented: False
			end
		end

	set_prof_enabled
			-- Enable profiler.
		do
			check
				not_implemented: False
			end
		end

	set_prof_disabled
			-- Disable profiler.
		do
			check
				not_implemented: False
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
