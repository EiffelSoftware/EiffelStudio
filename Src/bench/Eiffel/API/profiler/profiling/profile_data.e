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

feature -- Creation feature

	make(num_call : INTEGER; feature_percentage, feature_total, feature_descendants: REAL) is
			-- Create profile data for a single function
		do
			calls := num_call
			total := feature_total
			descendants := feature_descendants
			percentage := feature_percentage
			self := ((total - descendants) * 100.0).rounded / 100.0
		end;

feature -- Output

	out : STRING is
			-- Representation for output.
		do
			!! Result.make (0);
			Result.append_string ("|%T")
			Result.append_string (calls.out)
			Result.append_string ("%T|%T")
			Result.append_string (self.out)
			Result.append_string ("%T|%T")
			Result.append_string (descendants.out)
			Result.append_string ("%T|%T")
			Result.append_string (percentage.out)
			Result.append_string ("%T|%T")
			Result.append_string (int_function.name)
		end

feature -- Compare

	is_equal (other: like Current): BOOLEAN is
			-- is `Current' equal to `other'?
		do
			Result := calls = other.calls and then
					self = other.self and then
					descendants = other.descendants and then
					percentage = other.percentage and then
					int_function.is_equal (other.int_function)
		end

feature -- copy features

	copy (other: like Current) is
			-- Reinitialize by copying the attributes of `other'.
			-- (This is also used by `clone'.)
		deferred
		end

feature -- Status report

	function: LANGUAGE_FUNCTION is
			-- The function where all is about.
		deferred
		end

feature -- attributes

	calls: INTEGER
		-- Number of calls made to the function

	total,
		-- Total amount of seconds spent in the function.

	self,
		-- Total amount of seconds spent in the function itself.

	descendants,
		-- Total amount of seconds spent in the descendants of the function.

	percentage: REAL
		-- Percentage of time spent in the function and the descendants.

	int_function: LANGUAGE_FUNCTION
		-- The function where all is about.

feature {PROFILE_SET} -- Spit Information (for debugging)

	spit_info is
		-- Spits all kinds of information about Current.
		do
			io.error.putstring (out);
			io.error.new_line
		end

end -- class PROFILE_DATA
