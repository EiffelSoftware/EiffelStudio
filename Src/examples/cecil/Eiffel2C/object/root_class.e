class
	ROOT_CLASS
inherit
	MEMORY
create
	make

feature -- Initialization

	o1, o2: OBJECT
			-- Dummy objects for testing
	make is 
			-- Give o1 to C and try to forget it from Eiffel side.
		do
			allocate_tiny
			create o1.make ("o1")
			create o2.make ("o2")

			io.put_string ("Creating o1%N")
			o1.display
			io.put_string ("Give it to C%N");
	--		give_to_c (o1)
			give_to_c_by_pointer ($o1)	-- Choose the way you pass it 
			io.put_string ("Losing reference to initial o1 from Eiffel%N")
			o1 := o2
			io.put_string ("Collecting...%N")
			full_collect
			io.put_string ("Display new o1:%N")
			o1.display
			io.put_string ("Display o1 given to C:%N")
			o1 ?= reference_from_c
			o1.display
			io.put_string ("Losing reference from C%N")
			forget_from_c 
			io.put_string ("Losing reference from Eiffel%N")
			o1 := o2
			io.put_string ("Collecting...%N")
			full_collect
			io.put_string ("Old o1 forgot from both C and Eiffel:%N")
			o1 ?= reference_from_c	
			io.put_string ("Raise a Void exception..%N")
			o1.display
		end

feature	-- Externals


	give_to_c_by_pointer (p: POINTER) is
			-- Reference Eiffel object pointed by `p' from C.
		external
			"C | %"fext.h%""
		end
	give_to_c (o: ANY) is
			-- Reference `o' from C.
		external
			"C | %"fext.h%""
		end
	
	forget_from_c is
			-- Release reference to `o' from C.
		external
			"C | %"fext.h%""
		end
	
	reference_from_c: ANY is
			-- Return the Eiffel object given to C.
		external
			"C | %"fext.h%""
		end

end	
			
			
				


--|----------------------------------------------------------------
--| CECIL: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

