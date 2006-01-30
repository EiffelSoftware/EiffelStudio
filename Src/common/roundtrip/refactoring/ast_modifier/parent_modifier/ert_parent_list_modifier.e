indexing
	description: "Object to merge text of parent list from two classes"
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

	make (dest: CLASS_AS; dest_match_list: LEAF_AS_LIST; sour: CLASS_AS; sour_match_list: LEAF_AS_LIST) is
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

	can_apply: BOOLEAN is
		do
			if
				source.internal_parents = Void or else
			 	source.internal_parents.is_empty
			 then
				Result := True
			elseif destination.internal_parents = Void then
				Result := destination.class_name.can_append_text (destination_match_list)
			elseif destination.internal_parents.is_empty then
				Result := destination.internal_parents.inherit_keyword.can_append_text (destination_match_list)
			else
				compute_modification
				Result := last_computed_modifier.for_all (agent {ERT_AST_MODIFIER}.can_apply)
			end
		end

	apply is
		do
			if
				source.internal_parents = Void or else
			 	source.internal_parents.is_empty
			then
			elseif destination.internal_parents = Void then
				destination.class_name.append_text ("%N"+source.internal_parents.text (source_match_list), destination_match_list)
			elseif destination.internal_parents.is_empty then
				destination.internal_parents.inherit_keyword.replace_text (source.internal_parents.text (source_match_list), destination_match_list)
			else
				compute_modification
				last_computed_modifier.do_all (agent {ERT_AST_MODIFIER}.apply)
			end
			applied := True
		end

feature{NONE} -- Implementation

	last_computed_modifier: LINKED_LIST [ERT_AST_MODIFIER]
			-- Last computed modifier list

	compute_modification is
			-- Compute modification
		require
			merge_needed: destination.internal_parents /= Void and then not destination.internal_parents.is_empty
			source_has_parents: source.internal_parents /= Void and then not source.internal_parents.is_empty
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
			create last_computed_modifier.make
			create l_appended_parents.make (256)
			create l_processed.make (1, destination.internal_parents.count)
			dest_index := 1
			dest_count := destination.internal_parents.count
			dest_ori_index := destination.internal_parents.index
			l_index := source.internal_parents.index
			from
				source.internal_parents.start
			until
				source.internal_parents.after
			loop
				from
					i := 1
					done := False
				until
					i > dest_count or done
				loop
					if not l_processed.item (i) then
						if source.internal_parents.item.type.is_equivalent (destination.internal_parents.i_th (i).type) then
							last_computed_modifier.extend (
								create {ERT_PARENT_AS_MERGE_MODIFIER}.make
									(destination.internal_parents.i_th (i), destination_match_list,
									 source.internal_parents.item, source_match_list))
							done := True
							l_processed.put (True, i)
						end
					end
					i := i + 1
				end
				if not done then
					l_appended_parents.append ("%N%N%T")
					l_appended_parents.append (source.internal_parents.item.text (source_match_list))
				end
				source.internal_parents.forth
				if not l_appended_parents.is_empty then
					create l_modifier.make (destination.internal_parents, destination_match_list)
					l_modifier.set_arguments ("", "", "")
					l_modifier.append (l_appended_parents)
					last_computed_modifier.extend (l_modifier)
				end
			end
			source.internal_parents.go_i_th (l_index)
			destination.internal_parents.go_i_th (dest_ori_index)
		ensure
			modification_computed: last_computed_modifier /= Void
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


end
