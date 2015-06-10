note
	description: "Several tests for impersonation in special configurations."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	ISE_SCOOP_RUNTIME

create
	make, make_initialized, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			other: separate TEST
		do
			create other
			test_direct_callback (other)
			create other.make_initialized
			test_indirect_callback (other)
			create other.make_initialized
			test_indirect_callback_no_sync (other)

			create other
			test_direct_callback_no_impersonation (other)
			create other.make_initialized
			test_indirect_callback_no_impersonation (other)
			create other.make_initialized
			test_indirect_callback_no_impersonation_on_third (other)
		end

	make_initialized
		do
			create separate_test
		end

	ignored: POINTER

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

	separate_test: detachable separate TEST

	perform_query (arg: separate TEST): POINTER
			-- Perform a simple query on `arg'.
		do
			Result := arg.default_pointer
		end

	pass_on (arg: separate TEST; with_sync: BOOLEAN): POINTER
			-- Execute perform_query on `separate_test' with argument `arg'.
		do
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
