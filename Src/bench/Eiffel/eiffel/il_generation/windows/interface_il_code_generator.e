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
	CIL_CODE_GENERATOR
		redefine
			make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize generator.
		do
			Precursor {CIL_CODE_GENERATOR}
			create processed_tbl.make (20)
			create rout_ids_tbl.make (50)
		end
		
feature {NONE} -- Access

	is_single_inheritance_implementation: BOOLEAN is False
			-- Multiple interface code generation.

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
			
				-- Initialization of context.
			class_interface := class_type.class_interface
			current_class_type := class_type
			current_select_tbl := class_c.feature_table.origin_table
			Inst_context.set_cluster (class_c.cluster)
			is_single_class := class_type.is_generated_as_single_type

				-- Initialize implementation.
			set_current_class (class_c)
			set_current_class_type (class_type)
			set_current_type_id (class_type.implementation_id)
			current_class_token := actual_class_type_token (current_type_id)


			if not is_single_class then
					-- Clean IL recorded information
				clean_debug_information (class_type)
			end

				-- First generate anchored features as they might be needed by current class
				-- features for code generation when current class is frozen.
			generate_il_type_features (class_c, class_type, class_c.generic_features)
			generate_il_type_features (class_c, class_type, class_c.anchored_features)

				-- Generate current features implement locally in `current_class_type'
				-- and traverse parents to define inherited features.
			generate_il_implementation_local (class_interface, class_c, class_type)
			generate_il_implementation_parents (class_interface)

			if not is_single_class then
					-- Generate class invariant and internal run-time features
				generate_class_features (class_c, class_type)
					-- Generate default constructor
				define_default_constructor (class_type, False)
			end

				-- Reset global variable for collection.
			current_class_type := Void
			current_select_tbl := Void
			rout_ids_tbl.wipe_out
			processed_tbl.wipe_out
			
				-- Clean useless data
			if not is_single_class then
				clean_implementation_class_data
			end
		end

	generate_il_type_features (class_c: CLASS_C; class_type: CLASS_TYPE;
			type_features: HASH_TABLE [TYPE_FEATURE_I, INTEGER]) 
		is
			-- Generate IL code for feature that represents type information of `class_c'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			l_formal: TYPE_FEATURE_I
		do
			if type_features /= Void then
				if not is_single_class then
					from
						type_features.start
					until
						type_features.after
					loop
						l_formal := type_features.item_for_iteration
						generate_feature (l_formal, False, False, False)
						type_features.forth
					end
				end

				from
					type_features.start
				until
					type_features.after
				loop
					l_formal := type_features.item_for_iteration
					generate_type_feature (l_formal)
					type_features.forth
				end
			end
		end

	generate_il_implementation_parents (class_interface: CLASS_INTERFACE) is
			-- Generate IL code for feature in `class_c'.
		require
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
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
			not_external_class_type: not class_type.is_external
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
								-- Case of local renaming or implicit covariant redefinition.
							generate_inherited_feature (feat, Void, class_type)
							mark_as_treated (feat)
						end
					end
				else
						-- Nothing to be done here. Parent was deferred and we
						-- are still deferred. It should only happen when
						-- generating a deferred class.
					check
						deferred_class:
							current_class_type.associated_class.is_deferred
					end
				end
				features.forth
			end
		end

	generate_il_implementation_inherited
			(class_interface: CLASS_INTERFACE; class_c: CLASS_C;
			class_type: CLASS_TYPE)
		is
			-- Generate IL code for inherited features of `current_class_type'.
		require
			class_c_not_void: class_c /= Void
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

					-- Generate local definition of `inh_feat' which
					-- calls static definition.
				rout_id := inh_feat.rout_id_set.first
				if rout_ids_tbl.has (rout_id) then
					feat := rout_ids_tbl.found_item
					generate_method_impl (feat, class_type, inh_feat)
				else
					feat := current_select_tbl.item (rout_id)
						-- Generate code for current class only.
					if
						feat /= Void and then
						not feat.is_deferred and then not feat.is_il_external
					then
						if feat.written_in = l_class_id or feat.is_attribute then
							generate_local_feature (feat, inh_feat, class_type, False)
							mark_as_treated (feat)
						else
								-- Case of local renaming or implicit covariant redefinition.
								-- Except that we do not generate redefinition of `finalize'
								-- from SYSTEM_OBJECT in ANY if `current_class' does not
								-- conform to DISPOSABLE. This enables a speed up by about
								-- 30/40% at execution time because .NET GC really slows down
								-- when you define `Finalize' in a descendant of SYSTEM_OBJECT.
							if
								not feat.rout_id_set.has (System.object_finalize_id) 
								or else System.disposable_descendants.has (current_class)
							then
								generate_inherited_feature (feat, inh_feat, class_type)
								mark_as_treated (feat)
							end
						end
					else
							-- Nothing to be done here. Parent was deferred and we
							-- are still deferred. It should only happen when
							-- generating a deferred class.
						check
							deferred_class:
								current_class_type.associated_class.is_deferred or else
									inh_feat.is_il_external or else
									(feat = Void or else feat.is_il_external)
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
			if feat.rout_id_set.has (standard_twin_rout_id) then
				generate_feature (feat, False, False, False)
				generate_feature_standard_twin (feat)
			else
				if not is_single_class then
					if not is_replicated or else feat.is_once then
							-- Generate static definition of `feat'.
						generate_feature (feat, False, True, False)
						generate_feature_code (feat)
					end
	
						-- Generate local definition of `feat' which
						-- calls static definition.
					if inh_feat /= Void then
						l_is_method_impl_generated := is_method_impl_needed (feat, inh_feat,
							class_type)
						if not l_is_method_impl_generated then
								-- Generate local definition signature using the parent
								-- signature. We do not do it on the parent itself because
								-- its `feature_id' is not appropriate in `current_class_type'.
							Byte_context.set_class_type (class_type)
							dup_feat := feat.duplicate
							if dup_feat.is_routine then
								proc ?= dup_feat
								proc.set_arguments (inh_feat.arguments)
							end
							dup_feat.set_type (inh_feat.type)
							generate_feature (dup_feat, False, False, False)
							Byte_context.set_class_type (current_class_type)
						else
							generate_feature (feat, False, False, False)
						end
					else
						generate_feature (feat, False, False, False)
					end


					if not is_replicated or else feat.is_once then
							-- We call locally above generated static feature
						generate_feature_il (feat,
							current_class_type.implementation_id,
							feat.feature_id)
					else
							-- We call static feature corresponding to current replicated feature.
							-- This static feature is defined in parent which explains the search
							-- made below to find in which parent's type.
						generate_feature_il (feat,
							implemented_type (feat.written_in,
							current_class_type.type).associated_class_type.implementation_id,
							feat.written_feature_id)
					end
				else
					if inh_feat /= Void then
						generate_feature (feat, False, False, False)
						if is_method_impl_needed (feat, inh_feat, class_type) then
 							generate_method_impl (feat, class_type, inh_feat)
						else
							if
								not signatures (current_type_id, feat.feature_id).is_equal (
									signatures (class_type.static_type_id, inh_feat.feature_id))
							then
 								generate_method_impl (feat, class_type, inh_feat)
							end
						end
 					end
					if feat.is_c_external then
						if not is_replicated then
							generate_feature (feat, False, True, True)
							generate_external_il (feat)
						else
							generate_feature_il (feat,
								implemented_type (feat.written_in,
								current_class_type.type).associated_class_type.implementation_id,
								feat.written_feature_id)
						end
					else
						generate_feature_code (feat)
					end
				end
				if l_is_method_impl_generated then
						-- We need a MethodImpl here for mapping
						-- inherited method to current defined one.
					generate_method_impl (feat, class_type, inh_feat)
				end
			end
		end

	generate_inherited_feature (feat, inh_feat: FEATURE_I; class_type: CLASS_TYPE) is
			-- Generate a feature `feat' implemented in `class_type', ie generate
			-- encapsulation that calls its static implementation,
			-- otherwise parent implementation.
		require
			feat_not_void: feat /= Void
			class_type_not_void: class_type /= Void
		local
			l_is_method_impl_generated: BOOLEAN
			dup_feat: FEATURE_I
			proc: PROCEDURE_I
			implementation_class_id: INTEGER
			implementation_feature_id: INTEGER
		do
			if not is_single_class or inh_feat /= Void then
				if inh_feat /= Void then
					l_is_method_impl_generated := is_method_impl_needed (feat, inh_feat, class_type)
					if not l_is_method_impl_generated then
							-- Generate local definition signature using the parent
							-- signature. We do not do it on the parent itself because
							-- its `feature_id' is not appropriate in `current_class_type'.
						Byte_context.set_class_type (class_type)
						dup_feat := feat.duplicate
						if dup_feat.is_routine then
							proc ?= dup_feat
							proc.set_arguments (inh_feat.arguments)
						end
						dup_feat.set_type (inh_feat.type)
						generate_feature (dup_feat, False, False, False)
						Byte_context.set_class_type (current_class_type)
					else
						generate_feature (feat, False, False, False)
					end
				else
					generate_feature (feat, False, False, False)
				end

				if feat.rout_id_set.has (standard_twin_rout_id) then
					generate_feature_standard_twin (feat)
				else
					if feat.is_once then
						implementation_class_id := feat.access_in
						implementation_feature_id := system.class_of_id (implementation_class_id).feature_table.feature_of_rout_id_set (feat.rout_id_set).feature_id
					else
						implementation_class_id := feat.written_in
						implementation_feature_id := feat.written_feature_id
					end
					generate_feature_il (feat,
						implemented_type (implementation_class_id, current_class_type.type).implementation_id,
						implementation_feature_id)
				end

					-- We need a MethodImpl here for mapping
					-- inherited method to current defined one.
				if l_is_method_impl_generated then
					generate_method_impl (feat, class_type, inh_feat)
				end
			else
				check
					valid: is_single_class and then inh_feat = Void
				end
				generate_feature_il (feat,
					implemented_type (feat.written_in,
						current_class_type.type).associated_class_type.implementation_id,
						feat.written_feature_id)
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
