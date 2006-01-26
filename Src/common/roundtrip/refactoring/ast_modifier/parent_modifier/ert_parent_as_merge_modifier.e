indexing
	description: "[
					This class is used to merge text of two PARENT_AS objects.
					Merging criteria:
					1. rename clause:
						if "foo as goo" appears both in rename clause of `destination' and `source',
						it will appear once in merged text of `destination'. Otherwise, it will be added
						into rename clause of `destination'.
					2. export clause:
						for every feature foo with client set {S} in `source' and
						feature goo with client set {D} in `destination',
						if S = D and foo = goo, {S}foo will appear in merged text,
						if S = D and foo /= goo, {S}foo, goo will appear in merged text,
						if S /= D and foo = goo, {S, D}foo will appear in merged text,
						if S /= D and foo /= goo, both {S}foo and {D}goo will appear in merged text.
					3. undefine/redefine and select clause:
						Different feature names in `source' will be merged into `destination'.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PARENT_AS_MERGE_MODIFIER

inherit
	ERT_AST_MODIFIER

create
	make

feature{NONE} -- Implementation

	make (dest: like destination; dest_match_list: like destination_match_list;
	      sour: like source; sour_match_list: like source_match_list) is
			-- Initialize instance.
			-- Text of `source' will be merged into text of `dest'.
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
			compute_modification
			check
				last_computed_modifier /= Void
			end
			Result := last_computed_modifier.can_apply
		end

	apply is
		do
			compute_modification
			check
				last_computed_modifier /= Void
			end
			last_computed_modifier.apply
			applied := True
		end

