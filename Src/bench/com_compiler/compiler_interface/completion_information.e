indexing
	description: "[
					Complete given target in given class and feature.
					If the target ends with a '.', give list of possible
					features.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_INFORMATION

inherit
	IEIFFEL_COMPLETION_INFO_IMPL_STUB
		redefine
			target_features,
			target_feature,
			add_local,
			add_argument,
			flush_completion_features,
			flush_completion_features_user_precondition,
			initialize_feature,
			initialize_feature_user_precondition
		end

	SHARED_EIFFEL_PROJECT

	SHARED_NAMES_HEAP
	
	COMPILER_EXPORTER
	
	SHARED_EVALUATOR

	SHARED_INST_CONTEXT
	
	SHARED_EIFFEL_PARSER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize info
		do
			create locals.make (10)
			create arguments.make (5)
			create completion_features.make (5)
			set_standard_call
		end

feature -- Access

	target_feature (target: STRING; feature_name: STRING; file_name: STRING): FEATURE_DESCRIPTOR is
			-- Feature information
			-- `target' [in].
			-- `feature_name' [in].
			-- `file_name' [in].
		local
			ci: CLASS_I
			fi: FEATURE_I
			feature_table: FEATURE_TABLE
			targets: LIST [STRING]
			retried: BOOLEAN
			lookup_name: STRING
			target_type: TYPE
			ids: HASH_TABLE [TYPE, STRING]
			cf: COMPLETION_FEATURE
		do
			if not retried then
				ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
				targets := target.split ('.')
				if targets.last.is_empty then
					targets.finish
					targets.remove
				end
				if ci /= Void and then ci.compiled and then ci.compiled_class.has_feature_table then
					qualified_call := False
					class_i := ci
					feature_table := ci.compiled_class.feature_table
					fi := feature_table.item (feature_name)
					Inst_context.set_cluster (ci.cluster)
					if fi = Void then
						cf := completion_feature (feature_name, file_name)
						if cf /= Void then
							fi := feature_i_from_completion_feature (cf)
						end
					end
					if fi /= Void then
						if targets.count = 1 then
							feature_table.search (targets.first)
							if feature_table.found then
								create Result.make_with_class_i_and_feature_i (ci, feature_table.found_item)
							end
							if Result = Void then
								Result := completion_feature (target, file_name)
							end
						else
							targets.finish
							lookup_name := targets.item
							targets.remove
							ids := feature_variables (fi, feature_table)
							ids.search (targets.first)
							if ids.found then
								target_type := ids.found_item
							else
								feature_table.search (targets.first)
								if feature_table.found then
									target_type := feature_table.found_item.type
								end
							end
							if target_type = Void then
								cf := completion_feature (targets.first, file_name)
								if cf /= Void then
									target_type := type_from_type_name (cf.return_type)
								end
							end
							if target_type /= Void and then not target_type.is_void then
								targets.start
								targets.remove
								feature_table := recursive_lookup (target_type, targets)
								if feature_table /= Void then
									feature_table.search (lookup_name)
									if feature_table.found then
										create Result.make_with_class_i_and_feature_i (class_i, feature_table.found_item)
									end
								end
							end
						end
					end
				else
					-- if there is no compiled class then only complete for current class calls
					cf := completion_feature (targets.first, file_name)
					if cf /= Void then
						if targets.count = 1 then
							Result := cf
							-- need implementation in parser.y to retrieve current class before this code can be used
--						else
--							target_type := type_from_type_name (cf.return_type)
--							if target_type /= Void and then not target_type.is_void then
--								targets.start
--								targets.remove
--								feature_table := recursive_lookup (target_type, targets)
--								if feature_table /= Void then
--									feature_table.search (lookup_name)
--									if feature_table.found then
--										create Result.make_with_class_i_and_feature_i (create {CLASS_I}.make ("ANY"), feature_table.found_item)
--									end
--								end
--							end
						end
					end
				end
			end
			locals.wipe_out
			arguments.wipe_out
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty
		rescue
			retried := True
			retry
		end

	target_features (target, feature_name, file_name: STRING; return_names, return_signatures, return_image_indexes: ECOM_VARIANT) is
			-- Features accessible from target.
			-- `target' [in].
			-- `feature_name' [in].
			-- `file_name' [in].
			-- `return_names' [out].
			-- `return_signatures' [out].
			-- `return_image_indexes' [out].
		local
			l_entries: like completion_list_for_target
			l_entry: COMPLETION_ENTRY
			l_feature_descriptor: FEATURE_DESCRIPTOR
			l_index: INTEGER
			l_bool_ref: BOOLEAN_REF
			l_names: ECOM_ARRAY [STRING]
			l_signatures: ECOM_ARRAY [STRING]
			l_image_indexes: ECOM_ARRAY [INTEGER]
			l_image_index_enum: ECOM_TAG_EIF_ENTITY_IMAGES_ENUM
			l_image_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				create l_image_index_enum
				l_entries := completion_list_for_target (target, feature_name, file_name)
				if l_entries /= Void then
					create l_names.make (1, <<1>>, <<l_entries.count>>)
					create l_signatures.make (1, <<1>>, <<l_entries.count>>)
					create l_image_indexes.make (1, <<1>>, <<l_entries.count>>)
					
					from 
						l_index := 1
					until
						l_index > l_entries.count
					loop
						l_entry := l_entries.i_th (l_index)
						l_names.put (clone (l_entry.name), <<l_index>>)
						l_signatures.put (clone (l_entry.signature), <<l_index>>)
		
						create l_bool_ref
						l_entry.is_feature (l_bool_ref)
						if l_bool_ref.item then
							l_feature_descriptor ?= l_entry
							if l_feature_descriptor /= Void then
								if l_feature_descriptor.is_constant or l_feature_descriptor.is_unique then
									l_image_index := l_image_index_enum.Eif_entity_images_frozen_once
								elseif l_feature_descriptor.is_attribute then
									if l_feature_descriptor.is_obsolete then
										l_image_index := l_image_index_enum.Eif_entity_images_obsolete
									elseif l_feature_descriptor.is_frozen then
										l_image_index := l_image_index_enum.Eif_entity_images_frozen_attribute
									else
										l_image_index := l_image_index_enum.Eif_entity_images_attribute
									end
								elseif l_feature_descriptor.is_once then
									if l_feature_descriptor.is_obsolete then
										l_image_index := l_image_index_enum.Eif_entity_images_obsolete
									elseif l_feature_descriptor.is_frozen then
										l_image_index := l_image_index_enum.Eif_entity_images_frozen_attribute
									else
										l_image_index := l_image_index_enum.Eif_entity_images_once
									end
								elseif l_feature_descriptor.is_obsolete then
									l_image_index := l_image_index_enum.Eif_entity_images_obsolete
								elseif l_feature_descriptor.is_frozen and l_feature_descriptor.is_external then
									l_image_index := l_image_index_enum.Eif_entity_images_frozen_external
								elseif l_feature_descriptor.is_frozen then
									l_image_index := l_image_index_enum.Eif_entity_images_frozen_feature
								elseif l_feature_descriptor.is_external then
									l_image_index := l_image_index_enum.Eif_entity_images_external_feature
								elseif l_feature_descriptor.is_deferred then
									l_image_index := l_image_index_enum.Eif_entity_images_deferred
								else
									l_image_index := l_image_index_enum.Eif_entity_images_feature
								end
							else
								l_image_index := l_image_index_enum.Eif_entity_images_variable
							end
						else
							l_image_index := l_image_index_enum.Eif_entity_images_variable
						end
						l_image_indexes.put (l_image_index, <<l_index>>)
						l_index := l_index + 1
					end
				else
					create l_names.make_empty
					create l_signatures.make_empty
					create l_image_indexes.make_empty
				end
			else
				create l_names.make_empty
				create l_signatures.make_empty
				create l_image_indexes.make_empty
			end
			return_names.set_string_array (l_names)
			return_signatures.set_string_array (l_signatures)
			return_image_indexes.set_integer_array (l_image_indexes)
		ensure
			non_void_names: return_names /= Void
			non_void_signatures: return_signatures /= Void
			non_void_image_indexes: return_image_indexes /= Void
		rescue
			retried := True
			retry
		end
		
feature -- Basic Operations

		add_local (name: STRING; type: STRING) is
				-- Add local variable used for solving member completion list.
			local
				l_name: STRING
			do
				if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not locals.has (name) then
					l_name := clone (name)
					l_name.to_lower
					locals.put (l_name, type)
				end
			end

		add_argument (name: STRING; type: STRING) is
				-- Add argument used for solving member completion list.
			local
				l_name: STRING
			do
				if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not arguments.has (name) then
					l_name := clone (name)
					l_name.to_lower
					arguments.put (l_name, type)
				end
			end	
			
		flush_completion_features (a_file_name: STRING) is
				-- clear all `completion_features' in `a_file_name'
			require else
				non_void_file_name: a_file_name /= Void
				valid_file_name: not a_file_name.is_empty
			local
				l_file_name: STRING
			do
				l_file_name := clone (a_file_name)
				l_file_name.to_lower
				from
					completion_features.start
				until
					completion_features.after
				loop
					if completion_features.item.file_name.is_equal (l_file_name) then
						completion_features.remove
					else
						completion_features.forth
					end
				end
			end
		
		initialize_feature (a_name: STRING; a_arguments: ECOM_VARIANT; a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING) is
				-- Initialize a feature for completion without compltation
			require else
				non_void_name: a_name /= Void
				valid_name: not a_name.is_empty
				non_void_file_name: a_file_name /= Void
				valid_file_name: not a_file_name.is_empty
				valid_arguments: a_arguments /= Void implies a_arguments.string_array /= Void
				valid_argument_types: a_argument_types /= Void implies a_argument_types.string_array /= Void
				matching_argument_count: (a_arguments /= Void and a_argument_types /= Void) implies a_arguments.string_array.count = a_argument_types.string_array.count
			local
				l_feature: COMPLETION_FEATURE
				l_ci: CLASS_I
				l_fi: FEATURE_I
				l_arguments: ARRAYED_LIST [PARAMETER_DESCRIPTOR]
				l_ecom_arguments: ECOM_ARRAY [STRING]
				l_ecom_types: ECOM_ARRAY [STRING]
				l_index: INTEGER
				l_upper_bound: INTEGER
			do
				if a_name /= Void and a_file_name /= Void and then not a_name.is_empty and then not a_file_name.is_empty then
					l_ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (a_file_name))
					if l_ci /= Void then
						if l_ci.compiled_class /= Void and then l_ci.compiled_class.has_feature_table then
							l_fi := l_ci.compiled_class.feature_table.item (a_name)
						end
					end
					if l_fi = Void then
						if a_arguments /= Void and a_argument_types /= Void then
							l_ecom_arguments := a_arguments.string_array
							l_ecom_types :=	a_argument_types.string_array
						end
						if l_ecom_arguments /= Void and l_ecom_types/= Void and then l_ecom_arguments.count > 0 and then l_ecom_types.count > 0 then
							create l_arguments.make (l_ecom_arguments.count)
							from
								l_index := l_ecom_arguments.lower_indices.item (1)
								l_upper_bound := l_ecom_arguments.upper_indices.item (1)
							until
								l_index > l_upper_bound
							loop
								l_arguments.extend (create {PARAMETER_DESCRIPTOR}.make (l_ecom_arguments.item (<<l_index>>), l_ecom_types.item (<<l_index>>)))
								l_index := l_index + 1
							end
						end
						if a_return_type = Void then
							create l_feature.make (a_name, l_arguments, a_feature_type, a_file_name)
						else
							create l_feature.make_with_return_type (a_name, l_arguments, a_return_type, a_feature_type, a_file_name)
						end
						completion_features.extend (l_feature)							
					end
				end
			end
			
		flush_completion_features_user_precondition (a_file_name: STRING): BOOLEAN is
			do
				Result := False
			end
			
		initialize_feature_user_precondition (a_name: STRING; a_arguments, a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING): BOOLEAN is
			do
				Result := False
			end
			

