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
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			parents_of_same_type: dest.type.same_type (sour.type) and then dest.type.is_equivalent (sour.type)
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
			l_index: INTEGER
			l_str_list: ARRAYED_LIST [STRING]
			i: INTEGER
			done: BOOLEAN
		do
			check
				last_computed_modifier /= Void
			end
			if
				source.internal_exports /= Void and then
				source.internal_exports.content /= Void and then
				not source.internal_exports.content.is_empty
			then
				if
					destination.internal_exports = Void or else
					destination.internal_exports.content = Void or else
					destination.internal_exports.content.is_empty then
						-- If `destination' doesn't contain export clause or its export clause is empty,
						-- we just add every export item in `source' into export clause of `destination'.
					l_index := source.internal_exports.content.index
					from
						source.internal_exports.content.start
					until
						source.internal_exports.content.after
					loop
						last_computed_modifier.extend ({ERT_PARENT_AS_MODIFIER}.export_clause, source.internal_exports.content.item.text (source_match_list))
						source.internal_exports.content.forth
					end
					source.internal_exports.content.go_i_th (l_index)
				else
					l_str_list := new_exported_items
					l_index := destination.internal_exports.content.index
					from
						destination.internal_exports.content.start
						i := 1
						done := False
					until
						destination.internal_exports.content.after
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
						destination.internal_exports.content.forth
					end
					destination.internal_exports.content.go_i_th (l_index)
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
			l_rename_list: EIFFEL_LIST [RENAME_AS]
		do
			check
				last_computed_modifier /= Void
			end
			if source.internal_renaming /= Void and then source.internal_renaming.content /= Void then
				l_rename_list := source.internal_renaming.content
				l_index := l_rename_list.index
				from
					l_rename_list.start
				until
					l_rename_list.after
				loop
					if not destination_contain_renamming (l_rename_list.item) then
						last_computed_modifier.extend ({ERT_PARENT_AS_MODIFIER}.rename_clause,
									  l_rename_list.item.old_name.internal_name.name + " as " +
									  l_rename_list.item.new_name.internal_name.name
									  )
					end
					l_rename_list.forth
				end
				l_rename_list.go_i_th (l_index)
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
			l_name_list: LINKED_LIST [STRING]
			l_name: STRING
		do
			check
				last_computed_modifier /= Void
			end
			if a_clause = {ERT_PARENT_AS_MODIFIER}.undefine_clause then
					-- We are processing undefine clause.
				if source.internal_undefining /= Void then
					l_sour_list := source.internal_undefining.content
				else
					l_sour_list := Void
				end
				if destination.internal_undefining /= Void then
					l_dest_list := destination.internal_undefining.content
				else
					l_dest_list := Void
				end
			elseif a_clause = {ERT_PARENT_AS_MODIFIER}.redefine_clause then
					-- We are processing redefine clause.				
				if source.internal_redefining /= Void then
					l_sour_list := source.internal_redefining.content
				else
					l_sour_list := Void
				end
				if destination.internal_redefining /= Void then
					l_dest_list := destination.internal_redefining.content
				else
					l_dest_list := Void
				end
			elseif a_clause = {ERT_PARENT_AS_MODIFIER}.select_clause then
					-- We are processing select clause.				
				if source.internal_selecting /= Void then
					l_sour_list := source.internal_selecting.content
				else
					l_sour_list := Void
				end
				if destination.internal_selecting /= Void then
					l_dest_list := destination.internal_selecting.content
				else
					l_dest_list := Void
				end
			end
				-- Update names that have been renamed.
			create l_name_list.make
			l_name_list.compare_objects
			if l_dest_list /= Void then
				l_index := l_dest_list.index
				from
					l_dest_list.start
				until
					l_dest_list.after
				loop
					l_name := l_dest_list.item.internal_name.name.as_lower
					if final_names.has (l_name) then
						l_name := final_names.item (l_name)
						last_computed_modifier.replace (a_clause, l_dest_list.index, l_name)
						l_name_list.extend (l_name)
					end
					l_dest_list.forth
				end
				l_dest_list.go_i_th (l_index)
			end
				-- Add new feature names from `source' to `destination'.
			if l_sour_list /= Void and then not l_sour_list.is_empty then
				l_index := l_sour_list.index
				from
					l_sour_list.start
				until
					l_sour_list.after
				loop
					if not l_name_list.has (l_sour_list.item.internal_name.name.as_lower) then
						last_computed_modifier.extend (a_clause, l_sour_list.item.text (source_match_list))
					end
					l_sour_list.forth
				end
				l_sour_list.go_i_th (l_index)
			end
		end

	destination_contain_renamming (rename_item: RENAME_AS): BOOLEAN is
			-- Does rename clause of `destination' already contain `rename_item'?
		require
			rename_item_not_void: rename_item /= Void
		local
			l_index: INTEGER
			l_rename: RENAME_AS
			l_rename_list: EIFFEL_LIST [RENAME_AS]
		do
			if not (destination.internal_renaming = Void or else destination.internal_renaming.content = Void or else destination.internal_renaming.content.is_empty) then
				l_rename_list := destination.internal_renaming.content
				l_index := l_rename_list.index
				from
					l_rename_list.start
				until
					l_rename_list.after or Result
				loop
					l_rename := l_rename_list.item
					Result :=
						l_rename.old_name.internal_name.name.is_case_insensitive_equal (rename_item.old_name.internal_name.name) and
						l_rename.new_name.internal_name.name.is_case_insensitive_equal (rename_item.new_name.internal_name.name)
					l_rename_list.forth
				end
				l_rename_list.go_i_th (l_index)
			end
		end

	new_exported_items: ARRAYED_LIST [STRING] is
			-- List of string represnets text of merged exported items
		local
			l_sour_feature_set: ERT_EXPORT_FEATURE_SET
			l_dest_feature_set: ERT_EXPORT_FEATURE_SET
			l_merged_items: LIST [ERT_EXPORT_ITEM_LIST]
			l_str: STRING
			l_name, l_final_name: STRING
		do
			create l_dest_feature_set.make (destination.internal_exports.content, final_names, destination_match_list)
			create l_sour_feature_set.make (source.internal_exports.content, final_names, source_match_list)
			l_dest_feature_set.merge (l_sour_feature_set)
			l_merged_items := l_dest_feature_set.export_items
			create Result.make (l_merged_items.count)
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
					l_name := l_merged_items.item.feature_name_list.item
					l_final_name := final_names.item (l_name)
					if l_final_name = Void then
						l_str.append (l_name)
					else
						l_str.append (l_final_name)
					end

					if l_merged_items.item.feature_name_list.index < l_merged_items.item.feature_name_list.count then
						l_str.append (", ")
					end
					l_merged_items.item.feature_name_list.forth
				end
				Result.extend (l_str)
				l_merged_items.forth
			end
		end

	final_names: HASH_TABLE [STRING, STRING] is
			-- Final names (renamed features) of all renamed features.
		do
			if internal_final_names = Void then
				create internal_final_names.make (10)
				internal_final_names.compare_objects
				build_final_names (source.internal_renaming, internal_final_names)
				build_final_names (destination.internal_renaming, internal_final_names)
			end
			Result := internal_final_names
		end

	internal_final_names: like final_names
			-- Final names of all renamed features.

	build_final_names (a_rename_clause: RENAME_CLAUSE_AS; a_name_table: like final_names) is
			-- Build a hash_tabel for renamed features.
		require
			a_name_table_not_void: a_name_table /= Void
		local
			l_index: INTEGER
			old_name: STRING
			new_name: STRING
		do
			if
				a_rename_clause /= Void and then
				a_rename_clause.content /= Void and then
				not a_rename_clause.content.is_empty
			then
				l_index := a_rename_clause.content.index
				from
					a_rename_clause.content.start
				until
					a_rename_clause.content.after
				loop
					old_name := a_rename_clause.content.item.old_name.internal_name.name.as_lower
					new_name := a_rename_clause.content.item.new_name.internal_name.name.as_lower
					a_name_table.force (new_name, old_name)
					a_rename_clause.content.forth
				end
				a_rename_clause.content.go_i_th (l_index)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end
