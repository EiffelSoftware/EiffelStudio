class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests compilation and extraction of embedded resources
		local
			l_string: SYSTEM_STRING
			retried: BOOLEAN
		do
			if not retried then
				l_string ?= resource_manger.get_object ("hello_world", {CULTURE_INFO}.current_culture)

				if l_string /= Void then
					print (l_string)
				else
					print ("Void")
				end
				print ("%N")
			else
				print ({ISE_RUNTIME}.last_exception.message)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	resource_manger: RESOURCE_MANAGER is
			-- Resource manager for shared image glyphs
		once
			create Result.make ("resources", ({TEST}).to_cil.assembly)
		ensure
			result_attached: Result /= Void
		end

end
