note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature  -- Initialization

	make
			-- Run application.
		do
			test;
			test_2;
			test_3;
			(create {TEST_1}).test;
			(create {TEST_2}).test;
			(create {TEST_3}).test;
			(create {TEST_4}).test;
			(create {TEST_5}).test;
			(create {TEST_6}).test;
			(create {TEST_7}).test;
			(create {TEST_8}).test;
		end


	test
		local
			list: LIST [INTEGER]
			found: BOOLEAN
		do
			create {ARRAYED_LIST [INTEGER]}list.make_from_array (<<2,5,6,7,8,9>>)
			across list as i until found loop
				if i = 6 then
					found := True
				end
				print (i.out)
			end

			across list as i until found loop
				if i = 6 then
					list.prune (i)
				end
			end

			list.do_all (agent (item: INTEGER) do print ("%N" + item.out) end)

			across list as i loop
				print ("%NCursor index" + (@ i.cursor_index).out)
				print (" - Value: " + i.out)
			end

		end


	test_2
		local
			l_list: LIST [STRING_32]
		do
			l_list := (create {PE_LIB}.make("",0)).split_path("System::Console.WriteLine")
			l_list := (create {PE_LIB}.make("",0)).split_path("System.IO.FileStream..ctor")
		end

	test_3
		local
			l_seh: CIL_SEH
			l_special: ARRAYED_LIST [CIL_SEH]
		do
			l_seh := {CIL_SEH}.seh_try
			create {ARRAYED_LIST [CIL_SEH]}l_special.make_from_iterable ({CIL_SEH}.instances)
			print ("Position" + l_special.area.index_of (l_seh, l_special.area.lower).out)
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
