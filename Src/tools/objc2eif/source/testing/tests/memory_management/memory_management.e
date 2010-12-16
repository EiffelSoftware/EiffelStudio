note
	description: "Summary description for {MEMORY_MANAGEMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_MANAGEMENT

inherit
	TESTS_COMMON
		redefine
			run
		end

feature -- Running

	run
			-- <Precursor>
		local
			pool: NS_AUTORELEASE_POOL
		do
			Precursor
			create pool.make
			test_identity_property
			collect_garbage
			test_identity_property2
			collect_garbage
			test_identity_property_with_subclasses
			collect_garbage
		end

feature {NONE} -- Tests

	test_identity_property
			-- Test the identity property
		local
			array: NS_MUTABLE_ARRAY
			number: NS_NUMBER
		do
			create array.make
			create number.make_with_int_ (123)
			add_number_to_array (array, number)
			check attached {NS_NUMBER} array.object_at_index_ (0) as the_number then
					-- Identity property
				assert (the_number = number)
				assert (the_number.int_value = 123)
			end
			collect_garbage
				-- Assert all Objective-C objects released (check console when debug_on is True
				-- in NS_COMMON)
		end

	add_number_to_array (an_array: NS_MUTABLE_ARRAY; a_number: NS_NUMBER)
			-- Add `a_number' to `an_array'.
		do
			an_array.add_object_ (a_number)
		end

	test_identity_property2
			-- Test the identity property
		local
			array: NS_MUTABLE_ARRAY
		do
			create array.make
			add_number_to_array2 (array)
			collect_garbage
				-- Assert the NS_NUMBER object added to the array has been released (check console)
			check attached {NS_NUMBER} array.object_at_index_ (0) as the_number then
				assert (the_number.int_value = 445)
			end
			collect_garbage
				-- Assert all Objective-C objects released (check console when debug_on is True
				-- in NS_COMMON)
		end

	add_number_to_array2 (an_array: NS_MUTABLE_ARRAY)
			-- Add `a_number' to `an_array'.
		local
			number: NS_NUMBER
		do
			create number.make_with_int_ (445)
			an_array.add_object_ (number)
		end

	test_identity_property_with_subclasses
			-- Test the identity property with subclass instances.
		local
			array: NS_MUTABLE_ARRAY
			saved_data: STRING
		do
			create array.make
			saved_data := "Subclass instance saved data"
			add_button_to_array (array, saved_data)
			collect_garbage
				-- Even though a full collecting cycle has been executed
				-- the MY_BUTTON object created in `add_number_to_array2'
				-- will not be deallocated.
			check attached {MY_BUTTON} array.object_at_index_ (0) as the_button then
				check attached the_button.saved_data as attached_saved_data then
					assert (attached_saved_data = saved_data)
				end
			end
		end

	add_button_to_array (an_array: NS_MUTABLE_ARRAY; saved_data: STRING)
			-- Add `a_number' to `an_array'.
		local
			button: MY_BUTTON
		do
			create button.make_with_frame_ (create {NS_RECT}.make)
			button.saved_data := saved_data
			an_array.add_object_ (button)
		end


end
