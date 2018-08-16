
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			check
				diff_obj_A: create {A}.make /= create {A}.make
				same_obj_b: create {B}.make /= create {B}.make
				diff_obj_c: create {C}.make /= create {C}.make
				same_obj_d: create {D}.make /= create {D}.make
			end		
		end
end
