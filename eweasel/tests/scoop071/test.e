note
	description: "Test if once values are correctly updated upon impersonation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	ISE_SCOOP_RUNTIME
		redefine default_create end

create
	make, make_initialized, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			other: separate TEST
		do
			once_value.put (0)

			create other
			test_direct_callback (other)
			io.put_new_line -- 2,0


			create other.make_initialized
			test_indirect_callback (other)
			io.put_new_line -- 1,2,0

			create other.make_initialized
			test_indirect_callback_no_sync (other)
			io.put_new_line --1,2,0

			create other
			test_direct_callback_no_impersonation (other)
			io.put_new_line -- 2,0

			create other.make_initialized
			test_indirect_callback_no_impersonation (other)
			io.put_new_line -- 1,2,0

			create other.make_initialized
			test_indirect_callback_no_impersonation_on_third (other)
			io.put_new_line --1,2,0
		end

	make_initialized
		do
			create separate_test
			once_value.put (1)
		end

	default_create
		do
			once_value.put (2)
		end

	ignored: POINTER

	once_value: CELL [INTEGER]
		once
			create Result.put (-1)
		end

feature -- Tests

	test_direct_callback (other: separate TEST)
			-- Test an impersonated direct callback.
		do
				-- Synchronize with other.
			ignored := other.default_pointer

				-- Invoke an impersonated query that executes a callback.
			ignored := other.perform_query (Current)
		end

	test_indirect_callback (other: separate TEST)
			-- Test an impersonated indirect callback.
		do
				-- Synchronize with other.
			ignored := other.default_pointer
				-- Let other.separate_test execute the callback.
			ignored := other.pass_on (Current, True)
		end

	test_indirect_callback_no_sync (other: separate TEST)
			-- Test an impersonated indirect callback.
		do
				-- Synchronize with other.
			ignored := other.default_pointer
				-- Let other.separate_test execute the callback.
			ignored := other.pass_on (Current, False)
		end

	test_direct_callback_no_impersonation (other: separate TEST)
			-- Test a direct callback when the supplier has disabled impersonation.
		do
			pin_processor_to_thread (other)
			ignored := other.default_pointer
			ignored := other.perform_query (Current)
		end

	test_indirect_callback_no_impersonation (other: separate TEST)
			-- Test an indirect callback when the supplier has disabled impersonation.
		do
				-- Synchronize with other.
			pin_processor_to_thread (other)
			ignored := other.default_pointer
				-- Let other.separate_test execute the callback.
			ignored := other.pass_on (Current, True)
		end

	test_indirect_callback_no_impersonation_on_third (other: separate TEST)
			-- Test an indirect callback when the "third" processor has disabled impersonation.
		do
			check attached other.separate_test as l_test then
				pin_processor_to_thread (l_test)
			end

				-- Synchronize with other.
			ignored := other.default_pointer
				-- Let other.separate_test execute the callback.
			ignored := other.pass_on (Current, True)
		end

feature -- Helper features

	sync_and_print: POINTER
			-- Print once_value and return a dummy pointer.
		do
			io.put_integer (once_value.item)
			io.put_new_line
			Result := default_pointer
		end

	separate_test: detachable separate TEST

	perform_query (arg: separate TEST): POINTER
			-- Perform a simple query on `arg'.
		do
			io.put_integer (once_value.item)
			io.put_new_line
			Result := arg.sync_and_print
		end

	pass_on (arg: separate TEST; with_sync: BOOLEAN): POINTER
			-- Execute perform_query on `separate_test' with argument `arg'.
		do
			io.put_integer (once_value.item)
			io.put_new_line
			check attached separate_test as l_test then
				separate l_test as s_test do
					if with_sync then
						ignored := s_test.default_pointer
					end
					Result := s_test.perform_query (arg)
				end
			end
		end

end
