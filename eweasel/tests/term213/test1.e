class
	TEST1 [G->ANY create default_create end, H->TUPLE]

feature

	apply (a_agent: PROCEDURE [ANY, TUPLE[G]]; a_arguments : H)
		local
			l_array : ARRAY [detachable separate ANY]
		do
			create l_array.make_filled (Void,1,a_arguments.count)
			across a_arguments as ic_arguments loop
				l_array[ic_arguments.cursor_index] := ic_arguments.item
			end
		end
end
