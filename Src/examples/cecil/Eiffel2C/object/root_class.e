note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make
			-- Give o1 to C and try to forget it from Eiffel side.
		local
			l_mem: MEMORY
			o1, o2: OBJECT
		do
			create l_mem
			l_mem.allocate_tiny
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
			l_mem.full_collect
			io.put_string ("Display new o1:%N")
			o1.display
			io.put_string ("Display o1 given to C:%N")
			o1 := {OBJECT} / reference_from_c
			if attached o1 then
				o1.display
			end
			io.put_string ("Losing reference from C%N")
			forget_from_c
			io.put_string ("Losing reference from Eiffel%N")
			o1 := o2
			io.put_string ("Collecting...%N")
			l_mem.full_collect
			io.put_string ("Old o1 forgot from both C and Eiffel:%N")
			o1 := {OBJECT} / reference_from_c
			if attached o1 then
				io.put_string ("o1 is still reachable:%N")
				o1.display
			else
				io.put_string ("o1 is not reachable anymore.%N")
			end
		end

feature	-- Externals

	give_to_c_by_pointer (p: POINTER)
			-- Reference Eiffel object pointed by `p' from C.
		external
			"C | %"fext.h%""
		end

	give_to_c (o: ANY)
			-- Reference `o' from C.
		external
			"C | %"fext.h%""
		end

	forget_from_c
			-- Release reference to `o' from C.
		external
			"C | %"fext.h%""
		end

	reference_from_c: ANY
			-- Return the Eiffel object given to C.
		external
			"C | %"fext.h%""
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end





