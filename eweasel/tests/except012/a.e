class
	A

feature

	f is
		local
			retried: BOOLEAN
		do
			if not retried then
				my_exception.raise
			end
		rescue
			if last_exception = my_exception then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
		end

	my_exception: MY_EXCEPTION is
		once
			create Result
		end

end
