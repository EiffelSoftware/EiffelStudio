note
	description: "Simple validators."
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_VALIDATOR

feature {NONE} -- Agents

	is_not_void (a_data: ANY): BOOLEAN
			-- Is `a_data' not Void?
		do
			Result := a_data /= Void
		end

	is_not_void_or_empty (a_text: FINITE [ANY]): BOOLEAN
			-- Is `a_text' not void or empty?
		do
			Result := a_text /= Void and then not a_text.is_empty
		end

end
