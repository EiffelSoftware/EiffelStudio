note
	description: "Summary description for {WSF_AGENT_URI_REWRITER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_AGENT_URI_REWRITER

inherit
	WSF_URI_REWRITER

create
	make

--convert
--	make ({FUNCTION [TUPLE [WSF_REQUEST], STRING]})

feature {NONE} -- Initialization

	make (a_rewriter_function: like rewriter_function)
		do
			rewriter_function := a_rewriter_function
		end

feature -- Access

	rewriter_function: FUNCTION [TUPLE [WSF_REQUEST], STRING]

feature	-- Conversion

	uri (a_request: WSF_REQUEST): STRING
			-- <Precursor>.
		do
			Result := rewriter_function (a_request)
		end

end
