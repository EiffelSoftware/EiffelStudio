indexing
	description: "Retrieve information on specific feature (used to display tooltips in VS)"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_RETRIEVER

inherit
	COMPLETION_ENGINE

	SHARED_WORKBENCH
		export
			{NONE} all
		end

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
			qualified_call := False
			found_item := Void
			Inst_context.set_cluster (class_i.cluster)
			l_targets := target.split ('.')
			if feature_i /= void then
				if l_targets.count = 1 then
					found_item := completion_feature_from_name (target)
					if found_item = Void then
						found_item := uncompiled_completion_feature (target)
						found := found_item /= Void
					end
				else
					if l_targets.last.is_empty then
						l_targets.finish
						l_targets.remove
					end
					qualified_call := l_targets.count > 1
					l_targets.finish
					l_lookup_name := l_targets.item
					l_targets.remove
					l_target_type := target_type (l_targets.first)
					if l_target_type /= void and then not l_target_type.is_void then
						l_targets.start
						l_targets.remove
						feature_table := recursive_lookup (l_target_type, l_targets, feature_table)
						if feature_table /= void then
							found_item := completion_feature_from_name (l_lookup_name)
						end
					end
				end
			else
				if l_targets.count = 1 then
					found_item := uncompiled_completion_feature (target)
					found := found_item /= Void
				end
			end
		end

feature {NONE} -- Implementation

	completion_feature_from_name (a_name: STRING): COMPLETION_FEATURE is
			-- Completion feature with name `a_name', may be overloaded.
		require
			non_void_name: a_name /= Void
			valid_name: names_heap.has (a_name)
			non_void_feature_table: feature_table /= Void
		local
			l_overloaded_features: LIST [FEATURE_I]
			l_feature_i: FEATURE_I
			l_class_i: CLASS_I
		do
			l_class_i := feature_table.associated_class.lace_class
			if feature_table.has_overloaded (a_name) then
				l_overloaded_features := feature_table.overloaded_items (a_name)
				from
					l_overloaded_features.start
				until
					l_overloaded_features.after
				loop
					l_feature_i := l_overloaded_features.item
					if is_listed (l_feature_i, class_i, l_class_i) then
						extract_description (l_feature_i, l_class_i)
						if Result = Void then
							create Result.make_with_return_type (a_name, parameter_descriptors (l_feature_i), l_feature_i.type.dump, feature_type (l_feature_i), clone (extracted_description), l_feature_i.written_class.file_name, feature_location (l_feature_i))
						else
							Result.add_overload (create {PARAMETER_ENUMERATOR}.make (parameter_descriptors (l_feature_i)), l_feature_i.type.dump, clone (extracted_description))								
						end
					end
					l_overloaded_features.forth
				end
			else
				feature_table.search (a_name)
				if feature_table.found then
					l_feature_i := feature_table.found_item
					if is_listed (l_feature_i, class_i, l_class_i) then
						extract_description (l_feature_i, l_class_i)
						create Result.make_with_return_type (l_feature_i.feature_name, parameter_descriptors (l_feature_i), l_feature_i.type.dump, feature_type (l_feature_i), clone (extracted_description), l_feature_i.written_class.file_name, feature_location (l_feature_i))
					end
				end
			end
			found := Result /= Void
		end
		
	feature_location (a_feature_i: FEATURE_I): INTEGER is
			-- retrieve line number of feature `a_feature_i'
		require
			non_void_feature_i: a_feature_i /= Void
		local
			l_class_txt: STRING
			l_start_position: INTEGER
		do
			if a_feature_i.e_feature.ast /= Void then
				-- ast will be Void for uncompiled inherited features
				l_start_position := a_feature_i.e_feature.ast.start_position
				l_class_txt := a_feature_i.written_class.lace_class.text.substring (1, l_start_position)
				Result := l_class_txt.occurrences ('%N')
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
