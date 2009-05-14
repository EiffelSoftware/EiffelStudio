note
	description: "Note element and its subelements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_NOTE_ELEMENT

inherit
	ARRAYED_LIST [CONF_NOTE_ELEMENT]
		rename
			make as make_list
		end

create
	make

create {CONF_NOTE_ELEMENT}
	make_filled

feature {NONE} -- Initialization

	make (a_element_name: like element_name)
			-- Initialization
		require
			a_element_name_not_void:  a_element_name /= Void
		do
			make_list (0)
			element_name := a_element_name
			create attributes.make (0)
			create content.make_empty
		ensure
			element_name_set: element_name = a_element_name
		end

feature {CONF_ACCESS} -- Element Change

	set_attributes (a_attri: like attributes)
			-- Set `attributes' with `a_attri'
		require
			a_attri_not_void: a_attri /= Void
		do
			attributes := a_attri
		ensure
			attributes_set: attributes = a_attri
		end

	set_content (a_content: like content)
			-- Set `content' with `a_content'.
		require
			a_content_not_void: a_content /= Void
		do
			content := a_content
		ensure
			content_set: content = a_content
		end

	set_parent (a_parent: like parent)
			-- Set `parent' with `a_parent'
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	add_attribute (a_name, a_value: STRING)
			-- Add attribute with `a_name' and `a_value'.
		do
			attributes.force (a_name, a_value)
		end

feature -- Access

	element_name: STRING
			-- Name of the element

	attributes: HASH_TABLE [STRING, STRING]
			-- Attributes

	content: STRING
			-- Content

	parent: detachable CONF_NOTE_ELEMENT
			-- Parent element

invariant
	element_name_not_void: element_name /= Void
	attributes_not_void: attributes /= Void
	content_not_void: content /= Void

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
