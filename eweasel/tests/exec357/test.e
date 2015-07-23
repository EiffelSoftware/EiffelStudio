class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		do
			(create {A_1_1}.make).do_nothing;
			(create {A_2_1}.make).do_nothing;
			(create {A_2_2}.make).do_nothing;
			(create {A_3_1}.make).do_nothing;
			(create {A_3_2}.make).do_nothing;
			(create {A_3_3}.make).do_nothing;
		end

end
