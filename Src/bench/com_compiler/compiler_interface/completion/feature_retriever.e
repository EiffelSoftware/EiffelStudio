indexing
	description: "Retrieve information on specific feature (used to display tooltips in VS)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	find (target: STRING; use_overloading: BOOLEAN; a_ignore_call_type: BOOLEAN; a_fetch_description: BOOLEAN) is
			-- Find `target' in current context
		local
			l_targets: LIST [STRING]
			l_target_type: TYPE_AS
			l_lookup_name: STRING
			l_new_target: like target
			l_type: TYPE_AS
			l_feature_id: INTEGER
			l_parents: FIXED_LIST [CLASS_C]
			l_feature: FEATURE_I
			l_actually_type: TYPE_A
			l_class: CLASS_C
			l_retriever: FEATURE_RETRIEVER
		do
			found := False
			qualified_call := False
			found_item := Void
			Inst_context.set_cluster (class_i.cluster)
			l_targets := target.split ('.')
			l_targets.finish
			if l_targets.item.is_empty then
				l_targets.remove
			end
			if feature_i /= void then
				qualified_call := l_targets.count > 1
				if not qualified_call then
					if target.count >= precursor_keyword_length and then target.substring (1, precursor_keyword_length).is_equal (precursor_keyword) then
							-- Precursor call
						l_type := target_type (target)
						l_feature_id := feature_i.feature_name_id
						if l_type = Void then
								-- Call is not typed (i.e. Precursor {ANY})
							if class_i.is_compiled then
								l_parents := class_i.compiled_class.parents_classes
								from
									l_parents.start	
								until
									l_parents.after or l_feature /= Void
								loop
									l_class := l_parents.item
									l_feature := l_class.feature_named (feature_name)
									if l_feature /= Void and then l_feature.is_deferred or else l_feature_id /= l_feature.feature_name_id then
										l_feature := Void
									end
									l_parents.forth
								end
							end
						else
							l_actually_type := l_type.actual_type
							if l_actually_type /= Void then
								l_class := l_actually_type.associated_class
								if l_class /= Void then
									l_feature := l_class.feature_named (feature_name)
								end
							end
						end
						if l_class /= Void and l_feature /= Void then
							create l_retriever.make (l_class.file_name)
							l_retriever.set_feature_name (l_feature.feature_name)
							l_retriever.find (l_feature.feature_name, use_overloading, a_ignore_call_type, a_fetch_description)
							if l_retriever.found then
								found_item := l_retriever.found_item
								found := found_item /= Void
							end
						end
					else
						l_new_target := feature_name_from_target (target)
						if l_new_target /= Void and not l_new_target.is_empty then
							found_item := completion_feature_from_name (l_new_target, a_ignore_call_type, a_fetch_description)
							if found_item = Void then
								found_item := uncompiled_completion_feature (l_new_target)
								found := found_item /= Void
							end	
						end
					end
				else
					l_targets.finish
					l_lookup_name := l_targets.item
					l_targets.remove
					l_target_type := target_type (l_targets.first)
					if target.occurrences ('.') > 1 and then call_type = static_call or call_type = precursor_call then
						set_standard_call
					end
					if l_target_type /= void and then not l_target_type.is_void then
						l_targets.start
						l_targets.remove
						feature_table := recursive_lookup (class_i, instantiated_type (class_i, Void, l_target_type), l_targets, feature_table, True)
						if feature_table /= void then
							found_item := completion_feature_from_name (l_lookup_name, a_ignore_call_type, a_fetch_description)
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

	completion_feature_from_name (a_name: STRING; a_ignore_call_type: BOOLEAN; a_fetch_description: BOOLEAN): COMPLETION_FEATURE is
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
						if a_fetch_description then
							extract_description (l_feature_i, l_class_i, a_name)
						else
							create extracted_description.make_empty
						end
						if Result = Void then
							create Result.make_with_return_type (a_name, l_class_i, parameter_descriptors (l_feature_i), l_feature_i.type.dump, feature_type (l_feature_i), extracted_description.twin, l_feature_i.written_class.file_name, feature_location (l_feature_i))
						else
							Result.add_overload (create {PARAMETER_ENUMERATOR}.make (parameter_descriptors (l_feature_i)), l_feature_i.type.dump, extracted_description.twin)
						end
					end
					l_overloaded_features.forth
				end
			else
				feature_table.search (a_name)
				if feature_table.found then
					l_feature_i := feature_table.found_item
					if a_ignore_call_type or is_listed (l_feature_i, class_i, l_class_i) then
						if l_feature_i.written_class /= Void then
							l_class_i := l_feature_i.written_class.lace_class
						end
						if a_fetch_description then
							extract_description (l_feature_i, l_class_i, a_name)
						else
							create extracted_description.make_empty
						end
						create Result.make_with_return_type (l_feature_i.feature_name, l_class_i, parameter_descriptors (l_feature_i), l_feature_i.type.dump, feature_type (l_feature_i), extracted_description.twin, l_feature_i.written_class.file_name, feature_location (l_feature_i))
					end
				end
			end
			found := Result /= Void
		end
		
	feature_name_from_target (a_target: STRING): STRING is
			-- extracts and returns a feature name from `a_target'
		require
			non_void_target: a_target /= Void
			valid_target: not a_target.is_empty
		local
			l_last_spc: INTEGER
		do
			l_last_spc := a_target.last_index_of (' ', a_target.count)
			if l_last_spc > 0 then
				Result := a_target.substring (l_last_spc + 1, a_target.count)
			else
				Result := a_target.twin
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
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
end -- class FEATURE_INFORMATION
