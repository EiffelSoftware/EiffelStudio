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
            parse_source_for_expr,
            find_definition,
            find_inherited_definition,
            add_local,
            add_argument,
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

    ECOM_EIF_ENTITY_IMAGES_ENUM
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
            create listers_table.make (5)
        end

feature -- Access

    target_classes (target: STRING): CLASS_ENUMERATOR is
            -- Classes in universe
        local
            class_descs: ARRAYED_LIST [CLASS_DESCRIPTOR]
            clusters: ARRAYED_LIST [CLUSTER_I]
            classes: HASH_TABLE [CLASS_I, STRING]
        do
            clusters := Eiffel_universe.clusters
            create class_descs.make (0)
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
                    class_descs.extend (create {CLASS_DESCRIPTOR}.make_with_class_i (classes.item_for_iteration))                           
                    classes.forth
                end
                clusters.forth
            end
            create Result.make (class_descs)
        end

    target_feature (target: STRING; feature_name: STRING; file_name: STRING; use_overloading: BOOLEAN): FEATURE_DESCRIPTOR is
            -- Feature information
            -- `target' [in].
            -- `feature_name' [in].
            -- `file_name' [in].
        local
            l_retriever: FEATURE_RETRIEVER
        do
            if feature_name.is_empty then
                trigger (E_invalidarg)
            end
            create l_retriever.make (file_name)
            l_retriever.set_locals (locals)
            l_retriever.set_arguments (arguments)
            l_retriever.set_completion_features (completion_features)
            l_retriever.set_feature_name (feature_name)
            l_retriever.find (target, use_overloading)
            if l_retriever.found then
                Result := l_retriever.found_item
            end
        end

    target_features (target, location_name: STRING; location_type: INTEGER; file_name: STRING; use_overloading: BOOLEAN; return_names, return_signatures, return_image_indexes: ECOM_VARIANT) is
            -- Features accessible from target.
            -- `target' [in]. 
            -- `feature_name' [in].
            -- `file_name' [in].
            -- `return_names' [out].
            -- `return_signatures' [out].
            -- `return_image_indexes' [out].
		local
			l_lister: FEATURES_LISTER
			l_entries: LIST [COMPLETION_ENTRY]
			l_class_i: CLASS_I
		do
            if location_type = feature {ECOM_EIF_COMPLETION_LOCATION_ENUM}.Eif_completion_location_feature then
                l_lister := lister (file_name)
                l_lister.set_locals (locals)
                l_lister.set_arguments (arguments)
                l_lister.set_completion_features (completion_features)
                l_lister.set_feature_name (location_name)
                l_lister.reset_renames
            else
                l_class_i := class_from_name (location_name)
                if l_class_i /= Void then
                    l_lister := lister (l_class_i.file_name)
                    l_lister.reset_feature_name
                    l_lister.set_renames (rename_sources, rename_targets)
                end
            end
            if l_lister /= Void and then l_lister.is_initialized then
                l_lister.find (target, use_overloading)
                if l_lister.found then
                    l_entries := l_lister.found_items
                    extract_variants_from_list (l_entries, return_names, return_signatures, return_image_indexes)
                else
                    return_names.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
                    return_signatures.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
                    return_image_indexes.set_integer_array (create {ECOM_ARRAY [INTEGER]}.make_empty)
                end
            else
                return_names.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
                return_signatures.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
                return_image_indexes.set_integer_array (create {ECOM_ARRAY [INTEGER]}.make_empty)
            end
        end

    parse_source_for_expr (source_text: STRING; source_row, source_col: INTEGER; expr, feat: CELL [STRING]; is_class_expr: BOOLEAN_REF) is
            -- Parse `source_text' where caret is at `source_row', `source_col' and find the complete expression text.
        require else
            non_void_source_text: source_text /= Void
            valid_source_text: not source_text.is_empty
            valid_source_row: source_row > 0
            valid_source_col: source_col > 0
            non_void_expr: expr /= Void
            expr_is_empty: expr.item.is_empty
            non_void_feat: feat /= Void
            feat_is_empty: feat.item.is_empty
            non_void_is_class_expr: is_class_expr /= Void
        local
            def_parser: DEFINITION_PARSER
        do
            create def_parser.make
            def_parser.parse (source_text, source_row, source_col)
            if def_parser.parse_successful then
                is_class_expr.set_item (def_parser.is_class)
                expr.put (def_parser.parsed_result)
                feat.put (def_parser.parsed_result_feature)
            end
        end

    find_definition (class_text, target_file_name: STRING; target_row, target_col: INTEGER; source_file_name: CELL [STRING]; source_row: INTEGER_REF) is
            -- Find `target' file name and location
        require else
            non_void_class_text: class_text /= Void
            valid_class_text: not class_text.is_empty
            non_void_target_file_name: target_file_name /= Void
            valid_target_file_name: not target_file_name.is_empty
            target_row_big_enough: target_row >= 1
            target_col_big_enough: target_col >= 1
            non_void_source_file_name: source_file_name /= Void
            source_file_name_is_empty: source_file_name.item.is_empty
            non_void_source_row: source_row /= Void
        local
            def_parser: DEFINITION_PARSER
 			fd: FEATURE_DESCRIPTOR
            ecom_var: ECOM_VARIANT
        do
            create def_parser.make
            def_parser.parse (class_text, target_row, target_col)
            if def_parser.parse_successful then
                if def_parser.is_class then
                    source_file_name.put (class_from_name (def_parser.parsed_result).file_name)
                    source_row.set_item (1)
                elseif def_parser.is_feature_call then
                    -- creates empty arguments and init feature
                    create ecom_var.make
                    ecom_var.set_string_array (create {ECOM_ARRAY [STRING]}.make_empty)
                    initialize_feature (def_parser.parsed_result_feature, ecom_var, ecom_var, def_parser.parsed_result_return_type, feature {ECOM_EIF_FEATURE_TYPES_ENUM}.eif_feature_types_function, target_file_name)
                    fd := target_feature (def_parser.parsed_result, def_parser.parsed_result_feature, target_file_name, false)
                    if fd /= Void then
                        fd.feature_location (source_file_name, source_row)
                    end
                end
            end
        end
        
    find_inherited_definition (class_text, a_class_name: STRING; target_row, target_col: INTEGER; source_file_name: CELL [STRING]; source_row: INTEGER_REF) is
            -- find definition for feature in inheritance clause
        require else
            non_void_class_text: class_text /= Void
            valid_class_text: not class_text.is_empty
            non_void_class_name: a_class_name /= Void
            valid_class_name: not a_class_name.is_empty
            target_row_big_enough: target_row >= 1
            target_col_big_enough: target_col >= 1
            non_void_source_file_name: source_file_name /= Void
            source_file_name_is_empty: source_file_name.item.is_empty
            non_void_source_row: source_row /= Void
        local
            retried: BOOLEAN
            classes: LIST [CLASS_I]
            ci: CLASS_I
             def_parser: DEFINITION_PARSER
            feat_name: STRING
            fd: FEATURE_DESCRIPTOR
        do
            if not retried then
                classes := Eiffel_universe.classes_with_name (a_class_name)
                if classes /= Void then
                    from 
                        classes.start
                    until
                        classes.after or ci /= Void
                    loop
                        if classes.item.is_compiled then
                            ci := classes.item
                        end
                        classes.forth
                    end
                    -- If inherited class is uncompiled then we can take first uncompiled class
                    if classes.count = 1 and then ci = Void then
                        ci := classes.first
                    end
                    if ci /= Void then
                        create def_parser.make
                        feat_name := def_parser.extract_feature_name_from_text (class_text, target_row, target_col)
                        if feat_name /= Void and then not feat_name.is_empty then
                            fd := target_feature (feat_name, "default_create", ci.file_name, False)
                            if fd /= Void then
                                fd.feature_location (source_file_name, source_row)
                            else
                                -- Check if feature name is actually a class name
                                classes := Eiffel_universe.classes_with_name (feat_name)
                                if classes.count >= 1 then
                                    source_row.set_item (1)
                                    source_file_name.put (classes.i_th (1).file_name)
                                end
                            end
                        end
                    end
                end
            end
        rescue
            retried := True
            retry
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
            if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not locals.has (name) then
                locals.put (clone (name), type)
            end
        end

    add_argument (name: STRING; type: STRING) is
            -- Add argument used for solving member completion list.
        do
            if name /= Void and type /= Void and then not name.is_empty and then not type.is_empty and then not arguments.has (name) then
                arguments.put (clone (name), type)
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
            completion_features.remove (l_file_name)
        end
        
    initialize_feature (a_name: STRING; a_arguments: ECOM_VARIANT; a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING) is
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
                l_ci := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (a_file_name))
                if l_ci /= Void then
                    if l_ci.compiled_class /= Void and then l_ci.compiled_class.has_feature_table then
                        l_fi := l_ci.compiled_class.feature_table.item (a_name.as_lower)
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
                        create l_feature.make (a_name, l_arguments, a_feature_type, a_file_name)
                    else
                        create l_feature.make_with_return_type (a_name, l_arguments, a_return_type, a_feature_type, a_file_name)
                    end
                    completion_features.search (a_file_name.as_lower)
                    if completion_features.found then
                        completion_features.found_item.extend (l_feature)
                    else
                        create feature_list.make (5)
                        feature_list.extend (l_feature)
                        completion_features.put (feature_list, a_file_name)
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
        
    initialize_feature_user_precondition (a_name: STRING; a_arguments, a_argument_types: ECOM_VARIANT; a_return_type: STRING; a_feature_type: INTEGER; a_file_name: STRING): BOOLEAN is
        do
            Result := False
        end 

