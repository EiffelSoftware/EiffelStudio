indexing
	description: "[
		Implementation of multiple inheritance by using multiple inheritance
		of interfaces. No simple inheritance of implementation is performed
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_IL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR
		redefine
			make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		do
			Precursor {IL_CODE_GENERATOR}
			create processed_tbl.make (20)
			create rout_ids_tbl.make (50)
		end
		
feature {NONE} -- Access

	rout_ids_tbl: HASH_TABLE [FEATURE_I, INTEGER]
			-- Table of FEATURE_I indexed by routine IDs, to quickly find out
			-- if a FEATURE_I with a given routine ID has already been generated 
			-- in `currrent_class_type'. If so, a MethodImpl is defined on 
			-- generated routine. Otherwise, we have to traverse `current_select_tbl'
			-- to find associated FEATURE_I and generate a new feature.

	processed_tbl: SEARCH_TABLE [INTEGER]
			-- Record CLASS_TYPEs that have been processed regarding inherited
			-- routines. Indexed by `CLASS_TYPE.static_type_id'.

	current_select_tbl: SELECT_TABLE
			-- Current feature table associated with `current_class_type'.

feature -- IL Generation

	generate_il_implementation (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature in `class_c'.
		local
			class_interface: CLASS_INTERFACE
		do
				-- Reset data
			rout_ids_tbl.wipe_out
			processed_tbl.wipe_out
			
				-- We never analyze System.Object.
			processed_tbl.force (System.system_object_class.compiled_class.types.first.static_type_id)
			
				-- Initialization of context.
			class_interface := class_type.class_interface
			current_class_type := class_type
			current_select_tbl := class_c.feature_table.origin_table
			Inst_context.set_cluster (class_c.cluster)
			is_frozen_class := class_c.is_frozen

				-- Generate custom attributes if defined on Eiffel classes
				-- to be generated.
			if not class_c.is_external then
				ast_context.set_current_class (class_c)
				meta_data_generator.generate_class_custom_attribute (class_type)
			end

				-- Initialize implementation.
			if not is_frozen_class then
				implementation.start_features_list (class_type.implementation_id)
			end
			implementation.start_il_generation (class_type.implementation_id)
			meta_data_generator.set_current_class (class_c)
			meta_data_generator.set_current_class_type (class_type)

				-- Generate current features implement locally in `current_class_type'
				-- and traverse parents to define inherited features.
			generate_il_implementation_local (class_interface, class_c, class_type)
			generate_il_implementation_parents (class_interface)
			generate_il_formal_generics (class_c, class_type)
			generate_il_anchors (class_c, class_type)

				-- Reset global variable for collection.
			current_class_type := Void
			current_select_tbl := Void
			rout_ids_tbl.wipe_out
			processed_tbl.wipe_out
		end

	generate_il_formal_generics (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature that represents type of a formal
			-- generic parameter of `class_c'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			l_formals: HASH_TABLE [TYPE_FEATURE_I, INTEGER]
			l_formal: TYPE_FEATURE_I
		do
			l_formals := class_c.generic_features
			if l_formals /= Void then
				from
					l_formals.start
				until
					l_formals.after
				loop
					l_formal := l_formals.item_for_iteration
					meta_data_generator.generate_feature (l_formal, False)
					implementation.generate_type_feature (l_formal.feature_id)
					generate_type_feature (l_formal)
					l_formals.forth
				end
			end
		end

	generate_il_anchors (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate IL code for feature that represents type of a formal
			-- generic parameter of `class_c'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			l_anchors: HASH_TABLE [TYPE_FEATURE_I, INTEGER]
			l_type_feature: TYPE_FEATURE_I
		do
			l_anchors := class_c.anchored_features
			if l_anchors /= Void then
				from
					l_anchors.start
				until
					l_anchors.after
				loop
					l_type_feature := l_anchors.item_for_iteration
					meta_data_generator.generate_feature (l_type_feature, False)
					implementation.generate_type_feature (l_type_feature.feature_id)
					generate_type_feature (l_type_feature)
					l_anchors.forth
				end
			end
		end

	generate_il_implementation_parents (class_interface: CLASS_INTERFACE) is
			-- Generate IL code for feature in `class_c'.
		require
			il_generation_started: il_generation_started
			class_interface_not_void: class_interface /= Void
		local
			parents: SEARCH_TABLE [CLASS_INTERFACE]
			l_interface: CLASS_INTERFACE
			l_cl_type: CLASS_TYPE
		do
			from
				parents := class_interface.parents
				parents.start
			until
				parents.after
			loop
				l_interface := parents.item_for_iteration
				l_cl_type := l_interface.class_type

				if not processed_tbl.has (l_cl_type.static_type_id) then
					processed_tbl.put (l_cl_type.static_type_id)
					generate_il_implementation_inherited (l_interface,
						l_interface.associated_class, l_cl_type)
					generate_il_implementation_parents (l_interface)
				end
				parents.forth
			end
		end

	generate_il_implementation_local
			(class_interface: CLASS_INTERFACE; class_c: CLASS_C;
			class_type: CLASS_TYPE)
		is
			-- Generate IL code for inherited features of `current_class_type'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
			eiffel_class: not class_c.is_external
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
			l_class_id: INTEGER
		do
				-- Generate code
			from
				features := class_interface.features
				select_tbl := class_c.feature_table.origin_table
				l_class_id := current_class_type.type.class_id
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)

				if
					feat.feature_name_id /= feature {PREDEFINED_NAMES}.Void_name_id
					and then (not feat.is_external or else feat.is_c_external)
				then
						-- Generate code for current class only.
					if not feat.is_deferred then
						if feat.written_in = l_class_id or feat.is_attribute then
							generate_local_feature (feat, Void, class_type, False)
							mark_as_treated (feat)
						else
							if feat.is_replicated and feat.is_unselected then
								generate_local_feature (feat, Void, class_type, True)
								mark_as_treated (feat)
							else
									-- Case of local renaming or implicit
									-- covariant redefinition.
								generate_inherited_feature (feat, feat, class_type)
								mark_as_treated (feat)
							end
						end
					else
							-- Nothing to be done here. Parent was deferred and we
							-- are still deferred. It should only happen when
							-- generating a deferred class.
						check
							deferred_classe:
								current_class_type.associated_class.is_deferred
						end
					end
				end
				features.forth
			end

				-- FIXME: Should be removed as this should automatically
				-- done.
				-- Generate `Finalize' from System.Object.			
			feat := select_tbl.item (internal_finalize_rout_id)
			meta_data_generator.generate_feature (feat, True)
			generate_implementation_feature_il (feat.feature_id)
			current_class_type.generate_il_feature (feat)
				-- Generate call to `Finalize' implementation.
			implementation.generate_finalize_feature (feat.feature_id)
		end

	generate_il_implementation_inherited
			(class_interface: CLASS_INTERFACE; class_c: CLASS_C;
			class_type: CLASS_TYPE)
		is
			-- Generate IL code for inherited features of `current_class_type'.
		require
			il_generation_started: il_generation_started
			class_c_not_void: class_c /= Void
			eiffel_class: not class_c.is_external
			class_type_not_void: class_type /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			inh_feat, feat: FEATURE_I
			rout_id, l_class_id: INTEGER
		do
				-- Generate code
			from
				features := class_interface.features
				select_tbl := class_c.feature_table.origin_table
				l_class_id := current_class_type.type.class_id
				features.start
			until
				features.after
			loop
				inh_feat := select_tbl.item (features.item_for_iteration)

				if
					inh_feat.feature_name_id /= feature {PREDEFINED_NAMES}.Void_name_id
					and then (not inh_feat.is_external or else inh_feat.is_c_external)
				then
						-- Generate local definition of `inh_feat' which
						-- calls static definition.
					rout_id := inh_feat.rout_id_set.first
					if rout_ids_tbl.has (rout_id) then
						feat := rout_ids_tbl.found_item
						generate_method_impl (feat.feature_id,
							class_type.static_type_id, inh_feat.feature_id)
					else
						feat := current_select_tbl.item (rout_id)
							-- Generate code for current class only.
						if not feat.is_deferred then
							if feat.written_in = l_class_id or feat.is_attribute then
								generate_local_feature (feat, inh_feat, class_type, False)
								mark_as_treated (feat)
							else
									-- Case of local renaming or implicit
									-- covariant redefinition.
								generate_inherited_feature (feat, inh_feat, class_type)
								mark_as_treated (feat)
							end
						else
								-- Nothing to be done here. Parent was deferred and we
								-- are still deferred. It should only happen when
								-- generating a deferred class.
							check
								deferred_classe:
									current_class_type.associated_class.is_deferred
							end
						end						
					end
				end
				features.forth
			end
		end

	generate_local_feature (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE; is_replicated: BOOLEAN) is
			-- Generate a feature `feat' implemented in `current_class_type', ie
			-- generate encapsulation that calls its static implementation.
		require
			feat_not_void: feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_is_method_impl_generated: BOOLEAN
			dup_feat: FEATURE_I
			proc: PROCEDURE_I
		do
			if feat.rout_id_set.has (internal_duplicate_rout_id) then
				meta_data_generator.generate_feature (feat, False)
				implementation.generate_feature_internal_duplicate (feat.feature_id)
			else
				if not is_frozen_class then
					if not is_replicated then
							-- Generate static definition of `feat'.
						meta_data_generator.generate_feature (feat, True)
						generate_implementation_feature_il (feat.feature_id)
						current_class_type.generate_il_feature (feat)
					end
	
						-- Generate local definition of `feat' which
						-- calls static definition.
					if inh_feat /= Void then
						l_is_method_impl_generated :=
							feat.feature_name_id /= inh_feat.feature_name_id
						if not l_is_method_impl_generated then
								-- Generate local definition signature using the parent
								-- signature. We do not do it on the parent itself because
								-- its `feature_id' is not appropriate in `current_class_type'.
							Byte_context.set_class_type (class_type)
							dup_feat := feat.duplicate
							if dup_feat.is_procedure then
								proc ?= dup_feat
								proc.set_arguments (inh_feat.arguments)
							end
							dup_feat.set_type (inh_feat.type)
							meta_data_generator.generate_feature (dup_feat, False)
							Byte_context.set_class_type (current_class_type)
						else
							meta_data_generator.generate_feature (feat, False)
						end
					else
						meta_data_generator.generate_feature (feat, False)
					end


					if not is_replicated then
							-- We call locally above generated static feature
						generate_feature_il (feat.feature_id,
							current_class_type.implementation_id,
							feat.feature_id)
					else
							-- We call static feature corresponding to current replicated feature.
							-- This static feature is defined in parent which explains the search
							-- made below to find in which parent's type.
						generate_feature_il (feat.feature_id,
							implemented_type (feat.written_in,
								current_class_type.type).associated_class_type.implementation_id,
							feat.written_feature_id)
					end
				else
					generate_implementation_feature_il (feat.feature_id)
					current_class_type.generate_il_feature (feat)
				end

			end
			if l_is_method_impl_generated then
					-- We need a MethodImpl here for mapping
					-- inherited method to current defined one.
				generate_method_impl (feat.feature_id,
					class_type.static_type_id, inh_feat.feature_id)
			end
		end

	generate_inherited_feature (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE) is
			-- Generate a feature `feat' implemented in `class_type', ie generate
			-- encapsulation that calls its static implementation,
			-- otherwise parent implementation.
		require
			feat_not_void: feat /= Void
			inh_feat_not_void: inh_feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_is_method_impl_generated: BOOLEAN
			dup_feat: FEATURE_I
			proc: PROCEDURE_I
		do
			if not is_frozen_class then 
				if inh_feat /= Void then
					l_is_method_impl_generated := feat.feature_name_id /= inh_feat.feature_name_id
					if not l_is_method_impl_generated then
							-- Generate local definition signature using the parent
							-- signature. We do not do it on the parent itself because
							-- its `feature_id' is not appropriate in `current_class_type'.
						Byte_context.set_class_type (class_type)
						dup_feat := feat.duplicate
						if dup_feat.is_procedure then
							proc ?= dup_feat
							proc.set_arguments (inh_feat.arguments)
						end
						dup_feat.set_type (inh_feat.type)
						meta_data_generator.generate_feature (dup_feat, False)
						Byte_context.set_class_type (current_class_type)
					else
						meta_data_generator.generate_feature (feat, False)
					end
				else
					meta_data_generator.generate_feature (feat, False)
				end
			end

			if feat.feature_name_id = feature {PREDEFINED_NAMES}.Internal_duplicate_name_id then
				implementation.generate_feature_internal_duplicate (feat.feature_id)
			else
				generate_feature_il (feat.feature_id,
					implemented_type (feat.written_in,
						current_class_type.type).associated_class_type.implementation_id,
					feat.written_feature_id)
			end

				-- We need a MethodImpl here for mapping
				-- inherited method to current defined one.
			if l_is_method_impl_generated then
				generate_method_impl (feat.feature_id,
					class_type.static_type_id, inh_feat.feature_id)
			end
		end

	mark_as_treated (feat: FEATURE_I) is
			-- Add `feat' to `rout_ids_tbl' for each routine ID in `rout_id_set' of `feat'.
		local
			rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
		do
			from
				rout_id_set := feat.rout_id_set
				i := 1
				nb := rout_id_set.count
			until
				i > nb
			loop
				check
					not rout_ids_tbl.has (rout_id_set.item (i))
				end
				rout_ids_tbl.put (feat, rout_id_set.item (i))
				i := i + 1
			end
		end


end -- class INTERFACE_IL_CODE_GENERATOR
