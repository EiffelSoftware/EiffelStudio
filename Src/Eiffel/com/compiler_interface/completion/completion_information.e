indexing
    description: "[
                    Complete given target in given class and feature.
                    If the target ends with a '.', give list of possible
                    features.
                    ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class
    COMPLETION_INFORMATION

inherit
    IEIFFEL_COMPLETION_INFO_IMPL_STUB
        redefine
        	target_classes,
            target_features,
            target_feature,
            find_class_definition,
            find_feature_definition,
            add_local,
            add_argument,
            flush_locals,
            flush_arguments,
            flush_completion_features,
            flush_completion_features_user_precondition,
            initialize_feature,
            initialize_feature_user_precondition,
            setup_rename_table
        end

    SHARED_EIFFEL_PROJECT
        export
            {NONE} all
        end
    
    SHARED_EIFFEL_PARSER
        export
            {NONE} all
        end
    
    ECOM_EXCEPTION
        export
            {NONE} all
        end
        
    ECOM_EXCEPTION_CODES
        export
            {NONE} all
        end

create
    make

feature {NONE} -- Initialization

    make is
            -- Initialize info
        do
            create locals.make (10)
            create arguments.make (5)
            create completion_features.make (5)
            completion_features.compare_objects
            create listers_table.make (5)
        end

