indexing
	description: "Fake abstraction of a .NET SYSTEM_STRING in a non-.NET system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_STRING

create
	make

feature {NONE} -- Initialization	

	make (an_array: NATIVE_ARRAY [CHARACTER]; a, b: INTEGER) is
		require
			is_dotnet: {PLATFORM}.is_dotnet
		do

		end

feature -- Access

	length: INTEGER is do end

feature -- Basic operations

	copy_to (a_start_index: INTEGER; an_array: NATIVE_ARRAY [CHARACTER]; a_destination_index, a_count: INTEGER) is
		do
		end

invariant
	is_dotnet: {PLATFORM}.is_dotnet

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






end
