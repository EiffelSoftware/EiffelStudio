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

	make (a_name: like name; a_protocol: like protocol; a_source: like source; a_tags: like tags; a_id: like target_id; a_parameters: like parameters)
			-- Initialization
		require
			a_id_not_void: a_id /= Void
			id_valid: valid_attribute (a_id)
			name_valid: a_name /= Void implies valid_attribute (a_name)
			protocol_valid: a_protocol /= Void implies valid_attribute (a_protocol)
			source_valid: a_source /= Void implies valid_attribute (a_source)
			tags_valid: a_tags /= Void implies valid_tags (a_tags)
			parameters_valid: a_parameters /= Void implies valid_parameters (a_parameters)
		do
			name := a_name
			protocol := a_protocol
			source := a_source
			tags := a_tags
			target_id := a_id
			parameters := a_parameters
		ensure
			name_set: name = a_name
			protocol_set: protocol = a_protocol
			source_set: source = a_source
			tags_set: tags = a_tags
			id_set: target_id = a_id
			parameters_set: parameters = a_parameters
		end

feature {ES_EIS_COMPONENT_VIEW} -- Element change

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
			-- Be careful to change entry that has been registered in storage.
		require
			name_valid: a_name /= Void implies valid_attribute (a_name)
		local
			l_name: like name
		do
			l_name := name
			name := a_name
			if not same_string_attribute (l_name, a_name) then
				reset_fingerprint
			end
		ensure
			name_set: name = a_name
		end

	set_protocol (a_protocol: like protocol)
			-- Set `protocol' with `a_protocol'.
			-- Be careful to change entry that has been registered in storage.
		require
			protocol_valid: a_protocol /= Void implies valid_attribute (a_protocol)
		local
			l_protocol: like protocol
		do
			l_protocol := protocol
			protocol := a_protocol
			if not same_string_attribute (l_protocol, a_protocol) then
				reset_fingerprint
			end
		ensure
			protocol_set: protocol = a_protocol
		end

	set_source (a_source: like source)
			-- Set `source' with `a_source'.
			-- Be careful to change entry that has been registered in storage.
		require
			source_valid: a_source /= Void implies valid_attribute (a_source)
		local
			l_source: like source
		do
			l_source := source
			source := a_source
			if not same_string_attribute (l_source, a_source) then
				reset_fingerprint
			end
		ensure
			source_set: source = a_source
		end

	set_tags (a_tags: like tags)
			-- Set `tags' with `a_tags'.
			-- Be careful to change entry that has been registered in storage.
		require
			tags_valid: a_tags /= Void implies valid_tags (a_tags)
		local
			l_tags: like tags
		do
			l_tags := tags
			tags := a_tags
			if l_tags /= a_tags then
				reset_fingerprint
			end
		ensure
			tags_set: tags = a_tags
		end

	set_id (a_id: like target_id)
			-- Set `id' with `a_id'.
			-- Be careful to change entry that has been registered in storage.
		require
			a_id_not_void: a_id /= Void
			id_valid: valid_attribute (a_id)
		do
			target_id := a_id
		ensure
			id_set: target_id = a_id
		end

	set_parameters (a_parameters: like parameters)
			-- Set `parameters' with `a_parameters'.
			-- Be careful to change entry that has been registered in storage.
		require
			parameters_valid: a_parameters /= Void implies valid_parameters (a_parameters)
		local
			l_parameters: like parameters
		do
			l_parameters := parameters
			parameters := a_parameters
			if l_parameters /= a_parameters then
				reset_fingerprint
			end
		ensure
			parameters_set: parameters = a_parameters
		end