feature -- Access

    target_classes (target: STRING): CLASS_ENUMERATOR is
            -- Classes in universe
        local
            class_descs: SORTABLE_ARRAY [CLASS_DESCRIPTOR]
            l_sorting_array: SORTABLE_ARRAY [CLASS_DESCRIPTOR]
            clusters: ARRAYED_LIST [CLUSTER_I]
            classes: HASH_TABLE [CLASS_I, STRING]
            l_name: STRING
            l_count, l_index: INTEGER
            l_retried: BOOLEAN
        do
        	target.to_upper
        	if not l_retried then
	            clusters := Eiffel_universe.clusters
	            create class_descs.make (0, 20)
	            l_count := target.count
	            from
 	                clusters.start
	            until
	                clusters.after
	            loop
	                classes := clusters.item.classes
	                from
	                    classes.start
	                until
	                    classes.after
	                loop
	                	l_name := classes.item_for_iteration.name_in_upper
						if l_name.count >= l_count and then l_name.substring (1, l_count).is_equal (target) then
							class_descs.force (create {CLASS_DESCRIPTOR}.make_with_class_i (classes.item_for_iteration), l_index)
							l_index := l_index + 1
						end
	                    classes.forth
	                end
	                clusters.forth
	            end
	            create l_sorting_array.make (1, l_index)
	            l_sorting_array.subcopy (class_descs, class_descs.lower, class_descs.lower + l_index - 1, 1)
	            l_sorting_array.sort
	            create Result.make (create {ARRAYED_LIST [CLASS_DESCRIPTOR]}.make_from_array (l_sorting_array))
        	else
        		create Result.make (create {ARRAYED_LIST [CLASS_DESCRIPTOR]}.make (0))
        	end
        rescue
        	l_retried := True
        	retry
        end

 	target_feature (target: STRING; location_name: STRING; file_name: STRING; use_overloading: BOOLEAN; feature_name: CELL [STRING]; descriptions: ECOM_VARIANT; return_types: ECOM_VARIANT; params: ECOM_VARIANT) is
 			-- Feature information
			-- `target' [in].
			-- `location_name' [in].
			-- `file_name' [in].
			-- `use_overloading' [in].
			-- `feature_name' [out].
			-- `descriptions' [out].  
			-- `return_types' [out].  
			-- `params' [out].
        local
            l_feature: COMPLETION_FEATURE
  			l_return_types: ECOM_ARRAY [STRING]
 			l_descriptions: ECOM_ARRAY [STRING]
			l_params: ECOM_ARRAY [PARAMETER_ENUMERATOR]
			l_overloads_count: INTEGER
			l_retried: BOOLEAN
		do
			if not l_retried then
				target.to_lower
				l_feature := internal_target_feature (target, location_name, file_name, use_overloading, False, True)
				if l_feature /= Void then
					l_overloads_count := l_feature.overloads_count + 1
					create l_return_types.make (1, <<1>>, <<l_overloads_count>>)
					create l_descriptions.make (1, <<1>>, <<l_overloads_count>>)
					create l_params.make (1, <<1>>, <<l_overloads_count>>)
					l_return_types.put (l_feature.return_type, <<1>>)
					l_descriptions.put (l_feature.description, <<1>>)
					l_params.put (l_feature.parameters, <<1>>)
					append_list_to_com_array (l_feature.overloads_return_types, l_return_types, 2)
					append_list_to_com_array (l_feature.overloads_descriptions, l_descriptions, 2)
					append_list_to_com_array (l_feature.overloads_parameters, l_params, 2)
					feature_name.put (l_feature.name)
					return_types.set_string_array (l_return_types)
					descriptions.set_string_array (l_descriptions)
					params.set_iunknown_array (l_params)
				else
					feature_name.put ("")
	                return_types.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
	                descriptions.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
	                params.set_iunknown_array (create {ECOM_ARRAY [ECOM_INTERFACE]}.make_empty)
				end
			end
		rescue
			feature_name.put ("")
			return_types.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
			descriptions.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
			params.set_iunknown_array (create {ECOM_ARRAY [ECOM_INTERFACE]}.make_empty)
			l_retried := True
			retry
		end

    target_features (target, location_name: STRING; location_type: INTEGER; file_name: STRING; use_overloading: BOOLEAN; return_names: ECOM_VARIANT; descriptions: CELL [IEIFFEL_ENUM_STRING_INTERFACE]; return_image_indexes: ECOM_VARIANT) is
            -- Features accessible from target.
            -- `target' [in]. 
            -- `feature_name' [in].
            -- `file_name' [in].
            -- `return_names' [out].
            -- `return_signatures' [out].
            -- `return_image_indexes' [out].
		local
			l_lister: FEATURES_LISTER
			l_entries: ARRAYED_LIST [COMPLETION_ENTRY]
			l_class_i: CLASS_I
			l_retried: BOOLEAN
		do
			if not l_retried then
				target.to_lower
				if location_type = feature {ECOM_EIF_COMPLETION_LOCATION_ENUM}.Eif_completion_location_feature then
	                l_lister := lister (file_name)
					if l_lister.is_initialized then
						l_lister.set_locals (locals)
						l_lister.set_arguments (arguments)
						l_lister.set_completion_features (completion_features)
						l_lister.set_feature_name (location_name)
						l_lister.reset_renames
					end
	            else
					l_class_i := class_from_name (location_name)
					if l_class_i /= Void then
						l_lister := lister (l_class_i.file_name)
						if l_lister.is_initialized then
							l_lister.reset_feature_name
							l_lister.set_renames (rename_sources, rename_targets)
						end
					end
				end
				if l_lister /= Void and then l_lister.is_initialized then
					l_lister.find (target, use_overloading, False, True)
					if l_lister.found then
						l_entries := l_lister.found_items
						extract_variants_from_list (l_entries, return_names, return_image_indexes)
						descriptions.put (create {DESCRIPTIONS_ENUMERATOR}.make (l_entries))
					else
						set_empty_results (return_names, return_image_indexes, descriptions)
					end
	            else
	 				set_empty_results (return_names, return_image_indexes, descriptions)
	            end
			end
		rescue
			set_empty_results (return_names, return_image_indexes, descriptions)
			l_retried := True
			retry
 		end
        
	find_class_definition (bstr_target: STRING): IEIFFEL_DEFINITION_RESULT_INTERFACE is
			-- Find class definition.
		local
			l_class: CLASS_I
		do
			l_class := find_class_i (bstr_target)
			if l_class /= Void then
				create {DEFINITION_SEARCH_RESULT}Result.make (l_class)	
			end
		end
		
	find_feature_definition (bstr_target, bstr_class, bstr_feature: STRING): IEIFFEL_DEFINITION_FEATURE_RESULT_INTERFACE is
			-- Find feature definition
		local
			l_class: CLASS_I
			l_feature: FEATURE_I
			l_cf: COMPLETION_FEATURE
		do
			l_class := find_class_i (bstr_class)
			if l_class /= Void then
				l_cf := internal_target_feature (bstr_target, bstr_feature, l_class.file_name, True, True, False)
				if l_cf = Void then
					l_cf := internal_target_feature (bstr_target, bstr_feature, l_class.file_name, False, True, False)	
				end
				if l_cf /= Void then
					l_class := l_cf.declaring_class
					if l_class = Void then
						l_class := eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (l_cf.file_name))	
					end					
					if l_class /= Void and l_class.is_compiled then
						l_feature := l_class.compiled_class.feature_named (l_cf.feature_name)
						if l_feature /= Void then
							create {DEFINITION_SEARCH_RESULT_FEATURE}Result.make (l_class, l_feature)		
						end
					end
				end
			end
		end