feature{NONE} -- Modification computation

	last_computed_modifier: ERT_PARENT_AS_MODIFIER
			-- Last computed modifier with all needed modifications registered

	compute_modification is
			-- Compute modifications needed to merge text of two PARENT_AS objects.
		do
			create last_computed_modifier.make (destination, destination_match_list)
			compute_renaming_modification
			compute_export_modification
			compute_clauses_modification ({ERT_PARENT_AS_MODIFIER}.undefine_clause)
			compute_clauses_modification ({ERT_PARENT_AS_MODIFIER}.redefine_clause)
			compute_clauses_modification ({ERT_PARENT_AS_MODIFIER}.select_clause)
		ensure
			last_computed_modifier_set: last_computed_modifier /= Void
		end

	compute_export_modification is
			-- Compute modifications needed two merge export clauses.
		local
			l_sour_feature_set: ERT_EXPORT_FEATURE_SET
			l_dest_feature_set: ERT_EXPORT_FEATURE_SET
			l_merged_items: LIST [ERT_EXPORT_ITEM_LIST]
			l_index: INTEGER
			l_str_list: ARRAYED_LIST [STRING]
			l_str: STRING
			i: INTEGER
			done: BOOLEAN
		do
			check
				last_computed_modifier /= Void
			end
			if source.internal_exports /= Void and then not source.internal_exports.is_empty then
				if destination.internal_exports = Void or else destination.internal_exports.is_empty then
						-- If `destination' doesn't contain export clause or its export clause is empty,
						-- we just add every export item in `source' into export clause of `destination'.
					l_index := source.internal_exports.index
					from
						source.internal_exports.start
					until
						source.internal_exports.after
					loop
						last_computed_modifier.extend ({ERT_PARENT_AS_MODIFIER}.export_clause, source.internal_exports.item.text (source_match_list))
						source.internal_exports.forth
					end
					source.internal_exports.go_i_th (l_index)
				else
					create l_dest_feature_set.make (destination.internal_exports, destination_match_list)
					create l_sour_feature_set.make (source.internal_exports, source_match_list)
					l_dest_feature_set.merge (l_sour_feature_set)
					l_merged_items := l_dest_feature_set.export_items
					create l_str_list.make (l_merged_items.count)
						-- Construct every line in export clause.
					from
						l_merged_items.start
					until
						l_merged_items.after
					loop
						create l_str.make (50)
						l_str.append ("{")
						from
							l_merged_items.item.clients.start
						until
							l_merged_items.item.clients.after
						loop
							l_str.append (l_merged_items.item.clients.item)
							if l_merged_items.item.clients.index < l_merged_items.item.clients.count then
								l_str.append (", ")
							end
							l_merged_items.item.clients.forth
						end
						l_str.append ("} ")
						from
							l_merged_items.item.feature_name_list.start
						until
							l_merged_items.item.feature_name_list.after
						loop
							l_str.append (l_merged_items.item.feature_name_list.item)
							if l_merged_items.item.feature_name_list.index < l_merged_items.item.feature_name_list.count then
								l_str.append (", ")
							end
							l_merged_items.item.feature_name_list.forth
						end
						l_str_list.extend (l_str)
						l_merged_items.forth
					end
					l_index := destination.internal_exports.index
					from
						destination.internal_exports.start
						i := 1
						done := False
					until
						destination.internal_exports.after
					loop
						if not done then
							last_computed_modifier.replace ({ERT_PARENT_AS_MODIFIER}.export_clause, i, l_str_list.i_th (i))
							i := i + 1
							if i > l_str_list.count then
								done := True
							end
						else
							last_computed_modifier.remove ({ERT_PARENT_AS_MODIFIER}.export_clause, i)
						end
						destination.internal_exports.forth
					end
					destination.internal_exports.go_i_th (l_index)
					if i <= l_str_list.count then
						from

						until
							i > l_str_list.count
						loop
							last_computed_modifier.extend ({ERT_PARENT_AS_MODIFIER}.export_clause, l_str_list.i_th (i))
							i := i + 1
						end
					end
				end
			end
		end

	compute_renaming_modification is
			-- Compute modifications needed two merge rename clauses.
		local
			l_index: INTEGER
		do
			check
				last_computed_modifier /= Void
			end
			if source.internal_renaming /= Void and then not source.internal_renaming.is_empty then
				l_index := source.internal_renaming.index
				from
					source.internal_renaming.start
				until
					source.internal_renaming.after
				loop
					if not destination_contain_renamming (source.internal_renaming.item) then
						last_computed_modifier.extend ({ERT_PARENT_AS_MODIFIER}.rename_clause,
									  source.internal_renaming.item.old_name.internal_name + " as " +
									  source.internal_renaming.item.new_name.internal_name
									  )
					end
					source.internal_renaming.forth
				end
				source.internal_renaming.go_i_th (l_index)
			end
		end

	compute_clauses_modification (a_clause: INTEGER) is
			-- Compute modifications needed two merge undefine, redefine or select clauses.
			-- Inherit clause to be merged is indicated by `a_clause'.
		require
			a_clause_valid: a_clause = {ERT_PARENT_AS_MODIFIER}.undefine_clause or
							a_clause = {ERT_PARENT_AS_MODIFIER}.redefine_clause or
							a_clause = {ERT_PARENT_AS_MODIFIER}.select_clause
		local
			l_index: INTEGER
			l_dest_list: EIFFEL_LIST [FEATURE_NAME]
			l_sour_list: EIFFEL_LIST [FEATURE_NAME]
		do
			check
				last_computed_modifier /= Void
			end
			if a_clause = {ERT_PARENT_AS_MODIFIER}.undefine_clause then
				l_sour_list := source.internal_undefining
				l_dest_list := destination.internal_undefining
			elseif a_clause = {ERT_PARENT_AS_MODIFIER}.redefine_clause then
				l_sour_list := source.internal_redefining
				l_dest_list := destination.internal_redefining
			elseif a_clause = {ERT_PARENT_AS_MODIFIER}.select_clause then
				l_sour_list := source.internal_selecting
				l_dest_list := destination.internal_selecting
			end
			if l_sour_list /= Void and then not l_sour_list.is_empty then
				l_index := l_sour_list.index
				from
					l_sour_list.start
				until
					l_sour_list.after
				loop
					if not contain_feature_name (l_dest_list, l_sour_list.item.internal_name) then
						last_computed_modifier.extend (a_clause, l_sour_list.item.text (source_match_list))
					end
					l_sour_list.forth
				end
			end
		end

	contain_feature_name (a_list: EIFFEL_LIST [FEATURE_NAME]; a_name: STRING): BOOLEAN is
			-- Does `a_list' contain `a_name'?
		local
			l_index: INTEGER
		do
			if not (a_list = Void or else a_list.is_empty) then
				l_index := a_list.index
				from
					a_list.start
				until
					a_list.after or Result
				loop
					Result := a_name.is_case_insensitive_equal (a_list.item.internal_name)
					a_list.forth
				end
				a_list.go_i_th (l_index)
			end
		end

	destination_contain_renamming (rename_item: RENAME_AS): BOOLEAN is
			-- Does rename clause of `destination' already contain `rename_item'?
		require
			rename_item_not_void: rename_item /= Void
		local
			l_index: INTEGER
			l_rename: RENAME_AS
		do
			if not (destination.internal_renaming = Void or else destination.internal_renaming.is_empty) then
				l_index := destination.internal_renaming.index
				from
					destination.internal_renaming.start
				until
					destination.internal_renaming.after or Result
				loop
					l_rename := destination.internal_renaming.item
					Result :=
						l_rename.old_name.internal_name.is_case_insensitive_equal (rename_item.old_name.internal_name) and
						l_rename.new_name.internal_name.is_case_insensitive_equal (rename_item.new_name.internal_name)
					destination.internal_renaming.forth
				end
				destination.internal_renaming.go_i_th (l_index)
			end
		end

feature -- Access

	source: PARENT_AS
			-- Source PARENT_AS node

	source_match_list: LEAF_AS_LIST
			-- Match list of `source' needed for roundtrip operations

	destination: PARENT_AS
			-- destination PARENT_AS node whose test will be merged with text of `source'.

	destination_match_list: LEAF_AS_LIST
			-- Match list of `destination' needed for roundtrip operations	

invariant
	source_not_void: source /= Void
	destination_not_void: destination /= Void
	source_match_list_not_void: source_match_list /= Void
	destination_match_list_not_void: destination_match_list /= Void

end
