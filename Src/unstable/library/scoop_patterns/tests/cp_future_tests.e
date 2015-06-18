note
	description: "Summary description for {CP_FUTURE_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CP_FUTURE_TESTS

inherit
	EQA_TEST_SET

feature

	test_fibonacci_executor
		local
			l_computation: FIBONACCI_COMPUTATION
			l_starter: CP_FUTURE_EXECUTOR_PROXY [INTEGER, CP_NO_IMPORTER [INTEGER]]
			l_future: CP_RESULT_PROMISE [INTEGER]
		do
			create l_starter.make_global
			create l_computation.make (6)

			l_future := l_starter.put_and_get_result_promise (l_computation)

			assert ("wrong_result", l_future.item = 8)
		end

	test_fibonacci_improved
		local
			number, res: INTEGER_64
		do
--			number := 30
--			res := 832040
			number := 50
			res := 12586269025

			assert ("wrong_result", fib (number) = res)
		end

feature {NONE} -- Helpers

	fib (n: INTEGER_64): INTEGER_64
		local
			l_computation: SEQUENTIAL_FIBONACCI
			l_starter: CP_FUTURE_EXECUTOR_PROXY [INTEGER_64, CP_NO_IMPORTER [INTEGER_64]]
			l_future: CP_RESULT_PROMISE [INTEGER_64]

			first, second: INTEGER_64
		do
			if n <= 2 then
				Result := 1
			else
				create l_starter.make_global

				create l_computation.make (n-1)
				l_future := l_starter.put_and_get_result_promise (l_computation)

				second := fib (n-2)
				first := l_future.item

				Result := first + second
			end
		end

end
