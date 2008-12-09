indexing
	description: "[
		Unit tests for {TAG_COMPARATOR}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_COMPARATOR_TESTS

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Initialization

	on_prepare
			-- <Precursor>
		do
			create tagable1.make ("A")
			create tagable2.make ("B")
			create comparator.make ("")
		end

feature {NONE} -- Access

	tagable1, tagable2: ?TAG_DUMMY_TAGABLE

	comparator: ?TAG_COMPARATOR [TAG_DUMMY_TAGABLE]

feature -- Status report

	is_initialized: BOOLEAN
			-- Is `Current' in initial state?
		do
			Result := tagable1 /= Void and then tagable1.tags.is_empty and then
			          tagable2 /= Void and then tagable2.tags.is_empty and then
			          comparator /= Void and then comparator.tag.is_empty
		ensure
			result_implies_tagable1_attached: Result implies (tagable1 /= Void and then tagable1.tags.is_empty)
			result_implies_tagable2_attached: Result implies (tagable2 /= Void and then tagable2.tags.is_empty)
			result_imples_comparator_attached: Result implies (comparator /= Void and then comparator.tag.is_empty)
		end

feature -- Tests

	test_all_empty
		require
			initialized: is_initialized
		do
			assert ("all_empty", comparator.less_than (tagable1, tagable2))
		end

	test_tagables_empty
		require
			initialized: is_initialized
		do
			comparator.set_prefix ("prefix")
			assert ("tagables_empty", comparator.less_than (tagable1, tagable2))
		end

	test_tagable1_empty
		require
			initialized: is_initialized
		do
			tagable2.tags.force ("token1/token2/token3")
			assert ("tagable1_empty1", comparator.less_equal (tagable2, tagable1))

				-- In this case tagable1 is less because they both don't contain tags for "prefix"
			comparator.set_prefix ("prefix")
			assert ("tagable1_empty2", comparator.less_equal (tagable1, tagable2))

			comparator.set_prefix ("token1")
			assert ("tagable1_empty3", comparator.less_equal (tagable2, tagable1))
		end

	test_tagable2_empty
		require
			initialized: is_initialized
		do
			tagable1.tags.force ("token1/token2/token3")
			assert ("tagable2_empty1", comparator.less_equal (tagable1, tagable2))

			comparator.set_prefix ("prefix")
			assert ("tagable2_empty2", comparator.less_equal (tagable1, tagable2))

			comparator.set_prefix ("token1")
			assert ("tagable2_empty3", comparator.less_equal (tagable1, tagable2))
		end

	test_suffix_comparison
		require
			initialized: is_initialized
		do
			tagable1.tags.force ("token1/token2")
			tagable1.tags.force ("token3/bbb")
			tagable1.tags.force ("token4/token5")

			tagable2.tags.force ("token1/token2")
			tagable2.tags.force ("token3/aaa")
			tagable2.tags.force ("token4/token5")

			comparator.set_prefix ("token3")

			assert ("suffix_comparison", comparator.less_equal (tagable2, tagable1))
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
