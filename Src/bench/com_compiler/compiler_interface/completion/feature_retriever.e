indexing
	description: "Retrieve information on specific feature (used to display tooltips in VS)"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_RETRIEVER

inherit
	COMPLETION_ENGINE

create
	make

feature -- Access

	found_item: COMPLETION_FEATURE
			-- Retrieved feature

feature -- Basic Operations

	find (target: STRING; use_overloading: BOOLEAN) is
			-- Find `target' in current context
		local
			l_targets: LIST [STRING]
			l_target_type: TYPE
			l_lookup_name: STRING
		do
			found := False
			found_item := Void
			l_targets := target.split ('.')
			qualified_call := False
			Inst_context.set_cluster (class_i.cluster)
			if feature_i /= void then
				if l_targets.count = 1 then
					feature_table.search (l_targets.first)
					if feature_table.found then
						found_item := overloaded_completion_feature (class_i, feature_table.found_item)
						found := True
					else
						found_item := uncompiled_completion_feature (target)
						found := found_item /= Void
					end
				else
					if l_targets.last.is_empty then
						l_targets.finish
						l_targets.remove
					end
					l_targets.finish
					l_lookup_name := l_targets.item
					l_targets.remove
					l_target_type := target_type (l_targets.first)
					if l_target_type /= void and then not l_target_type.is_void then
						l_targets.start
						l_targets.remove
						feature_table := recursive_lookup (l_target_type, l_targets, feature_table)
						if feature_table /= void then
							feature_table.search (l_lookup_name)
							if feature_table.found then
								found_item := overloaded_completion_feature (class_i, feature_table.found_item)
								found := True
							end
						end
					end
				end
			else
				if l_targets.count = 1 then
					found_item := uncompiled_completion_feature (l_targets.first)
					found := found_item /= Void
				end
			end
		ensure then
			locals_reset: locals.is_empty
			arguments_reset: arguments.is_empty			
		end

feature {NONE} -- Implementation

	overloaded_completion_feature (a_class_i: CLASS_I; a_feature_i: FEATURE_I): COMPLETION_FEATURE is
			-- Initialize a completion feature with overloads if any
		require
			non_void_class_i: a_class_i /= Void
			non_void_feature_i: a_feature_i /= Void
		local
			l_overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			l_overloaded_ids: LIST [INTEGER]
			l_params: PARAMETER_ENUMERATOR
			l_feature_i: FEATURE_I
			l_id, l_overloaded_id: INTEGER
		do
			create Result.make_with_return_type (a_feature_i.feature_name, parameter_descriptors (a_feature_i), a_feature_i.type.dump, feature_type (a_feature_i), a_class_i.file_name)
			l_overloaded_id := a_feature_i.feature_name_id
			l_overloaded_names := feature_table.overloaded_names
			from
				l_overloaded_names.start
			until
				l_overloaded_names.after
			loop
				l_overloaded_ids := l_overloaded_names.item_for_iteration
				if l_overloaded_ids.has (l_overloaded_id) then
					from
						l_overloaded_ids.start
					until
						l_overloaded_ids.after
					loop
						l_id := l_overloaded_ids.item
						if l_id /= l_overloaded_id then
							l_feature_i := feature_table.item_id (l_id)		
							create l_params.make (parameter_descriptors (l_feature_i))
							Result.add_overload (l_params, l_feature_i.type.dump)
						end
						l_overloaded_ids.forth
					end
				end
				l_overloaded_names.forth
			end
		end

	parameter_descriptors (a_feature_i: FEATURE_I): ARRAYED_LIST [PARAMETER_DESCRIPTOR] is
			-- Convert `a_feature_i' arguments into a list of parameter descriptors
		require
			non_void_feature_i: a_feature_i /= Void
		local
			l_args: FEAT_ARG
		do
			if a_feature_i.has_arguments then
				l_args := a_feature_i.arguments
				create Result.make (l_args.count)
				from
					l_args.start
				until
					l_args.after  
				loop
					Result.extend (create {PARAMETER_DESCRIPTOR}.make (l_args.item_name (l_args.index), l_args.item.dump))
					l_args.forth
				end
			else
				create Result.make (0)
			end
		ensure
			non_void_descriptors: Result /= Void
		end

	feature_type (a_feature_i: FEATURE_I): INTEGER is
			-- Extract feature type enum from `a_feature_i'.
		require
			non_void_feature_i: a_feature_i /= Void
		do
			if a_feature_i.is_routine and a_feature_i.has_return_value then
				Result := feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_function
			elseif a_feature_i.is_routine then
				Result := feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_procedure
			elseif a_feature_i.is_constant then
				Result := feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_constant
			elseif a_feature_i.is_attribute then
				Result := feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_attribute
			end
			check
				initialized: Result > 0
			end
			if a_feature_i.is_deferred then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_deferred
			end
			if a_feature_i.is_external then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_external
			end
			if a_feature_i.is_frozen then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_frozen
			end
			if a_feature_i.is_infix then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_infix
			end
			if a_feature_i.is_prefix then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_prefix
			end
			if a_feature_i.is_obsolete then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_obsolete
			end
			if a_feature_i.is_once then
				Result := Result | feature {ECOM_EIF_FEATURE_TYPES_ENUM}.Eif_feature_types_once
			end
		end
		
end -- class FEATURE_INFORMATION
