indexing
	description: "Visitor that changes all occurances of a feature name to a new name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_RENAME_FEATURE_VISITOR

inherit
	AST_REFACTORING_VISITOR
		redefine
			process_routine_creation_as,
			process_tilda_routine_creation_as,
			process_agent_routine_creation_as,
			process_interval_as,
			process_address_as,
			process_parent_as,
			process_create_as,
			process_like_id_as,
			process_feat_name_id_as,
			process_feature_as, process_body_as,
			process_access_feat_as,
			process_access_id_as,
			process_access_assert_as,
			process_access_inv_as,
			process_static_access_as,
			process_break_as,
			process_string_as, process_verbatim_string_as
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: FEATURE_I; a_new_feature_name: STRING; a_change_comments: BOOLEAN; a_change_strings: BOOLEAN; a_recursive_descendants: SEARCH_TABLE [INTEGER]; an_is_descendant: BOOLEAN) is
			-- Create a visitor that renames the feature `a_feature' into `a_new_feature_name'.
			-- `a_change_comments' specifies if the occurance of the name in comments should be changed.
			-- `a_change_strings' specifies if the occurance of the name in strings should be changed.
			-- `a_recursive_descendants' are the class ids of all (until the feature gets undefined or renamed) the descendants of the class that changed the feature.
			-- `an_is_descendant' specifies if this class is a recursive_descendant of the class where the feature was changed
		require
			a_feature_not_void: a_feature /= Void
			a_new_feature_name_ok: a_new_feature_name /= Void and not a_new_feature_name.is_empty
			a_recursive_descendants_not_void: a_recursive_descendants /= Void
		do
			feature_i := a_feature
			rout_id_set := feature_i.rout_id_set
			old_feature_name := a_feature.feature_name.as_lower
			new_feature_name := a_new_feature_name.as_lower
			change_comments := a_change_comments
			change_strings := a_change_strings
			recursive_descendants := a_recursive_descendants
			is_descendant := an_is_descendant

			create type_checker
		end

feature -- Status

	is_renaming: BOOLEAN
			-- Is the class renaming the feature?

