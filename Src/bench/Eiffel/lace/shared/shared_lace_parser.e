-- Sahred access to lace parser

class SHARED_LACE_PARSER

feature

	Parser: LACE_PARSER is
			-- Lace parser
		once
			!!Result
		end

end
