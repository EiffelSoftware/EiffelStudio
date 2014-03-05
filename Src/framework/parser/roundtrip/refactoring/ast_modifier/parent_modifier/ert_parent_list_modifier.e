note
	description: "Object to merge text of parent list from two classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PARENT_LIST_MODIFIER

inherit
	ERT_AST_MODIFIER

create
	make

feature{NONE} -- Initialization

	make (dest: CLASS_AS; dest_match_list: LEAF_AS_LIST; sour: CLASS_AS; sour_match_list: LEAF_AS_LIST)
			-- Initialize.
		require
			dest_not_void: dest /= Void
			dest_match_list_not_void: dest_match_list /= Void
			sour_not_void: sour /= Void
			sour_match_list_not_void: sour_match_list /= Void
		do
			source := sour
			destination := dest
			destination_match_list := dest_match_list
			source_match_list := sour_match_list
		ensure
			destination_set: destination = dest
			destination_match_list_set: destination_match_list = dest_match_list
			source_set: source = sour
			source_match_list_set: source_match_list = sour_match_list
		end

feature -- Applicability

	can_apply: BOOLEAN
		local
			l_source_parents, l_destination_parents: detachable PARENT_LIST_AS
			l_last_computed_modifier: LINKED_LIST [ERT_AST_MODIFIER]
		do
			l_source_parents := source.parents
			l_destination_parents := destination.parents
			if
				l_source_parents = Void or else
			 	l_source_parents.is_empty
			 then
				Result := True
			elseif l_destination_parents = Void then
				Result := destination.class_name.can_append_text (destination_match_list)
			elseif attached l_destination_parents.inherit_keyword (destination_match_list) as l_inherit_token then
				Result := l_inherit_token.can_append_text (destination_match_list)
			else
				create l_last_computed_modifier.make
				compute_modification (l_last_computed_modifier)
				Result := l_last_computed_modifier.for_all (agent {ERT_AST_MODIFIER}.can_apply)
			end
		end

	apply
		local
			l_source_parents, l_destination_parents: detachable PARENT_LIST_AS
			l_last_computed_modifier: LINKED_LIST [ERT_AST_MODIFIER]
		do
			l_source_parents := source.parents
			l_destination_parents := destination.parents
			if
				l_source_parents = Void or else
			 	l_source_parents.is_empty
			then
			elseif l_destination_parents = Void then
				destination.class_name.append_text ("%N" + l_source_parents.text (source_match_list), destination_match_list)
			elseif attached l_destination_parents.inherit_keyword (destination_match_list) as l_inherit_token then
				l_inherit_token.replace_text (l_source_parents.text (source_match_list), destination_match_list)
			else
				create l_last_computed_modifier.make
				compute_modification (l_last_computed_modifier)
				l_last_computed_modifier.do_all (agent {ERT_AST_MODIFIER}.apply)
			end
			applied := True
		end

feature{NONE} -- Implementation

	compute_modification (last_computed_modifier: LINKED_LIST [ERT_AST_MODIFIER])
			-- Compute modification
		require
			merge_needed: attached destination.parents as l_dest_parents and then not l_dest_parents.is_empty
			source_has_parents: attached source.parents as l_src_parents and then not l_src_parents.is_empty
		local
			l_index: INTEGER
			dest_index: INTEGER
			dest_ori_index: INTEGER
			i: INTEGER
			dest_count: INTEGER
			done: BOOLEAN
			l_appended_parents: STRING
			l_modifier: ERT_EIFFEL_LIST_MODIFIER
			l_processed: ARRAY [BOOLEAN]
		do
			if attached source.parents as l_source_parents and then attached destination.parents as l_destination_parents then
				create l_appended_parents.make (256)
				create l_processed.make_filled (False, 1, l_destination_parents.count)
				dest_index := 1
				dest_count := l_destination_parents.count
				dest_ori_index := l_destination_parents.index
				l_index := l_source_parents.index
				from
					l_source_parents.start
				until
					l_source_parents.after
				loop
					from
						i := 1
						done := False
					until
						i > dest_count or done
					loop
						if not l_processed.item (i) then
							check
								same_type: l_source_parents.item.type.same_type (l_destination_parents.i_th (i).type)
							end
							if l_source_parents.item.type.is_equivalent (l_destination_parents.i_th (i).type) then
								last_computed_modifier.extend (
									create {ERT_PARENT_AS_MERGE_MODIFIER}.make
										(l_destination_parents.i_th (i), destination_match_list,
										 l_source_parents.item, source_match_list))
								done := True
								l_processed.put (True, i)
							end
						end
						i := i + 1
					end
					if not done then
						l_appended_parents.append ("%N%N%T")
						l_appended_parents.append (l_source_parents.item.text (source_match_list))
					else
						l_appended_parents.wipe_out
					end
					l_source_parents.forth
					if not l_appended_parents.is_empty then
						create l_modifier.make (l_destination_parents, destination_match_list)
						l_modifier.set_arguments ("", "", "")
						l_modifier.append (l_appended_parents.twin)
						l_appended_parents.wipe_out
						last_computed_modifier.extend (l_modifier)
					end
				end
				l_source_parents.go_i_th (l_index)
				l_destination_parents.go_i_th (dest_ori_index)
			end
		end

feature -- Access

	source: CLASS_AS
			-- Source PARENT_AS node

	source_match_list: LEAF_AS_LIST
			-- Match list of `source' needed for roundtrip operations

	destination: CLASS_AS
			-- destination PARENT_AS node whose test will be merged with text of `source'.

	destination_match_list: LEAF_AS_LIST
			-- Match list of `destination' needed for roundtrip operations	

invariant
	source_not_void: source /= Void
	destination_not_void: destination /= Void
	source_match_list_not_void: source_match_list /= Void
	destination_match_list_not_void: destination_match_list /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
