note
	description: "[
		Observer used to notify test suite service that class has been removed.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_CLUSTER_OBSERVER

inherit
	EB_CLUSTER_MANAGER_OBSERVER
		redefine
			on_class_removed
		end

	SHARED_TEST_SERVICE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			manager.add_observer (Current)
		end

feature {NONE} -- Events

	on_class_removed (a_class: CLASS_I)
			-- <Precursor>
		do
			if attached {EIFFEL_CLASS_I} a_class as l_class and then test_suite.is_service_available then
				--test_suite.service.synchronize_with_class (l_class)
			end
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
