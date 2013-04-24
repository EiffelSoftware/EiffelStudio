note
	description: "[
		Actual test implementation for {THREAD_TEST_RUNTIME}.test_002_nested_thread_exit_failure
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NESTED_THREAD

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make,
	make_typed

feature

	make
		do
			thread_make
			i := 0
			launch
			join_all;
			(create {EXECUTION_ENVIRONMENT}).sleep (5_000_000_000)
			print ("Hello from the GC%N")

			--| Commented or else testing tool is not able to report results.
			--
			-- exit_application (0)
		end

	exit_application (code: INTEGER)
		external
			"C use %"eif_eiffel.h%""
		alias
			"exit"
		end

	make_typed (v: like i)
		do
			thread_make
			i := v
		end

	i: INTEGER

	execute
		local
			t: NESTED_THREAD
		do
			inspect
				i
			when 0 then
				create t.make_typed (i + 1)
				t.launch
--				t.join
			else
				if i < 50 then
					create t.make_typed (i + 1)
					t.launch
--					t.join
					if i = 49 then
						(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
						exit
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
