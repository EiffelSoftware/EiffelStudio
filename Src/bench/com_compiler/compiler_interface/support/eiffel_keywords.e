indexing
	description: "Eiffel keywords information"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_KEYWORDS

feature -- Access

	Agent_keyword: STRING is "agent"
			-- Eiffel agent keyword

	Feature_keyword: STRING is "feature"
			-- Eiffel feature keyword

	Precursor_keyword: STRING is "precursor"
			-- Eiffel precursor keyword

	Create_keyword: STRING is "create"
			-- Eiffel create keyword

	agent_keyword_length: INTEGER is
			-- Eiffel agent keyword character count
		once
			Result := agent_keyword.count
		end

	feature_keyword_length: INTEGER is
			-- Eiffel feature keyword character count
		once
			Result := feature_keyword.count
		end

	precursor_keyword_length: INTEGER is
			-- Eiffel precursor keyword character count
		once
			Result := precursor_keyword.count
		end

	create_keyword_length: INTEGER is
			-- Eiffel create keyword character count
		once
			Result := create_keyword.count
		end

end -- class EIFFEL_KEYWORDS
