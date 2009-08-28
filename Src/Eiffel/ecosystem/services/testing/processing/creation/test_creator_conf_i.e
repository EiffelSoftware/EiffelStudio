note
	description: "[
		Configuration used by test factories to create new eiffel tests
		
		An eiffel test is a routine in some class. If the test shall be
		created in a new class, class name and location must be provided.
		Otherwise an existing class is provided in which the test will
		simply be added.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATOR_CONF_I

inherit
	TEST_PROCESSOR_CONF_I

feature -- Access: tags

	tags: DS_LINEAR [READABLE_STRING_8]
			-- Predefined tags for new test
		require
			usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = tags
			not_contains_empty: not Result.there_exists (agent {READABLE_STRING_8}.is_empty)
		end

feature -- Access: new class

	new_class_name: STRING
			-- Name of the new class. If `is_multiple_new_classes' is true, it will be used as a prefix for
			-- all new classes.
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	cluster: CONF_CLUSTER
			-- Cluster in which new test classes will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	path: STRING
			-- Path relativ to location of `cluster' where new test classes will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

feature -- Status report

	is_new_class: BOOLEAN
			-- Will test be created in a new class?
		require
			usable: is_interface_usable
		deferred
		end

	is_multiple_new_classes: BOOLEAN
			-- Will factory create one or more new test classes?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_new_class: Result implies is_new_class
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