feature -- Basic Operations

    setup_rename_table (var_sources: ECOM_VARIANT; var_targets: ECOM_VARIANT) is
            -- Initialize the tables used to resolve renaming for completion of inherited features in inheritance clause.
            -- `var_sources' [in].  
            -- `var_targets' [in].
        local
            retried: BOOLEAN
        do
            if not retried then
                rename_sources := var_sources.string_array
                rename_targets := var_targets.string_array
            end
        rescue
            retried := True
            retry
        end

    add_local (name: STRING; type: STRING) is
            -- Add local variable used for solving member completion list.
        do
            if not name.is_empty and then not type.is_empty and then not locals.has (name) then
                locals.put (type, name)
            end
        end

    add_argument (name: STRING; type: STRING) is
            -- Add argument used for solving member completion list.
        do
            if not name.is_empty and then not type.is_empty and then not arguments.has (name) then
                arguments.put (type, name)
            end
        end 
    
    flush_locals is
    		-- Empty locals table.
    	do
    		create locals.make (10)
    	end
   	
   	flush_arguments is
   			-- Empty arguments table.
		do
			create arguments.make (5)
		end
   		
    flush_completion_features (a_file_name: STRING) is
            -- clear all `completion_features' in `a_file_name'
        require else
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
        do
			completion_features.remove (a_file_name.as_lower)
        end
        
    initialize_feature (a_name: STRING; a_arguments: ECOM_VARIANT; a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING; a_row: INTEGER) is
            -- Initialize a feature for completion without compilation
		require else -- Actually a "require" since parent precondition is "False"
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
			retried: BOOLEAN
			feature_list: ARRAYED_LIST [COMPLETION_FEATURE]
		do
			if not retried then
				a_name.to_lower
				l_ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (a_file_name))
				if l_ci /= Void then
					if l_ci.compiled_class /= Void and then l_ci.compiled_class.has_feature_table then
						l_fi := l_ci.compiled_class.feature_table.item (a_name)
					end
				end
				if l_fi = Void then
					if a_arguments /= Void and a_argument_types /= Void then
						l_ecom_arguments := a_arguments.string_array
						l_ecom_types := a_argument_types.string_array
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
						create l_feature.make (a_name, l_ci, l_arguments, a_feature_type, "", a_file_name, a_row)
					else
						create l_feature.make_with_return_type (a_name, l_ci, l_arguments, a_return_type, a_feature_type, "", a_file_name, a_row)
					end
					completion_features.search (a_file_name.as_lower)
					if completion_features.found then
						completion_features.found_item.extend (l_feature)
					else
						create feature_list.make (5)
						feature_list.extend (l_feature)
						completion_features.put (feature_list, a_file_name.as_lower)
					end
				end
			end
		rescue
			retried := True
			retry
		end
        
    flush_completion_features_user_precondition (a_file_name: STRING): BOOLEAN is
        do
            Result := False
        end
        
    initialize_feature_user_precondition (a_name: STRING; a_arguments, a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING; a_row: INTEGER): BOOLEAN is
        do
            Result := False
        end 

