indexing
	description: "[
			Objects that manage the Eiffel profiler. You can start and
			stop the Eiffel profiler whenever you want to. It only works
			if `profile (yes)' is enabled in your Ace file.
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
		do
			check
				not_implemented: False
			end
		end

	set_prof_enabled is
			-- Enable profiler.
		do
			check
				not_implemented: False
			end
		end

	set_prof_disabled is
			-- Disable profiler.
		do
			check
				not_implemented: False
			end
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class PROFILING_SETTING



