
class TEST 
create
	default_create, make

feature

	make
		local
			t: TEST
		do
			create{TEST}t
		end

end
