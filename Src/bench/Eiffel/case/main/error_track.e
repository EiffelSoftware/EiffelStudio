indexing
	description: "System for tracking the errors ..."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_TRACK

inherit
	ONCES

feature -- Access

	eiffel_generation_failed : BOOLEAN
		-- Does the Eiffel Generation Failed

	eiffel_generation_message: STRING 
		-- String corresponding to the error which
		-- Occured during Eiffel Generation

	Start_eiffel_generation is
		-- Before the Eiffel Generation ...
		do
			eiffel_generation_failed := FALSE
		end

	Eiffel_generation_failed_with(s:STRING) is
		-- The Generation failed or is uncomplete
		require
			s_exists : s /= Void
		do
			eiffel_generation_failed := TRUE
			eiffel_generation_message := clone(s)			
		ensure
			message_set: eiffel_generation_message.is_equal(s)
		end

end -- class ERROR_TRACK
