indexing
	description: "[
		An implementation of an logger service ({LOGGER_SERVICE_I}) item for logged messages.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVENT_LIST_LOG_ITEM

inherit
	EVENT_LIST_LOG_ITEM_I

	EVENT_LIST_ITEM
		rename
			make as make_event_list_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_category: like category; a_description: like description; a_level: like priority)
			-- Initialize a new event list error item.
			--
			-- `a_category': Log category, see {ENVIRONMENT_CATEGORIES}.
			-- `a_description': Log message.
			-- `a_level': Serverity level of the logged message.
		require
			a_category_is_valid_category: is_valid_category (a_category)
			a_description_attached: a_description /= Void
			not_a_description_is_empty: not a_description.is_empty
			a_level_is_valid_priority: is_valid_priority (a_level)
		do
			make_event_list_item (a_category, a_level, Void)
			description := a_description
		ensure
			category_set: category = a_category
			description_set: description = a_description
			priority_set: priority = a_level
		end

feature -- Access

	description: STRING_32
			-- Log message description

feature -- Query

	is_valid_data (a_data: like data): BOOLEAN
			-- Determines is the user data `a_data' is valid for the current event item.
			--
			-- `a_data': The user data to validate.
			-- `Result': True if the user data is valid; False otherwise.
		do
			Result := True
		end

invariant
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty

;indexing
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
