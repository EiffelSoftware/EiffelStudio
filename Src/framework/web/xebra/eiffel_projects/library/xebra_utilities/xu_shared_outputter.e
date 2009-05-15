note


deferred class
	XU_SHARED_OUTPUTTER

feature -- Singleton

	o: XU_OUTPUTTER
			-- Shared access to an uuid_generator.
		once
			create Result.make
		ensure
			result_attached: attached Result
		end

end
