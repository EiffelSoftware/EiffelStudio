indexing
	description: "[
		Objects that provide access to a set of shared objects that may be used on a temporary
		basis to increase performance. These objects should only be used in the case where an
		object is required as an intermediary step for passing to a routine, with no further reference
		being kept to the object. By retrieving one of the objects from his class and using it temporarily,
		it prevents memory allocation through the creation of new objects. This can improve performace in
		systems where such access is performed many times in a short space of time.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_TEMPORARY_OBJECTS

feature -- Access

	wel_rect: WEL_RECT is
			-- Once access to an object of type WEL_RECT
		once
			create Result.make (0, 0, 0, 0)
		end
		
	wel_string: WEL_STRING is
			-- Once access to an object of type WEL_STRING
		once
			create Result.make_empty (256)
		end
		
	wel_string_restricted (characters: INTEGER): WEL_STRING is
			-- Return shared `wel_string' as `Result' if `characters'
			-- is less than `maximum_buffered_string_size', otherwise return a
			-- new WEL_STRING object. This is used to prevent huge strings
			-- from being kept within a system.
		once
			if characters < maximum_buffered_string_size then
				Result := wel_string
			else
				create Result.make_empty (characters)
			end
		end
		
	wel_string_from_string (s: STRING): WEL_STRING is
			-- Return a shared wel string set to `s' if
			-- `s.count' < `maximum_buffered_string_size', otherwise
			-- return a new WEL_STRING object set to `s'.
		do
			if s.count < maximum_buffered_string_size then
				Result := wel_string
				Result.set_string (s)
			else
				create Result.make (s)
			end
		end
		
	maximum_buffered_string_size: INTEGER is 10000;
		-- Maximum size of string permitting a shared WEL_STRING object to 
		-- be returned by `wel_string_restricted'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