feature {NONE} -- Implementation

	completion_list_for_target (a_target: STRING; feature_name: STRING; file_name: STRING): ARRAYED_LIST [COMPLETION_ENTRY] is
			-- Features accessible from target.
		local
			ci: CLASS_I
			fi: FEATURE_I
			ids: HASH_TABLE [TYPE, STRING]
			targets: LIST [STRING]
			target_type: TYPE
			feature_table: FEATURE_TABLE
			i, old_count: INTEGER
			variable_list: SORTABLE_ARRAY [COMPLETION_ENTRY]
			retried: BOOLEAN
			features: SORTABLE_ARRAY [FEATURE_DESCRIPTOR]
			cf: COMPLETION_FEATURE
			target: STRING
		do
			if not retried then
				ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
				if ci /= Void and then ci.compiled and then ci.compiled_class.has_feature_table then
					class_i := ci
					feature_table := ci.compiled_class.feature_table
					fi := feature_table.item (feature_name)
					Inst_context.set_cluster (ci.cluster)
					if fi = Void then
						cf := completion_feature (feature_name, file_name)
						if cf /= Void then
							fi := feature_i_from_completion_feature (cf)	
						end
					end
					if fi /= Void then
						target := clone (a_target)
						target.to_lower
						ids := feature_variables (fi, feature_table)
						if target.occurrences ('.') = 0 then
							create variable_list.make (1, ids.count + completion_features.count)
							from
								ids.start
								i := 1
							until
								ids.after
							loop
								variable_list.put (create {VARIABLE_DESCRIPTOR}.make (ids.key_for_iteration, ids.key_for_iteration + ": " + ids.item_for_iteration.dump), i)
								i := i + 1									
								ids.forth
							end
							from
								completion_features.start
							until
								completion_features.after
							loop
								variable_list.put (completion_features.item, i)
								i := i + 1
								completion_features.forth
							end
							
							features := features_list_from_table (feature_table)
							old_count := variable_list.count
							variable_list.resize (1, old_count + features.count)
							variable_list.subcopy (features, 1, features.count, old_count + 1)
							variable_list.sort
							create Result.make_from_array (variable_list)
						else
							qualified_call := True
							targets := target.split ('.')
							if targets.last.is_empty then
								targets.finish
								targets.remove
							end
							ids.search (targets.first)
							if ids.found then
								target_type := ids.found_item
								set_standard_call
							else
								feature_table.search (targets.first)
								if feature_table.found then
									set_standard_call
									target_type := feature_table.found_item.type
								else
									target_type := type_of_target (targets.first, feature_table, ids)
								end
							end
							if target_type = Void then
								cf := completion_feature (targets.first, file_name)
								if cf /= Void then
									target_type := type_from_type_name (cf.return_type)	
								end
							end
							if target_type /= Void and then not target_type.is_void then
								targets.start
								targets.remove
								feature_table := recursive_lookup (target_type, targets)
								if feature_table /= Void then
									create Result.make_from_array (features_list_from_table (feature_table))
								end
							end
						end
					end
				end
			end
			locals.wipe_out
			arguments.wipe_out
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty
		rescue
			retried := True
			retry
		end

	recursive_lookup (target_type: TYPE; targets: LIST [STRING]): FEATURE_TABLE is
			-- Available features after resolution of `targets' in `target_type'
		require
			non_void_target_type : target_type /= Void
			non_void_targers: targets /= Void
		local
			feature_table: FEATURE_TABLE
			cl_type: CL_TYPE_A
			a_type: TYPE
		do
			cl_type ?= target_type.actual_type
			if cl_type /= Void then
				feature_table := cl_type.associated_class.feature_table
			end
			if feature_table /= Void then
				if targets.is_empty then
					Result := feature_table
				else
					--set_standard_call -- Complete with all features
					feature_table.search (targets.first)
					if feature_table.found then
						a_type := feature_table.found_item.type
					end
					if a_type /= Void then 
						if not a_type.is_void then
							targets.start
							targets.remove
							Result := recursive_lookup (a_type, targets)
						else
							if not qualified_call then
								Result := feature_table
							end
						end
					else
						Result := feature_table
					end					
				end
			end
		end

	features_list_from_table (table: FEATURE_TABLE): SORTABLE_ARRAY [FEATURE_DESCRIPTOR] is
			-- Convert `table' into an instance of LIST [FEATURE_DESCRIPTOR].
		require
			non_void_table: table /= Void
		local
			ci: CLASS_I
			i: INTEGER
			fi: FEATURE_I
		do
			ci := table.associated_class.lace_class
			if ci /= Void then
				create Result.make (1, table.count)
				from
					i := 1
					table.start
				until
					table.after
				loop
					fi := table.item_for_iteration
					if is_listed (fi, ci) then
						Result.put (create {FEATURE_DESCRIPTOR}.make_with_class_i_and_feature_i (ci, fi), i)
						i := i + 1
					end
					table.forth
				end
				if Result.index_set.valid_index (i - 1) then
					Result := Result.subarray (1, i - 1)
					Result.sort	
				else
					Result := Void
				end
			else
				create Result.make (1,0)
			end
		end
	
	is_listed (fi: FEATURE_I; context: CLASS_I): BOOLEAN is
			-- Should `fi' be listed in member completion list?
		require
			non_void_class_i: class_i /= Void
			valid_class_i: class_i.compiled
		do
			if call_type = Standard_call or call_type = Precursor_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							fi.is_exported_for (class_i.compiled_class)
			elseif call_type = Static_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							fi.has_static_access and
							fi.is_exported_for (class_i.compiled_class)
			elseif call_type = Creation_call then
				if context.compiled_class.creators /= Void then
					Result := context.compiled_class.creators.has (fi.feature_name)					
				end
			elseif call_type = Agent_call then
				Result := not fi.is_infix and
							not fi.is_prefix and
							not fi.is_c_external and
							not fi.is_attribute and
							fi.feature_name_id /= (feature {PREDEFINED_NAMES}.Void_name_id) and
							fi.is_exported_for (class_i.compiled_class)
			end
			if Result and fi.has_static_access and call_type /= Static_call then
				Result := not context.is_external_class
			end
		end
	
	feature_variables (fi: FEATURE_I; feature_table: FEATURE_TABLE): HASH_TABLE [TYPE, STRING] is
			-- Local and arguments types of feature `fi' from table `feature_table'.
			-- Result is indexed by name of variable.
		require
			non_void_feature: fi /= Void
		local
			type: TYPE
			r_type: TYPE_A
		do
			create Result.make (10)
			from
				locals.start
			until
				locals.after
			loop
				type := type_from_type_name (locals.key_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, locals.item_for_iteration)
					end
				end
				locals.forth
			end
			from
				arguments.start
			until
				arguments.after
			loop
				type := type_from_type_name (arguments.key_for_iteration)
				if type /= Void then
					r_type := resolved_type (type, feature_table, fi)
					if r_type /= Void then
						Result.put (r_type, arguments.item_for_iteration)
					end
				end
				arguments.forth
			end
		end

	resolved_type (type: TYPE; feature_table: FEATURE_TABLE; fi: FEATURE_I): TYPE_A is
			-- Solve type `type' within feature `fi' in table `feature_table'.
		require
			non_void_type: type /= Void
			non_void_table: feature_table /= Void
			non_void_feature_i: fi /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := Local_evaluator.evaluated_type (type, feature_table, fi)				
			end
		rescue
			retried := True
			retry
		end
		
	type_from_type_name (name: STRING): TYPE is
			-- Instance of {TYPE} from type name
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			retried: BOOLEAN
		do
			name.prune_all (' ')
			if not retried then
				Type_parser.parse_from_string ("toto " + name)
				Result := Type_parser.type_node
			end
		ensure
			spaces_removed: name.occurrences (' ') = 0
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	identifier_type (id: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]): TYPE is
			-- Type of identifier `id' if defined in either `table' or `ids'
		require
			non_void_identifier: id /= Void
			valid_identifier: not id.is_empty
			non_void_table: table /= Void
			non_void_ids: ids /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				id.item (i) /= ' ' or i > id.count
			loop
				i := i + 1
			end
			id.keep_tail (id.count - i + 1)
			ids.search (id)
			if ids.found then
				Result := ids.found_item
			else
				table.search (id)
				if table.found then
					Result := table.found_item.type
				end
			end
		ensure
			leading_spaces_removed: id.item (1) /= ' '
		end

	type_of_target (target: STRING; table: FEATURE_TABLE; ids: HASH_TABLE [TYPE, STRING]): TYPE is
			-- Type of expression `target'
		require
			non_void_target: target /= Void
			valid_target: not target.is_empty
		local
			c: CHARACTER
		do
			target.to_lower
			if target.substring (1, Agent_keyword_length).is_equal (Agent_keyword) then
				-- Agent
				set_agent_call
				if target.count > Agent_keyword_length + 1 then -- Minimum agent construct is "agent?."
					extract_type (target, Agent_keyword)
					if type_extracted then
						Result := extracted_type
					else
						if target.item (target.count).is_equal ('.') then
							target.keep_head (target.count - 1) -- Remove trailing '.'								
						end
						c := target.item (1)
						if c = '?' then
							Result := class_i.compiled_class.actual_type
						else
							Result := identifier_type (target, table, ids)
						end
					end
				end
			elseif target.substring (1, Feature_keyword_length).is_equal (Feature_keyword) then
				-- Static call
				set_static_call
				if target.count > Feature_keyword_length + 3 then -- Minimum static call construct is "feature{T}."
					Result := type_from_type_name (target.substring (target.index_of ('{', 1) + 1, target.index_of ('}', 2) - 1))
				end
			elseif target.substring (1, Create_keyword_length).is_equal (Create_keyword) then
				-- Creation call
				set_creation_call
				if target.count > Create_keyword_length + 2 then -- Minimum create construct is "create a."
					extract_type (target, Create_keyword)
					if type_extracted then
						Result := extracted_type
					else
						if target.item (target.count).is_equal ('.') then
							target.keep_head (target.count - 1) -- Remove trailing '.'								
						end
						Result := identifier_type (target, table, ids)						
					end
				end
			elseif target.item (1) = '!' then
				-- Creation call
				set_creation_call
				if target.item (target.count).is_equal ('.') then
					target.keep_head (target.count - 1) -- Remove trailing '.'								
				end
				if target.substring (1, 2).is_equal ("!!") then
					target.keep_tail (target.count - 2)
					Result := identifier_type (target, table, ids)
				else
					Result := type_from_type_name (target.substring (2, target.index_of ('!', 2) - 1))
				end
			elseif target.substring (1, Precursor_keyword_length).is_equal (Precursor_keyword) then
				-- Precursor call
			elseif target.item (1).is_equal ('{') then
				-- Precursor call
			end
		end
	
	extract_type (target, keyword: STRING) is
			-- Extract type in `target' after `keyword' between curly braces if any.
			-- Set `extracted_type' and `type_extracted' accordingly.
		require
			non_void_target: target /= Void
			valid_target: not target.is_empty
			non_void_keyword: keyword /= void
			valid_keyword: not keyword.is_empty
			starts_with_keyword: target.substring (1, keyword.count).is_equal (keyword)
			well_formed: target.index_of ('{', 1) > 0 implies target.index_of ('}', 1) > 0
			one_type_at_most: target.occurrences ('{') < 2
		local
			s: STRING
			c: CHARACTER
			i: INTEGER
		do
			target.keep_tail (target.count - keyword.count)
			c := target.item (1)
			if not c.is_alpha and not c.is_digit then
				from
					i := 1
				until
					target.item (i) /= ' ' or i > target.count
				loop
					i := i + 1							
				end
				target.prune_all_leading (' ')
				target.prune_all_leading ('%T')
				c := target.item (1)
				if c = '{' then
					s := target.substring (2, target.index_of ('}', 3) - 1)
					if not s.is_empty then
						extracted_type := type_from_type_name (s)
					end
				else
					extracted_type := Void
				end
				type_extracted := extracted_type /= Void
			end
		ensure
			keyword_removed: not target.substring (1, keyword.count).is_equal (keyword)
			type_removed_if_extracted: target.occurrences ('{') = 0 and target.occurrences ('}') = 0
			extracted_type_void_if_not_extracted: not type_extracted implies extracted_type = Void
			extracted_type_not_void_if_extracted: type_extracted implies extracted_type /= Void
		end
		
	completion_feature (a_feature_name: STRING; a_file_name: STRING): COMPLETION_FEATURE is
			-- does `completion_features' contain `a_feature_name' for file `a_file_name'
		require
			non_void_feature_name: a_feature_name /= Void
			valid_feature_name: not a_feature_name.is_empty
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			l_target: STRING
		do
			from
				completion_features.start
			until
				completion_features.after or Result /= Void
			loop
				l_target := clone (a_feature_name)
				l_target.to_lower
				if l_target.is_equal (completion_features.item.name) then
					l_target := clone (a_file_name)
					l_target.to_lower
					if l_target.is_equal (completion_features.item.file_name) then
						Result := completion_features.item
					end
				end
				completion_features.forth
			end	
		end
		
	feature_i_from_completion_feature (a_completion_feature: COMPLETION_FEATURE): FEATURE_I is
			-- create a FEATURE_I from `a_completion_feature'
		require
			non_void_completion_feature: a_completion_feature /= Void
		do
			-- we only need an FEATURE_I object 
			Result := create {R_DYN_FUNC_I}
		end		
		
	type_extracted: BOOLEAN
			-- Was last call to `extract_type' successful?
	
	extracted_type: TYPE
			-- Type extracted from last call to `extract_type'

	set_standard_call is
			-- Analyzed target corresponds to a standard call
		do
			call_type := Standard_call
		end
	
	set_agent_call is
			-- Analyzed target corresponds to an agent call
		do
			call_type := Agent_call
		end
	
	set_static_call is
			-- Analyzed target corresponds to a static call
		do
			call_type := Static_call
		end
	
	set_precursor_call is
			-- Analyzed target corresponds to a Precursor call
		do
			call_type := Precursor_call
		end
	
	set_creation_call is
			-- Analyzed target corresponds to a creation call
		do
			call_type := Creation_call
		end
		
	call_type: INTEGER
			-- Analyzed target call type
			--| Can be one of the following unique values
			
	Standard_call, Agent_call, Static_call, Creation_call, Precursor_call: INTEGER is unique
			-- Possible values for `call_type'

	Agent_keyword: STRING is "agent"
			-- Eiffel agent keyword
	
	Agent_keyword_length: INTEGER is 5
			-- Eiffel agent keyword character count
	
	Feature_keyword: STRING is "feature"
			-- Eiffel feature keyword
	
	Feature_keyword_length: INTEGER is 7
			-- Eiffel feature keyword character count
	
	Precursor_keyword: STRING is "precursor"
			-- Eiffel precursor keyword
	
	Precursor_keyword_length: INTEGER is 9
			-- Eiffel precursor keyword character count
	
	Create_keyword: STRING is "create"
			-- Eiffel create keyword
	
	Create_keyword_length: INTEGER is 6
			-- Eiffel create keyword character count
	
	class_i: CLASS_I
			-- Class in which code is being completed

	locals, arguments: HASH_TABLE [STRING, STRING]
			-- Local variables and arguments used to solve member completion list.
			
	completion_features: ARRAYED_LIST [COMPLETION_FEATURE]
			-- Uncomplided features use to solve member completion.
			
	qualified_call: BOOLEAN
			-- is current target a qualified call (with '.')

invariant
	valid_class_i: class_i /= Void implies class_i.compiled
	valid_call_type: call_type = Standard_call or call_type = Static_call or
						call_type = Creation_call or call_type = Precursor_call or
						call_type = Agent_call
	non_void_completion_features: completion_features /= Void

end -- class COMPLETION_INFORMATION
