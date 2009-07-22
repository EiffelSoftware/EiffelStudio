note
	description: "[
		Objects representing classes containing tests associated with the corresponding Eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_CLASS

create
	make

feature {NONE} -- Initialization

	make (a_class: like eiffel_class)
			-- Initialize `Current'.
		do
			eiffel_class := a_class
			create name.make_from_string (a_class.name)
			reset_test_map
		end

feature -- Access

	eiffel_class: EIFFEL_CLASS_I
			-- Class in system carrying tests

	name: IMMUTABLE_STRING_8
			-- Immutable name of `eiffel_class'
			--
			-- Note: `name' is immutable to asure even if the class name changes `name' remains the same.

feature {ETEST_SUITE, TEST_PROJECT, ETEST_CLASS_SYNCHRONIZER} -- Access

	test_map: DS_HASH_TABLE [ETEST, READABLE_STRING_8]
			-- Table mapping test routine names to their corresponding {ETEST} instance.
			--
			-- key: test routine name
			-- value: {ETEST} instance

feature {ETEST_SUITE} -- Status setting

	set_eiffel_class (a_eiffel_class: like eiffel_class)
			-- Replace `eiffel_class' with new class.
			--
			-- `a_eiffel_class': Class to be assigned to `eiffel_class'.
		require
			a_eiffel_class_attached: a_eiffel_class /= Void
		do
			eiffel_class := a_eiffel_class
		ensure
			eiffel_class_set: eiffel_class = a_eiffel_class
		end

feature {ETEST_CLASS_SYNCHRONIZER} -- Status setting

	reset_test_map
			-- Assign new empty table to `test_map'.
		do
			test_map := new_test_map
		end

feature {ETEST_CLASS_SYNCHRONIZER} -- Factory

	new_test_map: like test_map
			-- Create new `test_map'
		do
			create Result.make_default
			Result.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [READABLE_STRING_8]})
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