feature -- Query

	valid_attribute (a_attr: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_attr' valid?
		do
			Result := a_attr.is_empty or else (not a_attr.item (1).is_space and then not a_attr.item (a_attr.count).is_space)
		end

	valid_tags (a_tags: like tags): BOOLEAN
			-- Is `a_tags' valid?
		do
			Result := across a_tags as l_c all valid_attribute (l_c.item) end
		end

	valid_parameters (a_parameters: like parameters): BOOLEAN
			-- Is `a_tags' valid?
		do
			Result := across a_parameters as l_c all valid_attribute (l_c.key) and then valid_attribute (l_c.item) end
		end

feature {ES_EIS_NOTE_PICKER} -- Element change

	set_override (a_v: like override)
			-- Set `override' with `a_v'.
			-- Be careful to change entry that has been registered in storage.
		do
			override := a_v
		ensure
			override_set: override = a_v
		end

	set_source_pos (a_pos: like source_pos)
			-- Set `source_pos' with `a_pos'.
			-- Be careful to change entry that has been registered in storage.
		do
			source_pos := a_pos
		ensure
			source_pos_set: source_pos = a_pos
		end

feature -- Access

	name: detachable STRING_32 assign set_name
			-- Name of the entry

	protocol: detachable STRING_32 assign set_protocol
			-- Protocol of the entry

	source: detachable STRING_32 assign set_source
			-- Source of the entry

	tags: detachable ARRAYED_LIST [STRING_32] assign set_tags
			-- Tags of the entry

	target_id: STRING
			-- Id of the entry (from EB_SHARED_ID_SOLUTION)

	parameters: detachable STRING_TABLE [STRING_32] assign set_parameters
			-- Parameters of the entry

	override: BOOLEAN assign set_override
			-- Overriding entry over auto entry?

	source_pos: TUPLE [pos, len: INTEGER] assign set_source_pos
			-- Source character position in orignal file.

	entry_id: STRING
			-- Identifier of the entry
		do
			Result := fingerprint.md5
		end

	is_auto: BOOLEAN
			-- Is current an auto entry? (No actual written notes)
		do
			Result := False
		end

	tags_as_string: detachable STRING_32
			-- Tags as a string
			-- Simple combination, not for display purpose.
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
			-- Simple combination, not for display purpose.
		do
			if attached parameters as lt_parameters then
				create Result.make (10)
				from
					lt_parameters.start
				until
					lt_parameters.after
				loop
					Result.append_string_general (lt_parameters.key_for_iteration)
					Result.append (lt_parameters.item_for_iteration)
					lt_parameters.forth
				end
			end
		ensure
			parameters_not_void_implies_not_void:
					parameters /= Void implies Result /= Void
		end

	fingerprint: EIS_MD5_FINGERPRINT
			-- Finger print of the entry itself
		do
			if attached internal_fingerprint as l_f then
				Result := l_f
			else
				update_fingerprint
				Result := internal_fingerprint
			end
		ensure
			fingerprint_set: Result /= Void
		end

feature -- Comparison

	same_entry (other: like Current): BOOLEAN
			-- <precursor>
			-- Do not compare ids.
		do
			Result := fingerprint.same_fingerprint (other.fingerprint)
		end

feature -- Hashable

	hash_code: INTEGER
			-- <precursor>
		do
			Result := internal_hash_code
			if Result = 0 then
				Result := fingerprint.md5.hash_code
				internal_hash_code := Result
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
				(a_other /= Void and then a_other.is_empty and then a_str = Void) or else
				(attached a_str as l_str and then a_other /= Void and then l_str.is_case_insensitive_equal (a_other))
		end

	updated_fingerprint: like fingerprint
			-- Updated fingerprint according to current entry
		local
			l_string: STRING_32
		do
			create l_string.make (100)
			l_string.append (target_id)
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
			l_string.append (override.out)
			create Result.make_with_content (l_string)
		end

	update_fingerprint
			-- Update fingerprint.
		do
			internal_fingerprint := updated_fingerprint
		ensure
			fingerprint_set: internal_fingerprint /= Void
		end

	reset_fingerprint
			-- Reset `fingerprint'.
		do
			internal_fingerprint := Void
			internal_hash_code := 0
		end

	internal_fingerprint: detachable EIS_MD5_FINGERPRINT
			-- Cache for md5

feature {NONE} -- Hash code

	internal_hash_code: like hash_code;
			-- Cached hash code

invariant
	id_not_void: target_id /= Void

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