feature {NONE} -- Visitor implementation

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.target)
			if recursive_descendants.has (l_as.class_id) then
					-- check if it is the right feature (correct has old routine_id and old name)
				if
					l_as.routine_ids /= Void and then
					l_as.routine_ids.has (feature_i.rout_id_set.first) and then
					old_feature_name.is_case_insensitive_equal (l_as.feature_name)
				then
					l_as.feature_name.replace_text (new_feature_name, match_list)
					has_modified := True
				end
			end
			safe_process (l_as.internal_operands)
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_interval_as (l_as: INTERVAL_AS) is
			-- Process interval clause nodes.
		local
			l_atom: ATOMIC_AS
		do
				-- we only have to do this stuff if we are a descendant
			if is_descendant then
				l_atom := l_as.lower
				if l_atom.is_id and then l_atom.string_value.is_case_insensitive_equal (old_feature_name) then
					l_atom.replace_text (new_feature_name, match_list)
				end
				l_atom := l_as.upper
				if l_atom /= Void and then l_atom.is_id and then l_atom.string_value.is_case_insensitive_equal (old_feature_name) then
					l_atom.replace_text (new_feature_name, match_list)
				end
			end
		end


	process_parent_as (l_as: PARENT_AS) is
			-- Process the inherit clause node
		local
			l_id: INTEGER
			l_renamings: EIFFEL_LIST [RENAME_AS]
			l_rename: RENAME_AS
			l_class: CLASS_C
			l_feature: FEATURE_I
			i, count: INTEGER
			l_parent_features: HASH_TABLE [STRING, INTEGER]
			l_name_id: INTEGER
			l_parent_modifier: ERT_PARENT_AS_MODIFIER
		do
				-- we only have to do this stuff if we are a descendant
			if is_descendant then
					-- check if the class we inherit from it a descendant of the class where the feature was changed
				l_class := type_checker.solved_type (l_as.type).associated_class
				l_id := l_class.class_id
				if recursive_descendants.has (l_id) then
						-- with each inherit of a descendant we start with no renaming
					is_renaming := False

						-- handle renaming
					l_renamings := l_as.renaming
					if l_renamings /= Void then
						from
							l_renamings.start
						until
							l_renamings.after
						loop
							l_rename := l_renamings.item
								-- if the feature we change was renamed
							if l_rename.old_name.internal_name_id = feature_i.feature_name_id then
								is_renaming := True
									-- did we rename into the new name?
								if l_rename.new_name.visual_name.is_case_insensitive_equal (new_feature_name) then
										-- => we have to remove the renaming
									create l_parent_modifier.make (l_as, match_list)
									l_parent_modifier.remove ({ERT_PARENT_AS_MODIFIER}.rename_clause, l_renamings.index)
									l_parent_modifier.apply
								else
										-- => we have to change the old name into the changed old name										
									l_rename.old_name.replace_text (new_feature_name, match_list)
								end
								has_modified := True
							end
							l_renamings.forth
						end
					end

						-- handle export, undefine, redefine, select, ...
					safe_process (l_as.internal_exports)
					safe_process (l_as.internal_undefining)
					safe_process (l_as.internal_redefining)
					safe_process (l_as.internal_selecting)
				else
						-- now we have to check if the parent already implemented this features
						-- if so, we have to add/update a rename clause and update select, export, ...
					create l_parent_features.make(1)
					from
						count := rout_id_set.count
						i := 1
					until
						i > count
					loop
						l_feature := l_class.feature_of_rout_id (rout_id_set.item (i))
						if l_feature /= Void then
							l_parent_features.put (l_feature.feature_name, l_feature.feature_name_id)
						end
						i := i + 1
					end

						-- if the parent already has this feature
					if not l_parent_features.is_empty then
							-- handle rename
						l_renamings := l_as.renaming
						if l_renamings /= Void then
							from
								l_renamings.start
							until
								l_renamings.after
							loop
								l_rename := l_renamings.item
									-- if there is already a renaming, update it
								l_name_id := l_rename.old_name.internal_name_id
								if l_parent_features.has (l_name_id) then
									l_rename.new_name.replace_text (new_feature_name, match_list)
									l_parent_features.remove (l_name_id)
								end
								l_renamings.forth
							end
						end
							-- for all the features where we didn't already have a rename, add one
						from
							l_parent_features.start
						until
							l_parent_features.after
						loop
							create l_parent_modifier.make (l_as, match_list)
							l_parent_modifier.extend ({ERT_PARENT_AS_MODIFIER}.rename_clause, l_parent_features.item_for_iteration+" as "+new_feature_name)
							l_parent_modifier.apply
							l_parent_features.forth
						end

							-- handle export, undefine, redefine, select, ...
						safe_process (l_as.internal_exports)
						safe_process (l_as.internal_undefining)
						safe_process (l_as.internal_redefining)
						safe_process (l_as.internal_selecting)
					end
				end
			end
		end

	process_create_as (l_as: CREATE_AS) is
			-- Process create statement.
		do
				-- handle only if we are a descendant and didn't rename
			if is_descendant and then not is_renaming then
				safe_process (l_as.clients)
				safe_process (l_as.feature_list)
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
			-- Process like statements.
		do
			if is_descendant and then not is_renaming then
				if old_feature_name.is_case_insensitive_equal (l_as.anchor) then
					l_as.anchor.replace_text (new_feature_name, match_list)
					has_modified := True
				end
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
			-- Process feature name.
		do
			if old_feature_name.is_case_insensitive_equal (l_as.feature_name) then
				l_as.feature_name.replace_text (new_feature_name, match_list)
				has_modified := True
			end
		end

	process_feature_as (l_as: FEATURE_AS) is
			-- Process feature clauses.
		do
				-- handle feature names only if we didn't rename
			if is_descendant and then not is_renaming
			then
				safe_process (l_as.feature_names)
			end
				-- handle body
			safe_process (l_as.body)
		end

	process_body_as (l_as: BODY_AS) is
			-- Process body part.
		local
			c_as: CONSTANT_AS
		do
			safe_process (l_as.internal_arguments)
			safe_process (l_as.type)

				-- process assigner only if we didn't rename
			if
				is_descendant and not is_renaming
				and l_as.assigner /= Void
				and old_feature_name.is_case_insensitive_equal (l_as.assigner)
			then
				l_as.assigner.replace_text (new_feature_name, match_list)
				has_modified := True
			end

			c_as ?= l_as.content
			if c_as /= Void then
				l_as.content.process (Current)
				safe_process (l_as.indexing_clause)
			else
				safe_process (l_as.indexing_clause)
				safe_process (l_as.content)
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.parameters)
			if recursive_descendants.has (l_as.class_id) then
					-- check if it is the right feature (correct has old routine_id and old name)
				if
					l_as.routine_ids /= Void and then
					l_as.routine_ids.has (feature_i.rout_id_set.first) and then
					old_feature_name.is_case_insensitive_equal (l_as.feature_name)
				then
					l_as.feature_name.replace_text (new_feature_name, match_list)
					has_modified := True
				end
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
			-- Process `l_as'.
		do
			process_access_feat_as (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
			-- Process `l_as'.
		do
			process_access_feat_as (l_as)
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
			-- Process `l_as'.
		do
			process_access_feat_as (l_as)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
			-- Process `l_as'.
		do
			process_access_feat_as (l_as)
		end

	process_address_as (l_as: ADDRESS_AS) is
			-- Process `l_as'.
		do
			if recursive_descendants.has (l_as.class_id) then
					-- check if it is the right feature (correct has old routine_id and old name)
				if
					l_as.routine_ids /= Void and then
					l_as.routine_ids.has (feature_i.rout_id_set.first) and then
					old_feature_name.is_case_insensitive_equal (l_as.feature_name.visual_name)
				then
					l_as.feature_name.replace_text (new_feature_name, match_list)
					has_modified := True
				end
			end
		end


	process_break_as (l_as: BREAK_AS) is
			-- Process breaks which could be comments.
		do
			if change_comments then
				l_as.replace_subtext ("`"+old_feature_name+"'", "`"+new_feature_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end


	process_string_as (l_as: STRING_AS) is
		do
			if change_strings then
				l_as.replace_subtext ("`"+old_feature_name+"'", "`"+new_feature_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if change_strings then
				l_as.replace_subtext ("`"+old_feature_name+"'", "`"+new_feature_name+"'", False, match_list)
				has_modified := True
			end
			Precursor (l_as)
		end


feature {NONE} -- Implementation

	feature_i: FEATURE_I
			-- The feature.

	rout_id_set: ROUT_ID_SET
			-- The routine id set.

	old_feature_name: STRING
			-- Old feature name

	new_feature_name: STRING
			-- New feature name

	change_comments: BOOLEAN
			-- Do we have to change the name in comments?

	change_strings: BOOLEAN
			-- Do we have to change the name in strings?

	recursive_descendants: SEARCH_TABLE [INTEGER]
			-- Table with all the class ids of the descendants (and the class itself) of owner_class.

	is_descendant: BOOLEAN
			-- Is the currently visited class a descendant of the class that changes the feature?

	type_checker: AST_TYPE_CHECKER
			-- Needed to get some type information.

invariant
	feature_i_not_void: feature_i /= Void
	rout_id_set_not_void: rout_id_set /= Void
	old_feature_name_ok: old_feature_name /= Void and not old_feature_name.is_empty
	old_feature_name_lower: old_feature_name.as_lower.is_equal (old_feature_name)
	new_feature_name_ok: new_feature_name /= Void and not new_feature_name.is_empty
	new_feature_name_lower: new_feature_name.as_lower.is_equal (new_feature_name)
	recursive_descendants_not_void: recursive_descendants /= Void
	type_checker_not_void: type_checker /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
