note
	description: "[
		Provides shared access to an uuid_generator.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_SHARED_UUID_GENERATOR

feature -- Access

	uuid_generator: XU_UUID_GENERATOR
			-- Shared access to an uuid_generator.
		once
			create Result.make
		ensure
			result_attached: attached Result
		end

end
