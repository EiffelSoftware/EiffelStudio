note
	description: "Base implementation for elements of an INI document that can contain properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_PROPERTY_CONTAINER

feature {NONE} -- Initialization

	make
			-- Initialize section with label `a_label'
		do
			create properties.make (0)
			create literals.make (0)
		end

feature -- Access

	document: INI_DOCUMENT
			-- Document container is attached to.
		deferred
		ensure
			document_attached: document /= Void
		end

	literals: ARRAYED_LIST [INI_LITERAL]
			-- List of literals

	properties: ARRAYED_LIST [INI_PROPERTY]
			-- Default and named section properties

	default_properties: LIST [INI_PROPERTY]
			-- Retrieves list of only default (unnamed) properties in section
		do
			Result := partial_properties (False)
		ensure
			result_attached: Result /= Void
			result_is_complete: Result.count + named_properties.count = properties.count
			properties_unmoved: properties.cursor.is_equal (old properties.cursor)
		end

	named_properties: LIST [INI_PROPERTY]
			-- Retrieves list of only named properties in section
		do
			Result := partial_properties (True)
		ensure
			result_attached: Result /= Void
			result_is_complete: Result.count + default_properties.count = properties.count
			properties_unmoved: properties.cursor.is_equal (old properties.cursor)
		end

feature -- Query

	literals_of_name (a_name: STRING; a_ignore_case: BOOLEAN): ARRAYED_LIST [INI_LITERAL]
			-- Retrieves a list of literals by name
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_lit: INI_LITERAL
			l_equal: BOOLEAN
		do
			create Result.make (0)
			across
				literals as l
			loop
				l_lit := l
				if a_ignore_case then
					l_equal := l_lit.name.is_case_insensitive_equal (a_name)
				else
					l_equal := l_lit.name.is_equal (a_name)
				end
				if l_equal then
					Result.extend (l_lit)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	literal_of_name (a_name: STRING; a_ignore_case: BOOLEAN): detachable INI_LITERAL
			-- Retrieves first literal of name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_lit: INI_LITERAL
			l_equal: BOOLEAN
		do
			across
				literals as l
			until
				attached Result
			loop
				l_lit := l
				if a_ignore_case then
					l_equal := l_lit.name.is_case_insensitive_equal (a_name)
				else
					l_equal := l_lit.name.is_equal (a_name)
				end
				if l_equal then
					Result := l_lit
				end
			end
		ensure
			result_attached: not literals_of_name (a_name, a_ignore_case).is_empty implies Result /= Void
		end

	properties_of_name (a_name: STRING; a_ignore_case: BOOLEAN): ARRAYED_LIST [INI_PROPERTY]
			-- Retrieves a list of properties by name
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_prop: INI_PROPERTY
			l_equal: BOOLEAN
		do
			create Result.make (0)
			across
				named_properties as p
			loop
				l_prop := p
				if attached l_prop.name as n then
					if a_ignore_case then
						l_equal := n.is_case_insensitive_equal (a_name)
					else
						l_equal := n.is_equal (a_name)
					end
				else
					l_equal := False
				end
				if l_equal then
					Result.extend (l_prop)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	property_of_name (a_name: STRING; a_ignore_case: BOOLEAN): detachable INI_PROPERTY
			-- Retrieves first property of name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_prop: INI_PROPERTY
			l_equal: BOOLEAN
		do
			across
				named_properties as p
			until
				attached Result
			loop
				l_prop := p
				if attached l_prop.name as n then
					if a_ignore_case then
						l_equal := n.is_case_insensitive_equal (a_name)
					else
						l_equal := n.is_equal (a_name)
					end
				else
					l_equal := False
				end
				if l_equal then
					Result := l_prop
				end
			end
		ensure
			result_attached: not properties_of_name (a_name, a_ignore_case).is_empty implies Result /= Void
		end

feature {NONE} -- Implementation

	partial_properties (a_named: BOOLEAN): LIST [INI_PROPERTY]
			-- Retrieves list of only properties in section according to `a_named'.
			-- When `a_named' is True only named properties are returned, when False only
			-- unnamed (default) properties are returned.
		local
			l_properties: like properties
			l_property: INI_PROPERTY
			l_result: ARRAYED_LIST [INI_PROPERTY]
		do
			l_properties := properties
			create l_result.make (l_properties.count)
			across
				l_properties as p
			loop
				l_property := p
				if l_property.is_default_property /= a_named then
					l_result.extend (l_property)
				end
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
			properties_unmoved: properties.cursor.is_equal (old properties.cursor)
		end

invariant
	properties_attached: properties /= Void
	literals_attached: literals /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
