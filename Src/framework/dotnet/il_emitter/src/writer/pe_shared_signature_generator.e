note
	description: "Summary description for {PE_SHARED_SIGNATURE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SHARED_SIGNATURE_GENERATOR


feature {NONE} -- Access

	signature_generator: PE_SIGNATURE_GENERATOR
			-- An signature_generator object.
		once
			create Result
		ensure
			instance_free: class
		end


end
