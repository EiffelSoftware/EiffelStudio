note

	description:

		"ECF dotnet conditions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_DOTNET_CONDITION

inherit

	ET_ECF_CONDITION

create

	make

feature {NONE} -- Initialization

	make (a_value: BOOLEAN)
			-- Create a new condition where dotnet should be equal to `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: BOOLEAN
			-- Dotnet value

feature -- Status report

	is_enabled (a_state: ET_ECF_STATE): BOOLEAN
			-- Does `a_state' fulfill current condition?
		do
			Result := value = a_state.is_dotnet
		end

end
