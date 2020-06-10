note
	description: "Helper for paramenter Names"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARAMETER_NAME_HELPER

feature -- String

	string_parameter (a_value: READABLE_STRING_GENERAL; a_length: INTEGER): STRING_32
			-- Adjust a parameter `a_value' to the lenght `a_length'.
		require
			valid_length: a_length > 0
		do
			if a_value.count <= a_length then
				Result := a_value
			else
				create Result.make_from_string (a_value.substring (1, a_length))
			end
		end

end
