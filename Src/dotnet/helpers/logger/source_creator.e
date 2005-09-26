class
	SOURCE_CREATOR

inherit
	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Create source
		do
			if not source_ready then
				print ("Creating source...%N")
				create_source
				if source_ready then
					print ("Source created successfully")
				else
					print ("Source could not be created: " + {ISE_RUNTIME}.last_exception.to_string)
				end
			else
				print ("Source already exists")
			end
		end

end -- class SOURCE_CREATOR