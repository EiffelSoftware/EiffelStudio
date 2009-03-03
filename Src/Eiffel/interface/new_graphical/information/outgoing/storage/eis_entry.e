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

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_protocol: like protocol; a_source: like source; a_tags: like tags a_id: like id; a_others: like others)
			-- Initialization
		require
			a_id_not_void: a_id /= Void
		do
			name := a_name
			protocol := a_protocol
			source := a_source
			tags := a_tags
			id := a_id
			others := a_others
		ensure
			name_set: name = a_name
			protocol_set: protocol = a_protocol
			source_set: source = a_source
			tags_set: tags = a_tags
			id_set: id = a_id
			others_set: others = a_others
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

	set_others (a_others: like others)
			-- Set `others' with `a_others'
		do
			others := a_others
		ensure
			others_set: others = a_others
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

	others: detachable HASH_TABLE [STRING_32, STRING_32]
			-- Other attributes of the entry

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

	others_as_string: detachable STRING_32
			-- Others as string
			-- Simple combination, not for display popose
		do
			if attached others as lt_others then
				create Result.make (10)
				from
					lt_others.start
				until
					lt_others.after
				loop
					Result.append (lt_others.key_for_iteration)
					Result.append (lt_others.item_for_iteration)
					lt_others.forth
				end
			end
		ensure
			others_not_void_implies_not_void:
					others /= Void implies Result /= Void
		end

feature -- Comparison

	same_entry (other: like Current): BOOLEAN
			-- <precursor>
			-- Do not compare ids.
		do
				-- Compare name
			Result := not ((name = Void) xor (other.name = Void))
			if Result then
				if name /= Void then
					Result := name.is_case_insensitive_equal (other.name)
				end
				if Result then
						-- Compare source
					Result := not ((source = Void) xor (other.source = Void))
					if Result then
						if source /= Void then
							Result := source.is_case_insensitive_equal (other.source)
						end
						if Result then
								-- Compare protocol
							Result := not ((protocol = Void) xor (other.protocol = Void))
							if Result then
								if protocol /= Void then
									Result := protocol.is_case_insensitive_equal (other.protocol)
								end
								if Result then
										-- Compare tags
									Result := not ((tags = Void) xor (other.tags = Void))
									if Result then
										if tags /= Void then
											Result := tags_as_string.is_case_insensitive_equal (other.tags_as_string)
										end
										if Result then
												-- Compare others
											Result := not ((others = Void) xor (other.others = Void))
											if Result then
												if others /= Void then
													Result := others_as_string.is_case_insensitive_equal (other.others_as_string)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
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
				if attached others_as_string as lt_others then
					l_string.append (lt_others)
				end
				Result := l_string.hash_code
			end
		end

feature {NONE} -- Hash code

	internal_hash_code: like hash_code;
			-- Catched hash code

invariant
	a_id_not_void: id /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
