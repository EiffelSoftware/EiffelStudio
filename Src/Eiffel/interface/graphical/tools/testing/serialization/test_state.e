note
	description: "[
		Objects representing the state of some {TEST_I} instance.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STATE

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: like test_name)
			-- Initialize `Current'.
			--
			-- `a_name': Name of associated test.
		require
			a_name_attached: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			test_name := a_name
			create details.make_empty
		ensure
			not_tested: not is_tested
		end

feature -- Access

	test_name: IMMUTABLE_STRING_8
			-- Name of associated test

	tag: IMMUTABLE_STRING_8
			-- Test result tag
		require
			tested: is_tested
		local
			l_tag: like internal_tag
		do
			l_tag := internal_tag
			check l_tag /= Void end
			Result := l_tag
		end

	details: IMMUTABLE_STRING_8
			-- Details to test result

feature {NONE} -- Access

	internal_tag: detachable like tag
			-- Internal storage of `tag'

feature -- Status report

	is_tested: BOOLEAN
			-- Is result available?
		do
			Result := internal_tag /= Void
		end

	is_pass: BOOLEAN
			-- Does test result pass?

	is_fail: BOOLEAN
			-- Does test result fail?

	is_unresolved: BOOLEAN
			-- Is test result unresolved?
		do
			Result := not (is_pass or is_fail)
		end

feature -- Status setting

	add_result (a_tag: like tag; a_details: detachable like details; a_is_pass, a_is_fail: BOOLEAN)
			-- Add result details.
			--
			-- `a_tag': Test result tag.
			-- `a_details': Optional test result details.
			-- `a_is_pass': Does test result pass?
			-- `a_is_fail': Does test result fail?
		require
			a_tag_attached: a_tag /= Void
			not_pass_and_fail: not (a_is_pass and a_is_fail)
		do
			internal_tag := a_tag
			if a_details /= Void then
				details := a_details
			end
			is_pass := a_is_pass
			is_fail := a_is_fail
		end

feature -- Query

	is_less alias "<" (other: TEST_STATE): BOOLEAN
			-- <Precursor>
		do
			Result := test_name < other.test_name
		end

invariant
	not_pass_and_fail: not (is_pass and is_fail)

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
