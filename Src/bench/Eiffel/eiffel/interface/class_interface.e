indexing
	description: "Represent a CLI interface representation of an Eiffel class"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_INTERFACE

inherit
	HASHABLE
		rename
			hash_code as class_id
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end
		
create
	make_with_class,
	make_from_context
	
feature {NONE} -- Initialization
	
	make_with_class (a_class: CLASS_C) is
			-- Initialize current with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			class_id := a_class.class_id
			create features.make (Chunk)
			feature_insertion_type := Insert_origin_only_type
		ensure
			class_id_set: class_id = a_class.class_id
		end
		
	make_from_context (other: like Current; cl_type: CLASS_TYPE) is
			-- Initialize current with `other' in context of `class_type.
		require
			other_not_void: other /= Void
			class_type_not_void: cl_type /= Void
			valid_class_type: cl_type.associated_class = other.associated_class
		do
			class_id := other.class_id
			class_type := cl_type
			features := other.features
			feature_insertion_type := Insert_origin_only_type
		ensure
			class_id: class_id = other.class_id
			class_type_set: class_type = cl_type
			parents_not_set: parents = Void
			features_aliased: features = other.features
		end
		
feature -- Access

	class_id: INTEGER
			-- Associated class id of corresponding CLASS_C.

	class_type: CLASS_TYPE
			-- Associated CLASS_TYPE.
			
	parents: SEARCH_TABLE [CLASS_INTERFACE]
			-- List of parent interfaces implemented by current interface.
			
	features: SEARCH_TABLE [INTEGER]
			-- List of features explicitely declared on current interface.
			-- Indexed by `rout_id' of FEATURE_I instance in context
			-- of `associated_class'.

	feature_insertion_type: INTEGER
			-- Level of what will be inserted in class interface definition.

	associated_class: CLASS_C is
			-- Associated class to `class_id'.
		do
			Result := System.class_of_id (class_id)
		ensure
			result_not_void: Result /= Void	
		end

feature -- Status

	is_external: BOOLEAN is
			-- Is current interface defined from an external class.
		do
			Result := associated_class.is_external
		end

feature -- Settings

	set_parents (p: like parents) is
			-- Assign `parents' with `p'.
		require
			p_not_void: p /= Void
		do
			parents := p
		ensure
			parents_set: parents = p
		end

	set_feature_insertion_type (a_type: INTEGER) is
			-- Assign `feature_insertion_type' with `a_type'.
		require
			valid_type: valid_insertion_type (a_type)
		do
			feature_insertion_type := a_type
		ensure
			feature_insertion_type_set: feature_insertion_type = a_type
		end

