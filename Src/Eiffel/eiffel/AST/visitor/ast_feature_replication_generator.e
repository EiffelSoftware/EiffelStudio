indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FEATURE_REPLICATION_GENERATOR

inherit
	AST_ITERATOR
		redefine
			process_access_id_as
		end

	SHARED_SERVER

	SHARED_INHERITED
		undefine
			copy, is_equal
		end

feature -- Processing

	process_replicated_feature (a_feature: FEATURE_I; a_parent_c: PARENT_C; a_current_class: CLASS_C; old_t, new_t: FEATURE_TABLE)
			-- Perform processing on replicated feature `a_feature'.
			-- `a_parent_c' may be Void if a replicated feature is redefined.
		require
			a_feature_valid: a_feature /= Void
			a_feature_replicated: a_feature.is_replicated
			a_current_class_not_void: a_current_class /= Void
			a_feature_replicated_in_current_class: not system.has_old_feature_replication implies a_feature.access_in = a_current_class.class_id
		local
			l_feature_as: FEATURE_AS
			l_old_feature: FEATURE_I
			l_body_index: INTEGER
			l_feat_name_id_as: FEAT_NAME_ID_AS
			l_class_as: CLASS_AS
			l_feature_name_id: INTEGER
		do
			feature_i := a_feature
			parent_c := a_parent_c
				-- `parent_c' may be Void if `a_feature' is the result of a redefinition or undefinition.
				-- If this is the case then we don't need to perform any processing as the AST is already at the level of access_in.
			if a_parent_c /= Void then
				l_feature_as := body_server.item (a_feature.body_index)
				a_feature.set_is_origin (False)
					-- We need to perform a deep twin of the feature a.s.
					-- so that there is no aliasing between AST nodes.
				l_feature_as := l_feature_as.deep_twin

				l_feature_name_id := a_feature.feature_name_id

					-- Make sure that the AST refers to the correct feature name.
				create l_feat_name_id_as.initialize (create {ID_AS}.initialize_from_id (l_feature_name_id))
				l_feature_as.feature_names.wipe_out
				l_feature_as.feature_names.extend (l_feat_name_id_as)

					-- Process replicated AST to account for renames within the same inheritance branch.
				process_body_as (l_feature_as.body)

					-- Reuse previous feature information if available if available
				if old_t /= Void then
					l_old_feature := old_t.item_id (l_feature_name_id)
				end

				if l_old_feature /= Void then
					l_body_index := l_old_feature.body_index

						-- Set ID of feature AS to be that of the previous feature.
					l_feature_as.set_id (l_old_feature.body.id)
				else
					l_body_index := System.body_index_counter.next_id
				end

				a_feature.set_body_index (l_body_index)
				tmp_ast_server.body_force (l_feature_as, l_body_index)
				tmp_ast_server.reactivate (l_body_index)

					-- We need to add the replicated feature as to the class as
					-- so that it may be stored to disk for incrementality
					--| FIXME IEK We need a better mechanism for doing this.
				l_class_as := a_current_class.ast
				if l_class_as /= Void then
					if l_class_as.replicated_features = Void then
						l_class_as.set_replicated_features (create {EIFFEL_LIST [FEATURE_AS]}.make (5))
					end
					l_class_as.replicated_features.extend (l_feature_as)
				end

				a_feature.set_has_replicated_ast (True)
				a_feature.set_rout_id_set (a_feature.rout_id_set.twin)

					-- Make sure routine ID of replicated feature gets added for current class
				System.rout_info_table.put (a_feature.rout_id_set.first, a_current_class)

					-- Mark feature as changed so that it gets melted.
				inherit_table.changed_features.extend (a_feature.feature_name_id)
			else
				-- This routine is either joined or redefined in `a_current_class' so no manipulation
				-- needs to take place.
			end
		end

feature -- Access

	feature_i: FEATURE_I
		-- Feature that is currently being processed

	parent_c: PARENT_C
		-- Parent class used for detecting AST manipulation

feature {NONE} -- Implementation

	process_access_id_as (l_as: ACCESS_ID_AS) is
			-- <Precursor>
		local
			l_renaming: RENAMING
			l_feature_name: ID_AS
		do
			l_feature_name := l_as.feature_name
			if parent_c /= Void and then parent_c.is_renaming (l_feature_name.name_id) then
					-- The unqualified routine call to `l_feature_name' is being renamed in the branch so
					-- therefore we need to perform the textual update.
				l_renaming := parent_c.renaming.item (l_feature_name.name_id)
				l_as.set_class_id (System.current_class.class_id)
				debug ("Feature Replication")
					print ("{" + System.current_class.name + "}." + feature_i.feature_name + " is calling " + l_feature_name.name + " when it should be calling " + System.names.item (l_renaming.feature_name_id) + "%N")
				end
				l_feature_name.set_name (l_renaming.names_heap.item (l_renaming.feature_name_id))
			end
			Precursor (l_as)
		end

end
