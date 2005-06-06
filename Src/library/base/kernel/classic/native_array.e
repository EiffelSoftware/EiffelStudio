indexing
	description: "Fake abstraction of a .NET NATIVE_ARRAY in a non-.NET system"
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY [G]

create {NONE}

invariant
	is_dotnet: {PLATFORM}.is_dotnet

end
