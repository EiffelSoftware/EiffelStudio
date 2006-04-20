indexing
	description : "Objects that represent a cell"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_CELL

inherit
	EB_CODE_COMPLETABLE_GRID_EDITABLE_ITEM
		redefine
			initialize_actions
		end

create
	default_create,
--	make_with_text,
	make_with_text_and_provider

feature -- Initialization

	make_with_text_and_provider (a_text: STRING; a_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER) is
			-- Set `text' with `a_text'.
			-- Set `completion_possibilities_provider' with `a_provider'.
		do
			make_with_text (a_text)
			completion_possibilities_provider := a_provider
		end

feature -- Query

	initialize_actions is
		do
			Precursor
			text_field.disable_edit
			if text_field.text_length > 0 then
				text_field.select_all
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
