note
	description: "[
		An implementation of an event list service ({EVENT_LIST_SERVICE_I}) item for Eiffel compiler {ERROR} objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVENT_LIST_ERROR_ITEM

inherit
	EVENT_LIST_ERROR_ITEM_I

	EVENT_LIST_ITEM
		rename
			make as make_event_list_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_category: like category; a_description: like description; a_error: like data)
			-- Initialize a new event list error item.
			--
			-- `a_category': Event item category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_description': A textual representation of the error.
			-- `a_error': The error object associated with this event item
		require
			a_category_is_valid_category: is_valid_category (a_category)
			a_description_attached: a_description /= Void
			not_a_description_is_empty: not a_description.is_empty
			a_error_is_valid_data: is_valid_data (a_error)
		do
			make_event_list_item (a_category, {PRIORITY_LEVELS}.normal, a_error)
			description := a_description
		ensure
			category_set: category = a_category
			description_set: description = a_description
			user_data_set: data = a_error
		end

feature -- Access

	description: STRING_32
			-- Event item description

feature -- Status report

	is_warning: BOOLEAN
			-- Indicates if the error item represents a warning
		do
			Result := False
		end

feature -- Query

	is_valid_data (a_data: like data): BOOLEAN
			-- Determines is the user data `a_data' is valid for the current event item.
			--
			-- `a_data': The user data to validate.
			-- `Result': True if the user data is valid; False otherwise.
		do
			Result := a_data /= Void and then (({ERROR}) #? a_data) /= Void
		end

invariant
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
