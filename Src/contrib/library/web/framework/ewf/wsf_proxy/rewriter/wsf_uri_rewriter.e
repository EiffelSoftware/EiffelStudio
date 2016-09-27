note
	description: "Summary description for {WSF_URI_REWRITER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_REWRITER

feature	-- Conversion

	uri (a_request: WSF_REQUEST): STRING
			-- Rewritten request uri based on `a_request'.
		deferred
		end

end
