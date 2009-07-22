note
	description: "[
		Representation of an object that contains tags
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAGABLE_I

inherit
	ACTIVE_ITEM_I
		redefine
			memento
		end

	TAG_UTILITIES

	HASHABLE

feature -- Access

	name: READABLE_STRING_GENERAL
			-- Name describing `Current'
		require
			usable: is_interface_usable
		deferred
		ensure
			not_empty: not Result.is_empty
		end

	tags: DS_LINEAR [STRING]
			-- List of tags
		require
			usable: is_interface_usable
		deferred
		ensure
			result_uses_string_equality: ({KL_STRING_EQUALITY_TESTER} #? Result.equality_tester) /= Void
			results_valid: Result.for_all (agent is_valid_tag)
			results_not_empty: not ({attached DS_LINEAR [STRING]} #? Result).there_exists (agent {attached STRING}.is_empty)
		end

	memento: TAGABLE_MEMENTO_I
			-- <Precursor>
		deferred
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
