indexing
	description: "Error if there are assemblies on another platform than dotnet."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_DOTNET

inherit
	CONF_ERROR

feature -- Access

	text: STRING is "Assemblies on another platform than dotnet."

end
