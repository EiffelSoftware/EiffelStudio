note
	description: "Summary description for {CP_IMPORTER_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CP_IMPORTER_TESTS

inherit

	EQA_TEST_SET

feature

	test_no_import
		local
			l_int: INTEGER
			l_any: separate ANY
			l_local_any: ANY
			l_failing_task: separate FAILING_TASK
			l_cancellable_task: CANCELABLE_TEST
		do
			l_int := 42
			assert ("different_result", l_int = no.import (l_int))

			create l_any
			assert ("different_result", l_any = no.import (l_any))

			create l_local_any
			assert ("different_result", l_local_any = no.import (l_local_any))

			create l_failing_task
			assert ("different_result", l_failing_task = no.import (l_failing_task))

			create l_cancellable_task
			assert ("different_result", l_cancellable_task = no.import (l_cancellable_task))
		end

	test_dynamic_import
		local
			l_failing_task: FAILING_TASK
			s_failing_task: separate FAILING_TASK
			l_cancellable_task: CANCELABLE_TEST
			s_cancellable_task: separate CANCELABLE_TEST

			s_fibonacci: separate SEQUENTIAL_FIBONACCI
		do
			create l_failing_task
			assert ("reference_equal", l_failing_task /= dynamic.import (l_failing_task))
			assert ("result_changed", l_failing_task ~ dynamic.import (l_failing_task))

			create s_failing_task
			assert ("reference_equal", s_failing_task /= dynamic.import (s_failing_task))
			assert ("result_changed", s_failing_task ~ dynamic.import (s_failing_task))

			create l_cancellable_task
			assert ("reference_equal", l_cancellable_task /= dynamic.import (l_cancellable_task))
			assert ("result_changed", l_cancellable_task ~ dynamic.import (l_cancellable_task))

			create s_cancellable_task
			assert ("reference_equal", s_cancellable_task /= dynamic.import (s_cancellable_task))
			assert ("result_changed", s_cancellable_task ~ dynamic.import (s_cancellable_task))

			create s_fibonacci.make (42)
			assert ("reference_equal", s_fibonacci /= dynamic.import (s_fibonacci))
			assert ("result_changed", s_fibonacci ~ dynamic.import (s_fibonacci))
		end

feature {NONE}

	dynamic: CP_DYNAMIC_TYPE_IMPORTER [CP_IMPORTABLE]
		attribute
			create Result
		end

	no: CP_NO_IMPORTER [ANY]
		attribute
			create Result
		end

end
