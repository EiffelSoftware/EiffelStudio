indexing

	description:
		"Abstract notion of a class containing profile information.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROFILE_DATA

inherit
	ANY
		undefine
			copy
		redefine
			out, is_equal
		end;

	STORABLE
		undefine
			copy, is_equal, out
		end

feature -- Creation feature

	make(num_call : INTEGER; time, self_s, descen: REAL) is
			-- Create profile data for a single function
		do
			calls := num_call;
			self := self_s;
			descendent := descen;
			per_cent_time := time;
		end;

feature -- Output

	out : STRING is
			-- Representation for output.
		do
			!! Result.make (0);
			Result.append_string ("|%T");
			Result.append_string (number_of_calls.out);
			Result.append_string ("%T|%T");
			Result.append_string (self.out);
			Result.append_string ("%T|%T");
			Result.append_string (descendent.out);
			Result.append_string ("%T|%T");
			Result.append_string (per_cent_time.out);
			Result.append_string ("%T|%T");
			Result.append_string (int_function.name);
		end;

feature -- Compare

	is_equal (other: like Current): BOOLEAN is
			-- is `Current' equal to `other'?
		do
			Result := number_of_calls = other.number_of_calls and then
					self = other.self and then
					descendent = other.descendent and then
					per_cent_time = other.per_cent_time and then
					int_function.is_equal (other.int_function);
		end;

feature -- copy features

	copy (other: like Current) is
			-- Reinitialize by copying the attributes of `other'.
			-- (This is also used by `clone'.)
		deferred
		end;

feature -- Status report

	number_of_calls: INTEGER is
			-- Number of calls to the function.
		do
			Result := calls;
		end;

	function: FUNCTION is
			-- The function where all is about.
		deferred
		end;

	self_sec: REAL is
			-- Time spent in the function itself.
		do
			Result := self;
		end;

	descendents_sec: REAL is
			-- Time spent in the descendents of the function.
		do
			Result := descendent;
		end;

	total_sec: REAL is
			-- Time spent in both the function itself and
			-- its descendents.
		do
			Result := self + descendent;
		end;

	percentage: REAL is
			-- Percentage of time the function executed during
			-- the run.
		do
			Result := per_cent_time;
		end;

feature {PROFILE_DATA} -- attributes

	calls: INTEGER
		-- Number of calls made to the function

	self,
		-- Total amount of seconds spent in the function itself.

	descendent,
		-- Total amount of seconds spent in the descendents of the function.

	per_cent_time: REAL
		-- Percentage of time spent in the function and the descendants.

	int_function: FUNCTION
		-- The function where all is about.

feature {PROFILE_SET} -- Spit Information (for debugging)

    spit_info is
            -- Spits all kinds of information about Current.
        do
			io.error.putstring (out);
			io.error.new_line
        end

end -- class PROFILE_DATA
