indexing
	description: "Representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

convert
	to_cil: {SYSTEM_TYPE}

feature -- Conversion

	to_cil: SYSTEM_TYPE is
			-- Extract associated .NET type from Current
		do
			Result := {ISE_RUNTIME}.interface_type (
				{ISE_RUNTIME}.type_of_generic (Current, 1).dotnet_type)
		end

end
