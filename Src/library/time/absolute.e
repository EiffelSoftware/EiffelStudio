indexing
	description: "absolute temporal notion"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

deferred class
	ABSOLUTE

inherit
	COMPARABLE
		redefine
			infix "<"
		end

feature -- Access

	origin: like Current is
			-- Place of start for recording objects
		deferred
		ensure
			result_exists: Result /= Void
		end;
	
feature -- Measurement

	duration: DURATION is
			-- Length of the interval of time since `origin'
		deferred
		end;
	
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is the current object before `other'?
		do
			Result := duration < other.duration
		end;
	
feature -- Basic operations
	
	infix "-" (other: like Current): INTERVAL [like Current] is
			-- Interval between current object and `other' 
		require
			other_exists: other /= Void;
			other_smaller_than_current: other <= Current
		do
			create Result.make (other, Current)
		ensure
			result_exists: Result /= Void;
			result_set: Result.start_bound.is_equal (other) and then 
					Result.end_bound.is_equal (Current)
		end;

	relative_duration (other: like Current): DURATION is
			-- Relative duration from `Current' to `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end;

end -- class ABSOLUTE


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
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


