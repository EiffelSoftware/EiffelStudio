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
			
	features: SEARCH_TABLE [FEATURE_INFO]
			-- List of features explicitely declared on current interface.
			-- Indexed by `feature_id' of FEATURE_I instance in context
			-- of `associated_class'.

	associated_class: CLASS_C is
			-- Associated class to `class_id'.
		do
			Result := System.class_of_id (class_id)
		ensure
			result_not_void: Result /= Void	
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
			par_types: SPECIAL [CL_TYPE_A]
			feats: SELECT_TABLE
			l_class_id: INTEGER
		do
			features.wipe_out

			class_c := associated_class
			l_class_id := class_c.class_id
			feats := feat_tbl.origin_table

				-- Initialize parent feature tables.
			l_parents := class_c.parents
			from
				create l_list.make (l_parents.count)
				par_feats := (create {ARRAY [SELECT_TABLE]}.make (1, l_parents.count)).area
				par_types := (create {ARRAY [CL_TYPE_A]}.make (1, l_parents.count)).area
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
					par_types.put (parent_class.actual_type, i)
				end
				l_parents.forth
			end

			from
				feats.start
			until
				feats.after
			loop
				feat := feats.item_for_iteration
				if not (feat.is_external and then not feat.is_c_external) then
-- FIXME: Manu 10/24/2001: we should try to avoid to define all features
-- in interfaces, but we cannot do it easily at the moment.
-- 				if feat.is_origin or feat.written_in = l_class_id then
					add_feature (feat)
-- 				else
-- 					compare_with_parent (feat, par_feats, par_types)
-- 				end
				end
				feats.forth
			end
		end

feature {NONE} -- Implementation

	add_feature (feat: FEATURE_I) is
			-- Add `feat' in list of features implemented by current interface.
		require
			f_not_void: feat /= Void
			valid_f: feat.feature_id > 0
		local
			f_info: FEATURE_INFO
		do
			feat.set_implemented_in (class_id)
			create f_info.make (feat, associated_class)
			features.force (f_info)
		ensure
			inserted: features.has (create {FEATURE_INFO}.make (feat, associated_class))
		end
	
	compare_with_parent (feat: FEATURE_I; p: SPECIAL [SELECT_TABLE]; p_types: SPECIAL [CL_TYPE_A]) is
			-- Search for `feat' in `p'. If found with different signature, then
			-- we add it to current.
		local
			l_feats: SELECT_TABLE
			i, nb, j, count: INTEGER
			l_rout_id_set: ROUT_ID_SET
			l_old_feat: FEATURE_I
			found: BOOLEAN
			written_type, original_type: CL_TYPE_A
		do
			from
				written_type := associated_class.actual_type
				i := 0
				nb := p.count
				l_rout_id_set := feat.rout_id_set
				count := l_rout_id_set.count
			until
				i >= nb or else found
			loop
				l_feats := p.item (i)
				original_type := p_types.item (i)
				if l_feats /= Void then
					from
						j := 1
					until
						j > count or else found
					loop
						l_old_feat := l_feats.item (l_rout_id_set.item (j))
						if
							l_old_feat /= Void and then
							(not feat.has_same_il_signature (original_type, written_type, l_old_feat) or
							feat.feature_name_id /= l_old_feat.feature_name_id)
						then
							add_feature (feat)
							found := True
						end
						j := j + 1
					end
				else
					i := nb
				end
				i := i + 1
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
