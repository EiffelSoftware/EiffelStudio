indexing

	description:
		"General information about a profiled run.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_INFORMATION

creation
	make

feature -- Creation

	make is
		do
			!! profile_data.make
			!! cyclic_functions.make
		end

feature -- Adding information

	add_function_to_cycle (function: LANGUAGE_FUNCTION; number: INTEGER) is
			-- Add `function' to cycle with `number'.
		require
			valid_cycle: has_cycle (number)
		do
			cyclic_functions.extend (function);
			profile_data.add_function_to_cycle (function, number)
		end

	has_cycle (number: INTEGER): BOOLEAN is
			-- Is cycle `number' already been profiled?
		do
			Result := profile_data.has_cycle (number)
		end

	set_total_execution_time (new_time: REAL) is
			-- Set total execution time to `new_time').
		require
			long_enough: new_time >= 0;
		do
			total_exec_time := new_time;
			available := true;
		end;

	insert_eiffel_profiling_data (data: EIFFEL_PROFILE_DATA) is
			-- Insert `data'
		require
			valid_data: data /= Void;
		do
			profile_data.insert_eiffel_profiling_data (data);
		end;

	insert_c_profiling_data (data: C_PROFILE_DATA) is
			-- Insert `data'
		require
			valid_data: data /= Void;
		do
			profile_data.insert_c_profiling_data (data);
		end;

	insert_cycle_profiling_data (data: CYCLE_PROFILE_DATA) is
			-- Insert `data'
		require
			valid_cycle: data /= Void;
		do
			profile_data.insert_cycle_profiling_data (data);
		end;

	stop_computation is
			-- Stops computation of the average-attributes.
		do
			profile_data.stop_computation;
		end;

feature -- Status report

	is_total_time_available: BOOLEAN is
			-- May `total_execution_time' be querried?
		do
			Result := available;
		end;

	total_execution_time: REAL is
			-- Time spent during the last run.
		require
			availble: is_total_time_available;
		do
			Result := total_exec_time;
		end;

	number_of_eiffel_features: INTEGER is
			-- Number of Eiffel features called
			-- during the last run.
		do
			Result := profile_data.number_of_eiffel_features;
		end;

	number_of_c_functions: INTEGER is
			-- Number of C functions called during the
			-- last run.
		do
			Result := profile_data.number_of_c_functions;
		end;

	number_of_cycles: INTEGER is
			-- Number of cycles detected during the last run.
		do
			Result := profile_data.number_of_cycles;
		end;

	number_of_cyclic_functions: INTEGER is
			-- Number of C functions that are part of
			-- of a cycle.
		do
			-- BAGGER
		end;

	number_of_cyclic_features: INTEGER is
			-- Number of Eiffel features that are part
			-- of a call cycle
		do
			-- MEER BAGGER
		end;

	number_of_feature_calls: INTEGER is
			-- Number of calls to Eiffel features
		do
			Result := profile_data.number_of_feature_calls;
		end;

	number_of_function_calls: INTEGER is
			-- Number of calls to C functions
		do
			Result := profile_data.number_of_function_calls;
		end;

feature -- All information

	profile_data: PROFILE_SET
		-- Set with all profile information

	set_profile_data (new_data: PROFILE_SET) is
			-- Keep `new_data' as `profile_data'.
		require
			no_ghosts: new_data /= Void;
		do
			profile_data := new_data;
		ensure
			no_wrong_assignment: profile_data = new_data;
		end;

feature {NONE} -- Attributes

	cyclic_functions: LINKED_LIST [LANGUAGE_FUNCTION]
		-- All functions that are part of a cycle.
		-- Containing Eiffel features and C functions.

	total_exec_time: REAL
		-- Time spent during execution of application in seconds.

	available: BOOLEAN
		-- Is total execution time available

feature {PROFILE_CONVERTER} -- Spit Information for debugging.

	spit_info is
			-- Spits all kinds of information about Current.
			--| For debugging purposes only.
			--| Will be called from `PROFILE_CONVERTER'.
		do
			if available then
				io.error.putstring ("Total execution time is: ");
				io.error.put_real (total_exec_time);
				io.error.new_line
			else
				io.error.putstring ("Total execution time is not available.");
				io.error.new_line
			end
			io.error.putstring ("Printing information from the `profile_data'.");
			io.error.new_line;
			profile_data.spit_info
		end;

end -- class PROFILE_INFORMATION
