note


deferred class
	XU_SHARED_OUTPUTTER

feature -- Singleton

	o: XU_OUTPUTTER
			-- Shared access to an uuid_generator.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature -- Element Change

	set_outputter_name (a_name: STRING)
			-- Setter (Has to be done in every thread!)
		do
			o.set_name (a_name)
		ensure
			o.name = a_name
		end
end
