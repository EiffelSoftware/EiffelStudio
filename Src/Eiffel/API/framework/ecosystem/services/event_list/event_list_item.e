indexing
	description: "[
		A base implementation of a event list items for use with the event list service ({EVENT_LIST_SERVICE_I}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	EVENT_LIST_ITEM

inherit
	EVENT_LIST_ITEM_I

feature {NONE} -- Initialization

	make (a_category: like category; a_priority: like priority; a_data: like data)
			-- Initialize a new event list error item.
			--
			-- `a_category': Event item category, see {EVENT_LIST_ITEM_CATEGORIES}
			-- `a_description': A textual representation of the error
			-- `a_data': The error object associated with this event ite
		require
			a_category_is_valid_category: is_valid_category (a_category)
			a_priority_is_valid_priority: is_valid_priority (a_priority)
			a_data_is_valid_data: is_valid_data (a_data)
		do
			category := a_category
			data := a_data
			priority := a_priority
		ensure
			category_set: category = a_category
			priority_set: priority = a_priority
			user_data_set: data = a_data
		end

feature -- Access

	category: NATURAL_8
			-- Event item category, see {ENVIRONMENT_CATEGORIES}

	priority: INTEGER_8
			-- Event item priority, see {PRIORITY_LEVELS}

	data: ANY
			-- Event item user data

feature -- Status report

	is_invalidated: BOOLEAN
			-- Indicates if the item has been invalidated and should be removed

feature -- Basic operations

	invalidate
			-- Invalidates the item for removal
		do
			is_invalidated := True
		end

invariant
	category_is_valid_category: is_valid_category (category)
	priority_is_valid_priority: is_valid_priority (priority)
	data_is_valid_data: is_valid_data (data)

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
