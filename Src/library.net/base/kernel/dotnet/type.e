indexing
	description: "Representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

inherit
	ANY
		redefine
			is_equal
		end

create {NONE}

convert
	to_cil: {SYSTEM_TYPE}

feature -- Conversion

	to_cil: SYSTEM_TYPE is
			-- Extract associated .NET type from Current
		do
			Result := {ISE_RUNTIME}.interface_type (
				{ISE_RUNTIME}.type_of_generic (Current, 1).dotnet_type)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := {ISE_RUNTIME}.type_of_generic (Current, 1).equals ({ISE_RUNTIME}.type_of_generic (other, 1))
		end

end