feature -- Control

	process_features (feat_tbl: FEATURE_TABLE) is
			-- Added `features' into current.
		local
			class_c, parent_class: like associated_class
			feat: FEATURE_I
			l_parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_A
			l_list: SEARCH_TABLE [INTEGER]
			i, id: INTEGER
			par_feats: SPECIAL [SELECT_TABLE]
			l_class_id: INTEGER
		do
			features.wipe_out

			class_c := associated_class
			l_class_id := class_c.class_id

				-- Initialize parent feature tables.
			l_parents := class_c.parents
			from
				create l_list.make (l_parents.count)
				par_feats := (create {ARRAY [SELECT_TABLE]}.make (1, l_parents.count)).area
				i := 0
				l_parents.start
			until
				l_parents.after
			loop
				parent_type := l_parents.item
				id := parent_type.base_class_id
				if not l_list.has (id) then
						-- Do not recheck twice the same parent.
					l_list.force (id)
					parent_class := System.class_of_id (id)
					par_feats.put (parent_class.feature_table.origin_table, i)
					i := i + 1
				end
				l_parents.forth
			end

			from
				feat_tbl.start
			until
				feat_tbl.after
			loop
				feat := feat_tbl.item_for_iteration

					-- Only in the case it is not an IL external feature,
					-- we might be able to make sure the feature is
					-- part of the Current class interface.
				if
					not (feat.is_external and then not feat.is_c_external) and then
					(feat.feature_name_id /= feature {PREDEFINED_NAMES}.Void_name_id)
				then
					compare_with_parent (feat, par_feats)
				end

				feat_tbl.forth
			end
		end

feature -- Constants

	valid_insertion_type (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid insertion type constants?	
		do
			inspect
				a_type
			when
				insert_origin_only_type, insert_renaming_type,
				insert_explicit_covariance_type,
				insert_implicit_covariance_type, insert_all_features_type
			then
				Result := True
			end
		end

	insert_origin_only_type: INTEGER is 1
	insert_renaming_type: INTEGER is 2
	insert_explicit_covariance_type: INTEGER is 3
	insert_implicit_covariance_type: INTEGER is 4
	insert_all_features_type: INTEGER is 5
			-- Type corresponding to which features will be inserted
			-- in current interface.

feature {NONE} -- Implementation

	add_feature (feat: FEATURE_I) is
			-- Add `feat' in list of features implemented by current interface.
		require
			f_not_void: feat /= Void
			valid_f: feat.feature_id > 0
		do
			features.force (feat.rout_id_set.first)
		ensure
			inserted: features.has (feat.rout_id_set.first)
		end

	compare_with_parent (feat: FEATURE_I; p: SPECIAL [SELECT_TABLE]) is
			-- Search for `feat' in `p'. If found with different signature, then
			-- we add it to current.
		require
			feat_not_void: feat /= Void
			p_not_void: p /= Void
			not_is_void_feature: feat.feature_name_id /= feature {PREDEFINED_NAMES}.Void_name_id
		local
			l_feats: SELECT_TABLE
			i, nb, j, count: INTEGER
			l_rout_id_set: ROUT_ID_SET
			l_old_feat: FEATURE_I
			found: BOOLEAN
		do
			if
				feat.is_origin or else
				(feat.is_attribute and then feat.rout_id_set.count > 1
				and then feat.written_in = class_id)
			then
					-- A new introduced feature has to be in the interface.
					-- An attribute that defines an inherited feature has to be
					-- in the interface for attribute assignment.
				add_feature (feat)

					-- Mark feature with origin information.
				feat.set_origin_feature_id (feat.feature_id)

				if feat.written_in = class_id then
					feat.set_written_feature_id (feat.feature_id)
				end

				if feat.is_replicated and feat.is_unselected then
						-- Feature is replicated, we have to
						-- make it believe that it comes from
						-- current even though it is written
						-- in an ancestor class.
					feat.set_origin_class_id (class_id)
				else
					feat.set_origin_class_id (feat.written_in)
				end

				check
					same_class: feat.origin_class_id = class_id
				end
			else
				from
					i := 0
					nb := p.count
					l_rout_id_set := feat.rout_id_set
					if not feat.is_attribute then
							-- We are guarantee to find in parents a feature
							-- with routine id `feat.rout_id_set.first'
						count := 1
					else
							-- This is an attribute. It is possible, that the
							-- attribute is a result of the redefinition of a
							-- function and therefore the attribute gets more
							-- routine ids:
							--  * one for itself
							--  * one or more for the function it implements
						count := l_rout_id_set.count	
					end
				until
					i >= nb or else found
				loop
					l_feats := p.item (i)
					if l_feats /= Void then
						from
							j := 1
						until
							j > count or else found
						loop
							l_old_feat := l_feats.item (l_rout_id_set.item (j))
							if l_old_feat /= Void then
								found := True

								if feat.written_in = class_id then
										-- Feature written in current class which is
										-- not an origin. We need to take information
										-- about its origin from parent feature `l_old_feat'.

										-- Recover info about where feature is defined
										-- for the first time.
									feat.set_origin_feature_id (l_old_feat.origin_feature_id)
									feat.set_origin_class_id (l_old_feat.origin_class_id)

										-- store current `feature_id' as `written_feature_id'.
									feat.set_written_feature_id (feat.feature_id)
								end

								inspect
									feature_insertion_type
								when insert_origin_only_type then
									
								when insert_renaming_type then
									if feat.feature_name_id /= l_old_feat.feature_name_id then
										add_feature (feat)
									end
								when insert_explicit_covariance_type then
								when insert_implicit_covariance_type then
								when insert_all_features_type then
									add_feature (feat)
								end
							end
							j := j + 1
						end
					else
						i := nb
					end
					i := i + 1
				end
				check
					feature_found: found
				end
			end
		end

feature {NONE} -- Implementation: constants

	Chunk: INTEGER is 50
			-- Initial size of containers.

invariant
	valid_class_id: class_id > 0
	features_not_void: features /= Void 
	il_generation: (create {SHARED_WORKBENCH}).System.il_generation
	
end -- class CLASS_INTERFACE
