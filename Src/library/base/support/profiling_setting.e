indexing
	description: "Objects that manages the Eiffel profiler. You can start and stop the Eiffel%N%
			%profiler whenever you want to. It only works if `profile (yes)' is enabled in%N%
			%your Ace file."
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

end -- class PROFILING_SETTING
