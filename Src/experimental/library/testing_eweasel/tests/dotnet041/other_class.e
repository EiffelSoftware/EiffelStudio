deferred class
	OTHER_CLASS
	
feature -- Properties

	my_property: SYSTEM_STRING is
			-- Deferred propery
		indexing
			property: auto
		deferred
		end

end