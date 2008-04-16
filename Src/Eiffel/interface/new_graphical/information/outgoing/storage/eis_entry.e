indexing
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

	make (a_name: like name; a_protocol: like protocol; a_source: like source; a_tags: like tags a_id: like id; a_others: like others) is
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

	set_name (a_name: like name) is
			-- Set `name' with `a_name'
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_protocol (a_protocol: like protocol) is
			-- Set `protocol' with `a_protocol'
		do
			protocol := a_protocol
		ensure
			protocol_set: protocol = a_protocol
		end

	set_source (a_source: like source) is
			-- Set `source' with `a_source'
		do
			source := a_source
		ensure
			source_set: source = a_source
		end

	set_tags (a_tags: like tags) is
			-- Set `tags' with `a_tags'
		do
			tags := a_tags
		ensure
			tags_set: tags = a_tags
		end

	set_id (a_id: like id) is
			-- Set `id' with `a_id'
		require
			a_id_not_void: a_id /= Void
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_others (a_others: like others) is
			-- Set `others' with `a_others'
		do
			others := a_others
		ensure
			others_set: others = a_others
		end

feature -- Access

	name: STRING_32
			-- Name of the entry

	protocol: STRING_32
			-- Protocol of the entry

	source: STRING_32
			-- Source of the entry

	tags: ARRAYED_LIST [STRING_32]
			-- Tags of the entry

	id: STRING
			-- Id of the entry (from EB_SHARED_ID_SOLUTION)

	others: HASH_TABLE [STRING_32, STRING_32]
			-- Other attributes of the entry

	tags_as_string: STRING_32 is
			-- Tags as a string
			-- Simple combination, not for display popose
		do
			if {lt_tags: like tags}tags then
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

	others_as_string: STRING_32 is
			-- Others as string
			-- Simple combination, not for display popose
		do
			if {lt_others: like others}others then
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

	same_entry (other: like Current): BOOLEAN is
			-- <precursor>
			-- Do not compare ids.
		do
				-- Compare name
			Result := not ((name = Void) xor (other.name = Void))
			if Result and then name /= Void then
				Result := name.is_case_insensitive_equal (other.name)
				if Result then
						-- Compare source
					Result := not ((source = Void) xor (other.source = Void))
					if Result and then source /= Void then
						Result := source.is_case_insensitive_equal (other.source)
						if Result then
								-- Compare protocol
							Result := not ((protocol = Void) xor (other.protocol = Void))
							if Result and then protocol /= Void then
								Result := protocol.is_case_insensitive_equal (other.protocol)
								if Result then
										-- Compare tags
									Result := not ((tags = Void) xor (other.tags = Void))
									if Result and then tags /= Void then
										Result := tags_as_string.is_case_insensitive_equal (other.tags_as_string)
										if Result then
												-- Compare others
											Result := not ((others = Void) xor (other.others = Void))
											if Result and then others /= Void then
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

feature -- Hashable

	hash_code: INTEGER
			-- <precursor>
		local
			l_string: !STRING_32
		do
			Result := internal_hash_code
			if Result = 0 then
				create l_string.make (20)
				if {lt_name: STRING_32}name then
					l_string.append (lt_name)
				end
				if {lt_protocol: STRING_32}protocol then
					l_string.append (lt_protocol)
				end
				if {lt_source: STRING_32}source then
					l_string.append (lt_source)
				end
				if {lt_tags: like tags_as_string}tags_as_string then
					l_string.append (lt_tags)
				end
				if {lt_others: like others_as_string}others_as_string then
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

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
