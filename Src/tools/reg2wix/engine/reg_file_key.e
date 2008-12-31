note
	description: "[
		Represents a Windows registry file registry key.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	REG_FILE_KEY

inherit
	ERROR_HANDLER_PROVIDER
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_section: INI_SECTION; a_handler: like error_handler)
			-- Initialize a new {REG_FILE_KEY} using an INI file section `a_section'
		require
			a_section_attached: a_section /= Void
			a_handler_attached: a_handler /= Void
		do
			make_error (a_handler)
			create internal_named_values.make (5)
			process_ini_content (a_section)
		ensure
			error_handler_set: error_handler = a_handler
		end

feature -- Access

	name: STRING
			-- Key name

	default_value: REG_FILE_VALUE
			-- Default key value

	named_values: LINEAR [REG_FILE_VALUE]
			-- List of key's name/value pairs
		do
			Result := internal_named_values
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Determines if the key is devoid of values
		do
			Result := not default_value.has_value and then named_values.is_empty
		end

feature {NONE} -- Process

	process_ini_content (a_section: INI_SECTION)
			-- Processes the content of an INI document `a_doc'
		require
			a_section_attached: a_section /= Void
			internal_named_values_attached: internal_named_values /= Void
		do
			name := a_section.label
			a_section.named_properties.do_all (agent (a_item: INI_PROPERTY)
				do
					if a_item.name.is_equal (once "@") then
						check default_value_unattached: default_value = Void end
						create default_value.make (a_item, error_handler)
					else
						internal_named_values.extend (create {REG_FILE_NAMED_VALUE}.make (a_item, error_handler))
					end
				end)
			if default_value = Void then
				create default_value.make_empty (error_handler)
			end
		end

feature {NONE} -- Internal implementation cache

	internal_named_values: ARRAYED_LIST [REG_FILE_VALUE]
			-- Mutable version of `named_values'

invariant
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty
	default_value_attached: default_value /= Void
	internal_named_values_attached: internal_named_values /= Void

note
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
