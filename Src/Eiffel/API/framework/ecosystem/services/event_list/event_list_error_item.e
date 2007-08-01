indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVENT_LIST_ERROR_ITEM

inherit
	EVENT_LIST_ITEM_I

create
	make

feature {NONE} -- Initialization

	make (a_category: like category; a_description: like description; a_data: like data)
			-- Initialize a new event list error item.
			--
			-- `a_category': Event item category, see {EVENT_LIST_ITEM_CATEGORIES}
			-- `a_description': A textual representation of the error
			-- `a_data': The error object associated with this event ite
		require
			a_category_is_valid_category: is_valid_category (a_category)
			a_description_attached: a_description /= Void
			not_a_description_is_empty: not a_description.is_empty
			a_data_attached: a_data /= Void
			a_data_is_error: (({ERROR}) #? a_data) /= Void
		do
			category := a_category
			description := a_description
			data := a_data
		ensure
			category_set: category = a_category
			description_set: description = a_description
			user_data_set: data = a_data
		end

feature -- Access

	category: NATURAL_8
			-- Event item category

	priority: NATURAL_8
			-- Event item priority

	description: STRING_32
			-- Event item description

	data: ANY
			-- Event item user data

feature -- Query

	is_valid_category (a_category: like category): BOOLEAN
			-- Determines if category `a_category' is valid for the current event item.
			--
			-- `a_category': A category code to validate.
			-- `Result': True if `a_category' is a valid category, False otherwise.
		do
			Result := a_category = {EVENT_LIST_ITEM_CATEGORIES}.unknown  or
				a_category = {EVENT_LIST_ITEM_CATEGORIES}.compilation
		end

	is_valid_priority (a_priority: like priority): BOOLEAN
			-- Determines if priority `a_priority' is valid for the current event item.
			--
			-- `a_priority': A priority code to validate.
			-- `Result': True if `a_priority' is a valid priority, False otherwise.
		do
			Result := True
		end

invariant
	user_data_attached: data /= Void
	user_data_is_error: (({ERROR}) #? data) /= Void

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
