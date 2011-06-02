
class TEST2 [G]
create
	default_create

feature 

	make
		do
		end

	is_service_available: BOOLEAN
		do
			print ({G})
			io.new_line
		end
	
end