feature {NONE} -- Implementation

	find_class_i (a_class_name: STRING): CLASS_I is
			-- Find class definition.
		require
			a_class_name_not_void: a_class_name /= Void
			not_a_class_name_is_empty: not a_class_name.is_empty
		local
			l_classes: LIST [CLASS_I]
		do
			l_classes := eiffel_universe.classes_with_name (a_class_name)
			if l_classes /= Void and then not l_classes.is_empty then
					-- Attempt to locate a compiled class first
				from
					l_classes.start
				until
					l_classes.after or Result /= Void
				loop
					if l_classes.item.is_compiled then
						Result := l_classes.item
					end
					l_classes.forth
				end
				if Result = Void then
					Result := l_classes.first	
				end
			end
		end

    rename_sources: ARRAY [STRING]
            -- Renamed features

    previous_file_name: STRING
            -- Last file name used to lookup lister

    rename_targets: ARRAY [STRING]
            -- Renamed features new names

    locals: HASH_TABLE [STRING, STRING]
            -- Feature locals

    arguments: HASH_TABLE [STRING, STRING]
            -- Feature arguments

    completion_features: HASH_TABLE [ARRAYED_LIST [COMPLETION_FEATURE], STRING]
            -- Uncompiled features use to solve member completion
            -- Grouped by filename

    listers_table: HASH_TABLE [FEATURES_LISTER, STRING]
            -- Table of features listers grouped by filename

