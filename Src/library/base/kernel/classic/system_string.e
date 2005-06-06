indexing
	description: "Fake abstraction of a .NET SYSTEM_STRING in a non-.NET system"
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

end
