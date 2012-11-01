note
	description: "Entry representing a piece of EIS information"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_ENTRY

inherit
	HASHABLE

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_protocol: like protocol; a_source: like source; a_tags: like tags a_id: like id; a_parameters: like parameters)
			-- Initialization
		require
			a_id_not_void: a_id /= Void
		do
			name := a_name
			protocol := a_protocol
			source := a_source
			tags := a_tags
			id := a_id
			parameters := a_parameters
		ensure
			name_set: name = a_name
			protocol_set: protocol = a_protocol
			source_set: source = a_source
			tags_set: tags = a_tags
			id_set: id = a_id
			parameters_set: parameters = a_parameters
		end

feature {ES_EIS_COMPONENT_VIEW} -- Element change
								-- Be careful to change entry that has been registered in storage.

	set_name (a_name: like name)
			-- Set `name' with `a_name'
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_protocol (a_protocol: like protocol)
			-- Set `protocol' with `a_protocol'
		do
			protocol := a_protocol
		ensure
			protocol_set: protocol = a_protocol
		end

	set_source (a_source: like source)
			-- Set `source' with `a_source'
		do
			source := a_source
		ensure
			source_set: source = a_source
		end

	set_tags (a_tags: like tags)
			-- Set `tags' with `a_tags'
		do
			tags := a_tags
		ensure
			tags_set: tags = a_tags
		end

	set_id (a_id: like id)
			-- Set `id' with `a_id'
		require
			a_id_not_void: a_id /= Void
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_parameters (a_parameters: like parameters)
			-- Set `parameters' with `a_parameters'
		do
			parameters := a_parameters
		ensure
			parameters_set: parameters = a_parameters
		end

feature {ES_EIS_NOTE_PICKER} -- Element change

	set_override (a_v: like override)
			-- Set `override' with `a_v'
		do
			override := a_v
		ensure
			override_set: override = a_v
		end

feature -- Access

	name: detachable STRING_32
			-- Name of the entry

	protocol: detachable STRING_32
			-- Protocol of the entry

	source: detachable STRING_32
			-- Source of the entry

	tags: detachable ARRAYED_LIST [STRING_32]
			-- Tags of the entry

	id: STRING
			-- Id of the entry (from EB_SHARED_ID_SOLUTION)

	parameters: detachable HASH_TABLE [STRING_32, STRING_32]
			-- Parameters of the entry

	override: BOOLEAN
			-- Overriding entry over auto entry?

	is_auto: BOOLEAN
			-- Is current an auto entry? (No actual written notes)
		do
			Result := False
		end

	tags_as_string: detachable STRING_32
			-- Tags as a string
			-- Simple combination, not for display popose
		do
			if attached tags as lt_tags then
				create Result.make (10)
				from
					lt_tags.start
				until
					lt_tags.after
				loop
					Result.append (lt_tags.item)
					lt_tags.forth
				end
			end
		ensure
			tags_not_void_implies_not_void:
					tags /= Void implies Result /= Void
		end

	parameters_as_string: detachable STRING_32
			-- Parameters as string
			-- Simple combination, not for display popose
		do
			if attached parameters as lt_parameters then
				create Result.make (10)
				from
					lt_parameters.start
				until
					lt_parameters.after
				loop
					Result.append (lt_parameters.key_for_iteration)
					Result.append (lt_parameters.item_for_iteration)
					lt_parameters.forth
				end
			end
		ensure
			parameters_not_void_implies_not_void:
					parameters /= Void implies Result /= Void
		end

feature -- Comparison

	same_entry (other: like Current): BOOLEAN
			-- <precursor>
			-- Do not compare ids.
		do
			Result :=
				same_string_attribute (name, other.name) and then
				same_string_attribute (source, other.source) and then
				same_string_attribute (protocol, other.protocol) and then
				same_string_attribute (tags_as_string, other.tags_as_string) and then
				same_string_attribute (parameters_as_string, other.parameters_as_string)
		end

feature -- Hashable

	hash_code: INTEGER
			-- <precursor>
		local
			l_string: STRING_32
		do
			Result := internal_hash_code
			if Result = 0 then
				create l_string.make (20)
				if attached name as lt_name then
					l_string.append (lt_name)
				end
				if attached protocol as lt_protocol then
					l_string.append (lt_protocol)
				end
				if attached source as lt_source then
					l_string.append (lt_source)
				end
				if attached tags_as_string as lt_tags then
					l_string.append (lt_tags)
				end
				if attached parameters_as_string as lt_parameters then
					l_string.append (lt_parameters)
				end
				Result := l_string.hash_code
			end
		end

feature {NONE} -- Implementation

	same_string_attribute (a_str, a_other: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Same string attribute of the entry?
			-- The same as `string_general_is_caseless_equal', except that
			-- we treat Void the same as an empty string.
		do
			Result :=
				(a_str = Void and a_other = Void) or else
				(attached a_str as l_str and then l_str.is_empty and then a_other = Void) or else
				(attached a_other as l_other and then l_other.is_empty and then a_str = Void) or else
				(attached a_str as l_str and then attached a_other as l_other and then l_str.is_case_insensitive_equal (l_other))
		end

feature {NONE} -- Hash code

	internal_hash_code: like hash_code;
			-- Catched hash code

invariant
	a_id_not_void: id /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
