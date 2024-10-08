﻿note
	description: "[
		An interface for the most basic event list item used with the event service. See {EVENT_SERVICE_I} for more information on the
		event service and how items are used.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	EVENT_LIST_ITEM_I

inherit
	ANY

	SHARED_ENVIRONMENT_CATEGORIES
		export
			{NONE} all
		end

	SHARED_PRIORITY_LEVELS
		export
			{NONE} all
		end

feature -- Access

	type: NATURAL_8
			-- Event list item type identifier, see {EVENT_LIST_ITEM_TYPES}.
		deferred
		end

	category: NATURAL_8 assign set_category
			-- Event list item category, see {ENVIRONMENT_CATEGORIES}.
		deferred
		ensure
			result_is_valid_category: is_valid_category (Result)
		end

	priority: INTEGER_8 assign set_priority
			-- Event list item priority, see {PRIORITY_LEVELS}.
		deferred
		ensure
			result_is_valid_priority: is_valid_priority (Result)
		end

	description: STRING_32
			-- Event list item description.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	data: detachable ANY
			-- User custom data.
		deferred
		ensure
			result_is_valid_data: is_valid_data (Result)
		end

feature -- Element change

	set_category (a_category: like category)
			-- Sets a new category.
			--
			-- `a_category': An event list category, see {ENVIRONMENT_CATEGORIES}.
		require
			a_category_is_valid_category: is_valid_category (a_category)
		deferred
		ensure
			category_set: category = category
		end

	set_priority (a_priority: like priority)
			-- Sets a new priority.
			--
			-- `a_priority': An event list category, see {PRIORITY_LEVELS}.
		require
			a_priority_is_valid_priority: is_valid_priority (a_priority)
		deferred
		ensure
			priority_set: priority = a_priority
		end

feature -- Status report

	is_persistent: BOOLEAN
			-- Indicates if the event list item should remain in the event list item heap.
		do
			Result := True
		end

	is_invalidated: BOOLEAN
			-- Indicates if the item has been invalidated and should be removed
		deferred
		end

feature -- Query

	is_valid_category (a_category: like category): BOOLEAN
			-- Determines if category `a_category' is valid for the current event item.
			--
			-- `a_category': A category code to validate.
			-- `Result': True if `a_category' is a valid category; False otherwise.
		do
			Result := categories.is_valid_category (a_category)
		end

	is_valid_priority (a_priority: like priority): BOOLEAN
			-- Determines if priority `a_priority' is valid for the current event item.
			--
			-- `a_priority': A priority code to validate.
			-- `Result': True if `a_priority' is a valid priority; False otherwise.
		do
			Result := priorities.is_valid_priority_level (a_priority)
		end

	is_valid_data (a_data: like data): BOOLEAN
			-- Determines is the user data `a_data' is valid for the current event item.
			--
			-- `a_data': The user data to validate.
			-- `Result': True if the user data is valid; False otherwise.
		deferred
		end

feature -- Basic operations

	invalidate
			-- Invalidates the item for removal
		require
			not_is_invalidated: not is_invalidated
		deferred
		ensure
			is_invalidated: is_invalidated
		end

invariant
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	category_is_valid_category: is_valid_category (category)
	priority_is_valid_priority: is_valid_priority (priority)
	data_is_valid_data: is_valid_data (data)

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
