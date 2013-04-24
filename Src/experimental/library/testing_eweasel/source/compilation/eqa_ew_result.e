note
	description: "Summary description for {EQA_EW_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EW_RESULT

feature {ANY} -- Status setting

	update (a_string: READABLE_STRING_8)
			-- Update `Current' according to last line read from process output.
			--
			-- `a_string': String containing last line read from process.
		deferred
		end

end
