
class TEST2 [G -> {ANY rename default_create as hamster end, ANY} create hamster end]

feature
	is_valid: BOOLEAN
		do
			print (create {G})
		end


end
