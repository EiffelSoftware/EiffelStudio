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
			check
				False -- Not implemented yet for non manifest type yet.
			end
		end

end
