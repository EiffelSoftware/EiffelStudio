indexing
	description: "Parent of all Java array classes that contains the %
                 %common routines to all arrays. Not to be used directly,%
                 % instead use the class with array of specific type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_ARRAY

inherit
	SHARED_JNI_ENVIRONMENT

	JAVA_SIZES

create {NONE}
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (p: POINTER) is
			-- Make an Eiffel array accessor out of a pointer to a 
			-- Java array.
		require
			valid: p /= default_pointer
		do
			jarray := p
			create jvalue.make
		end

feature -- Status report

	count: INTEGER is
			-- Number of cells in this array
		do
			Result := jni.get_array_length (jarray)
		ensure
			positive_count: Result >= 0
		end

	valid_index (index: INTEGER): BOOLEAN is
			-- Index is valid if it's between 0..count-1
		do
			Result := (index >= 0) and (index < count)
		end

feature {JAVA_ARGS} -- Access

	jarray: POINTER
			-- Pointer to internal java array.

feature {NONE} -- Implementation

	jvalue: JAVA_VALUE
			-- Internal storage for writing/reading from a java array.

invariant
	jarray_not_null: jarray /= default_pointer

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




end  --class

