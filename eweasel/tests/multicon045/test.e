class TEST

create
	make

feature {NONE} -- Creation
	
	make is 
			-- Run test.
		do
			(create {A [C]}.make (create {C}.make (1))).do_nothing;
			(create {B [C]}.make (create {C}.make (3))).do_nothing
		end

end
