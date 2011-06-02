
class TEST
	
create
	make

feature

	make
		do
			if (create {TEST2 [STRING]}).is_service_available then
				print ("Weasel%N")
			end
			if (create {TEST2 [TEST]}).is_service_available then
				print ("Ermine%N")
			end
		end

end