feature {NONE} -- Implementation

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

    extract_variants_from_list (entries: LIST [COMPLETION_ENTRY]; return_names, return_signatures, return_image_indexes: ECOM_VARIANT) is
            -- Setup `return_names', `return_signatures' and `return_image_indexes' according to `entries'.
        require
            non_void_entries: entries /= Void
        local
            l_index, l_count: INTEGER
            l_names: ECOM_ARRAY [STRING]
            l_signatures: ECOM_ARRAY [STRING]
            l_image_indexes: ECOM_ARRAY [INTEGER]
            l_entry: COMPLETION_ENTRY
        do  
            l_count := entries.count
            if l_count > 0 then
                create l_names.make (1, <<1>>, <<l_count>>)
                create l_signatures.make (1, <<1>>, <<l_count>>)
                create l_image_indexes.make (1, <<1>>, <<l_count>>)
                from 
                    l_index := 1
                until
                    l_index > l_count
                loop
                    l_entry := entries.i_th (l_index)
                    l_names.put (clone (l_entry.name), <<l_index>>)
                    l_signatures.put (clone (l_entry.signature), <<l_index>>)
                    l_image_indexes.put (image_index (l_entry), <<l_index>>)
                    l_index := l_index + 1
                end
            else
                create l_names.make_empty
                create l_signatures.make_empty
                create l_image_indexes.make_empty
            end
            return_names.set_string_array (l_names)
            return_signatures.set_string_array (l_signatures)
            return_image_indexes.set_integer_array (l_image_indexes)
        ensure then
            non_void_names: return_names.string_array /= Void
            non_void_signatures: return_signatures.string_array /= Void
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
            Result := Eif_entity_images_variable
            if l_bool_ref.item then
                l_feature_descriptor ?= entry
                if l_feature_descriptor /= Void then
                    if l_feature_descriptor.is_constant or l_feature_descriptor.is_unique then
                        Result := Eif_entity_images_frozen_once
                    elseif l_feature_descriptor.is_attribute then
                        if l_feature_descriptor.is_obsolete then
                            Result := Eif_entity_images_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := Eif_entity_images_frozen_attribute
                        else
                            Result := Eif_entity_images_attribute
                        end
                    elseif l_feature_descriptor.is_once then
                        if l_feature_descriptor.is_obsolete then
                            Result := Eif_entity_images_obsolete
                        elseif l_feature_descriptor.is_frozen then
                            Result := Eif_entity_images_frozen_once
                        else
                            Result := Eif_entity_images_once
                        end
                    elseif l_feature_descriptor.is_obsolete then
                        Result := Eif_entity_images_obsolete
                    elseif l_feature_descriptor.is_frozen and l_feature_descriptor.is_external then
                        Result := Eif_entity_images_frozen_external
                    elseif l_feature_descriptor.is_frozen then
                        Result := Eif_entity_images_frozen_feature
                    elseif l_feature_descriptor.is_external then
                        Result := Eif_entity_images_external_feature
                    elseif l_feature_descriptor.is_deferred then
                        Result := Eif_entity_images_deferred
                    else
                        Result := Eif_entity_images_feature
                    end
                end
            end
        ensure
            valid_image_index: Result = eif_entity_images_frozen_once or Result = eif_entity_images_obsolete or
                    Result = eif_entity_images_frozen_attribute or Result = eif_entity_images_attribute or
                    Result = eif_entity_images_once or Result = eif_entity_images_frozen_external or
                    Result = eif_entity_images_frozen_feature or Result = eif_entity_images_external_feature or
                    Result = eif_entity_images_deferred or Result = eif_entity_images_feature or
                    Result = eif_entity_images_variable
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
        
invariant
    non_void_completion_features: completion_features /= Void

end -- class COMPLETION_INFORMATION
