note
	description: "[
		Unit tests performing tests on the thread runtime.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_TEST_RUNTIME

inherit
	THREAD_TEST_SET

	MEMORY
		undefine
			default_create
		end

	THREAD
		undefine
			default_create
		end

feature {NONE} -- Query

	current_usage (a_type: INTEGER): NATURAL_64
			-- Current memory usage for given type
			--
			-- `a_type': Type of memory (eiffel, c or total)
		require
			prepared: is_prepared
			a_type_valid: a_type = {MEM_CONST}.total_memory or
			              a_type = {MEM_CONST}.eiffel_memory or
			              a_type = {MEM_CONST}.c_memory
		do
			full_collect
			Result := memory_statistics (a_type).total64
		end

feature -- Test routines

	test_002_nested_thread_exit_failure
			-- A system creating a few threads crashes when threads exit, it does not crash if the parent
			-- thread always wait for the child thread to terminate (see commented line about `join' in
			-- {NESTED_THREAD}).
			--
			-- Note: copy of eweasel test thread003
		note
			testing: "covers/{THREAD}.exit"
		local
			l_test: NESTED_THREAD
		do
			create l_test.make
			create l_test.make
			create l_test.make
		end

	test_003_memory_leak_in_eif_thr_wait
			-- Show memory leak in `eif_thr_wait' calling RT_GC_PROTECT(thread_object) without an RT_GC_WEAN
			-- if `eif_children_mutex' is NULL.
			--
			-- Note: copy of eweasel test thread003
		note
			testing: "covers/{THREAD_CONTROL}.join"
		local
			l_thread_count, i: NATURAL
			l_info: MEM_INFO
			l_m1, l_m2, l_mdiff: INTEGER
		do
			l_thread_count := 300_000

			l_info := memory_statistics ({MEM_CONST}.total_memory)
			l_info.update ({MEM_CONST}.total_memory)
			l_m1 := l_info.used

			from
				i := 1
			until
				i > l_thread_count
			loop
				join
				l_info.update ({MEM_CONST}.total_memory)
				l_m2 := l_info.used
				l_mdiff := l_m2 - l_m1
				if l_mdiff >= 100_000 then
					print ("Memory leak - used memory increased by " + l_mdiff.out + " bytes after " + i.out + " iterations%N")
					assert ("memory_leak", False)
				end
				i := i + 1
			end
		end

	test_004_creating_string_runtime_panic
			-- Show crashes in the runtime when creating strings.
			--
			-- Note: copy of eweasel test thread004
		note
			testing: "covers/{THREAD}"
		local
			l_thread_count, l_string_count, i: NATURAL
			l_thread: STRING_CREATOR_THREAD
		do
			l_thread_count := 10
			l_string_count := 1_000_000

			from
				i := 1
			until
				i > l_thread_count
			loop
				create l_thread.make (l_string_count)
				l_thread.launch
				i := i + 1
			end
			join_all
		end

	test_005_mem_info_update_crash_after_threads
			-- Show crashes revealed calling {MEM_INFO}.update or `full_collect' after launching empty threads.
			--
			-- Note: copy of eweasel test thread005
		note
			testing: "covers/{MEM_INFO}.update"
		local
			l_thread_count, i: NATURAL
			l_thread: EMPTY_THREAD
			l_info: MEM_INFO
		do
			l_thread_count := 1_000

			create l_info.make ({MEM_CONST}.total_memory)
			from
				i := 1
			until
				i > l_thread_count
			loop
				create l_thread.make
				l_thread.launch
				join_all
				full_collect
				l_info.update ({MEM_CONST}.total_memory)
				i := i + 1
			end
		end

	test_006_panic_when_too_many_allocation
			-- A class creates several threads. Each thread repeatedly creates a string whose length is
			-- determined by a random number generator. System execution ends with an exception, but should
			-- not.
			--
			-- Note: copy of eweasel test thread006
		note
			testing: "covers/{THREAD}"
		local
			l_thread_count, i: NATURAL
			l_thread: RANDOM_THREAD
		do
			l_thread_count := 10

			from
				i := 1
			until
				i > l_thread_count
			loop
				create l_thread.make
				l_thread.launch
				i := i + 1
			end
			join_all
		end

	test_eiffel_memory
			-- Test eiffel memory usage after launching multiple threads
		note
			testing: "covers/{THREAD}"
		require
			prepared: is_prepared
		local
			l_wt: WORKER_THREAD
			l_m1, l_m2: NATURAL_64
		do
			l_m1 := current_usage ({MEM_CONST}.eiffel_memory)
			create l_wt.make (agent do_nothing)
			launch_threads (l_wt, thread_count)
			l_m2 := current_usage ({MEM_CONST}.eiffel_memory)

			assert (l_m1.out + " => " + l_m2.out, l_m2 <= l_m1 + 100_000)
		end

	test_c_memory
			-- Test C memory usage after launching multiple threads
		note
			testing: "covers/{THREAD}"
		require
			prepared: is_prepared
		local
			l_wt: WORKER_THREAD
			l_m1, l_m2: NATURAL_64
		do
			l_m1 := current_usage ({MEM_CONST}.c_memory)
			create l_wt.make (agent do_nothing)
			launch_threads (l_wt, thread_count)
			l_m2 := current_usage ({MEM_CONST}.c_memory)

			assert (l_m1.out + " => " + l_m2.out, l_m2 <= l_m1 + 100_000)
		end

feature {NONE} -- Implementation

	launch_threads (a_thread: THREAD; a_count: NATURAL)
			-- Launch a number of threads and wait for them to terminate
		require
			a_thread_attached: a_thread /= Void
		local
			i: NATURAL
		do
			from
				i := 1
			until
				i > a_count
			loop
				a_thread.launch
				i := i + 1
			end
			a_thread.join_all
		end

feature {NONE} -- Constants

	thread_count: NATURAL = 10
			-- Number of threads `launch_threads' will launch

feature {NONE} -- Implementation of test_002

	test_002
		do

		end

	make
		do
			counter := 0

		end

	exit_application (code: INTEGER)
		external
			"C use %"eif_eiffel.h%""
		alias
			"exit"
		end

	make_typed (v: like counter)
		do

		end

	counter: INTEGER

	execute
		do

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