feature {NONE} -- Implementation

    extract_variants_from_list (entries: LIST [COMPLETION_ENTRY]; return_names, return_image_indexes: ECOM_VARIANT) is
            -- Setup `return_names', `return_signatures' and `return_image_indexes' according to `entries'.
        require
            non_void_entries: entries /= Void
        local
			l_index, l_count: INTEGER
			l_names: ECOM_ARRAY [STRING]
			l_image_indexes: ECOM_ARRAY [INTEGER]
			l_entry: COMPLETION_ENTRY
        do  
            l_count := entries.count
            if l_count > 0 then
                create l_names.make (1, <<1>>, <<l_count>>)
                create l_image_indexes.make (1, <<1>>, <<l_count>>)
                from 
                    l_index := 1
                until
                    l_index > l_count
                loop
                    l_entry := entries.i_th (l_index)
                    l_names.put (l_entry.name.twin, <<l_index>>)
                    l_image_indexes.put (image_index (l_entry), <<l_index>>)
                    l_index := l_index + 1
                end
            else
                create l_names.make_empty
                create l_image_indexes.make_empty
            end
            return_names.set_string_array (l_names)
            return_image_indexes.set_integer_array (l_image_indexes)
        ensure then
            non_void_names: return_names.string_array /= Void
            non_void_image_indexes: return_image_indexes.integer_array /= Void
        end

    image_index (entry: COMPLETION_ENTRY): INTEGER is
            -- Image index in image list for `entry'
        require
            non_void_entry: entry /= Void
        local
            l_bool_ref: BOOLEAN_REF
            l_feature_descriptor: FEATURE_DESCRIPTOR
        do
            create l_bool_ref
            entry.is_feature (l_bool_ref)
            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_locals
            if l_bool_ref.item then
                l_feature_descriptor ?= entry
                if l_feature_descriptor /= Void then
                    if l_feature_descriptor.is_constant or l_feature_descriptor.is_unique then
                        Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_once_frozen
                    elseif l_feature_descriptor.is_attribute then
                        if l_feature_descriptor.is_obsolete then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute_frozen
                        else
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute
                        end
                    elseif l_feature_descriptor.is_once then
                        if l_feature_descriptor.is_obsolete then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_once_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_once_frozen
                        else
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_once
                        end
                    elseif l_feature_descriptor.is_external then
                        if l_feature_descriptor.is_obsolete then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_external_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_external_frozen
                        else
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_external
                        end
                    elseif l_feature_descriptor.is_attribute then
                        if l_feature_descriptor.is_obsolete then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute_frozen
                        else
                            Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_attribute
                        end
                    elseif l_feature_descriptor.is_obsolete then
						Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_obsolete
					elseif l_feature_descriptor.is_frozen then
                    	Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature_frozen
					else
                    	Result := {ECOM_LSICONINDEX_ENUM}.lsicon_feature
                    end
                end
            end
        end

	class_from_name (a_name: STRING): CLASS_I is
			-- CLASS_I instance corresponding to class with name `a_name' if any
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			classes: LIST [CLASS_I]
		do
			classes := Eiffel_universe.classes_with_name (a_name)
			if classes /= Void then
				from
					classes.start
				until
					classes.after or (Result /= Void and then Result.is_compiled)
				loop
					Result := classes.item
					classes.forth
				end
			end
		end

	lister (a_file_name: STRING): FEATURES_LISTER is
			-- Lister for class in file `a_file_name'
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		do
			listers_table.search (a_file_name)
			if listers_table.found then
				Result := listers_table.found_item
			else
				create Result.make (a_file_name)
				listers_table.put (Result, a_file_name)
			end
		ensure
			non_void_lister: Result /= Void
		end

	internal_target_feature (target: STRING; feature_name: STRING; file_name: STRING; use_overloading: BOOLEAN; a_ignore_call_type: BOOLEAN; a_fetch_description: BOOLEAN): COMPLETION_FEATURE is
			-- Feature information
			-- `target' [in].
			-- `feature_name' [in].
			-- `file_name' [in].
		local
			l_retriever: FEATURE_RETRIEVER
		do
			create l_retriever.make (file_name)
			if l_retriever.is_initialized then
				l_retriever.set_locals (locals)
				l_retriever.set_arguments (arguments)
				l_retriever.set_completion_features (completion_features)
				l_retriever.set_feature_name (feature_name)
				l_retriever.find (target.as_lower, use_overloading, a_ignore_call_type, a_fetch_description)
				if l_retriever.found then
					Result := l_retriever.found_item
				end
			end
        end

	append_list_to_com_array (a_list: LIST [ANY]; a_com_array: ECOM_ARRAY [ANY]; start_index: INTEGER) is
			-- Append `a_list' into `a_com_array' starting at index `start_index'.
		require
			non_void_list: a_list /= Void
			non_void_com_array: a_com_array /= Void
			valid_com_array: a_list.count > 0 implies (a_com_array.upper_indices.item (1) >= a_list.count + start_index - 1) and (a_com_array.lower_indices.item (1) = 1)
		local
			i: INTEGER
		do
			from
				i := start_index
				a_list.start
			until
				a_list.after
			loop
				a_com_array.put (a_list.item, <<i>>)
				i := i + 1
				a_list.forth
			end
		end

	set_empty_results (a_return_names, a_return_image_indexes: ECOM_VARIANT; a_descriptions: CELL [IEIFFEL_ENUM_STRING_INTERFACE]) is
			-- Put empty values in arguments.
		require
			non_void_return_names: a_return_names /= Void
			non_void_return_image_indexes: a_return_image_indexes /= Void
			non_void_descriptions: a_descriptions /= Void
		do
			a_return_names.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
			a_return_image_indexes.set_integer_array (create {ECOM_ARRAY [INTEGER]}.make_empty)
			a_descriptions.put (create {DESCRIPTIONS_ENUMERATOR}.make_empty)
		end

invariant
    non_void_completion_features: completion_features /= Void

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
end -- class COMPLETION_INFORMATION
