note
	description: "Represents a INI document section."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SECTION

inherit
	INI_PROPERTY_CONTAINER
		rename
			make as make_container
		end

	DEBUG_OUTPUT
		export
			{NONE}
		end

create
	make

feature {NONE} -- Initialization

	make (a_label: like label; a_document: like document)
			-- Initialize section with label `a_label'
		require
			a_label_attached: a_label /= Void
			not_a_label_is_empty: not a_label.is_empty
		do
			make_container
			label := a_label
			internal_document := a_document
		ensure then
			label_set: label = a_label
			document_set: document = a_document
		end

feature -- Access

	document: INI_DOCUMENT
			-- Document section belongs to
		do
			Result := internal_document
		end

	label: STRING assign set_label
			-- Section label

	is_empty: BOOLEAN
			-- Is section empty?
		do
			Result := properties.is_empty
		end

feature -- Status Setting

	set_label (a_label: like label)
			-- Set `label' with `a_label'
		require
			a_label_attached: a_label /= Void
			not_a_label_is_empty: not a_label.is_empty
		do
			label := a_label
		ensure
			label_set: label = a_label
		end

feature {NONE} -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			l_label: like label
		do
			l_label := label
			create Result.make (l_label.count + 2)
			Result.append_character ('[')
			Result.append (l_label)
			Result.append_character (']')
		ensure then
			result_not_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	internal_document: like document
			-- Internal version of `document'

invariant
	label_attached: label /= Void
	not_label_is_empty: not label.is_empty
	internal_document_attached: internal_document /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class INI_SECTION
