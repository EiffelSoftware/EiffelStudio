indexing

	description:

		".NET assembly lists read from Ace file"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_LACE_DOTNET_ASSEMBLIES

inherit

	ET_DOTNET_ASSEMBLIES
		redefine
			assembly
		end

create

	make, make_empty

feature -- Access

	assembly (i: INTEGER): ET_LACE_DOTNET_ASSEMBLY is
			-- `i'-th assembly
		do
			Result := assemblies.item (i)
		end

end
