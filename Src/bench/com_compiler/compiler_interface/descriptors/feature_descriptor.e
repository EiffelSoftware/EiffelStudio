indexing
    description: "Description of a feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class
    FEATURE_DESCRIPTOR

inherit
    IEIFFEL_FEATURE_DESCRIPTOR_IMPL_STUB
        undefine
            is_equal
        redefine
            name,
            external_name,
            written_class,
            evaluated_class,
            signature,
            description,
            exports,
            summary,
            all_callers,
            all_callers_count,
            local_callers,
            local_callers_count,
            descendant_callers,
            descendant_callers_count,
            implementers,
            implementers_count,
            ancestor_versions,
            ancestor_versions_count,
            descendant_versions,
            descendant_versions_count,
            exported_to_all,
            is_once,
            is_external,
            is_deferred,
            is_frozen,
            is_infix,
            is_prefix,
            is_attribute,
            is_procedure,
            is_function,
            is_unique,
            is_constant,
            is_obsolete,
            obsolete_message,
            has_precondition,
            preconditions,
            has_postcondition,
            postconditions,
            feature_location,
            parameters,
            return_type,
            member_of
        end

    COMPLETION_ENTRY
    	rename
    		signature as description
    	redefine
    		description
    	end

    SHARED_EIFFEL_PROJECT
        export {NONE}
            all
        undefine
            is_equal
        end

	COMPLETION_HELPERS
		export
			{NONE} all
        undefine
            is_equal
		end

create
    make_with_class_i_and_feature_i

feature {NONE} -- Initialization

    make_with_class_i_and_feature_i (a_class: CLASS_I; a_feature: FEATURE_I) is
            -- Initialize structure with `a_feature' evaluated in `a_class'.
        require
            a_class_not_void: a_class /= Void
            a_feature_not_void: a_feature /= Void
        do
            compiler_feature := a_feature
            compiler_class := a_class
        end

feature -- Access

    name: STRING is
            -- Feature name.
        do
        	if internal_name = Void then
	            internal_name := compiler_feature.feature_name.twin
	            if is_infix then
	                internal_name.replace_substring_all ("_infix_", "")
	                if internal_name.is_equal ("ge") then
	                    internal_name := ">="
	                elseif internal_name.is_equal ("gt") then
	                    internal_name := ">"
	                elseif internal_name.is_equal ("le") then
	                    internal_name := "<="
	                elseif internal_name.is_equal ("lt") then
	                    internal_name := "<"
	                elseif internal_name.is_equal ("and_then") then
	                    internal_name := "and then"
	                elseif internal_name.is_equal ("or_else") then
	                    internal_name := "or else"
	                elseif internal_name.is_equal ("minus") then
	                    internal_name := "-"
	                elseif internal_name.is_equal ("plus") then
	                    internal_name := "+"
	                elseif internal_name.is_equal ("power") then
	                    internal_name := "^"
	                elseif internal_name.is_equal ("slash") then
	                    internal_name := "/"
	                elseif internal_name.is_equal ("star") then
	                    internal_name := "*"
	                elseif internal_name.is_equal ("mod") then
	                    internal_name := "\\"
	                elseif internal_name.is_equal ("div") then
	                    internal_name := "//"
	                end
	            end
	            if is_prefix then
					internal_name.replace_substring_all ("_prefix_", "")
					if internal_name.is_equal ("minus") then
						internal_name := "-"
					elseif internal_name.is_equal ("plus") then
						internal_name := "+"
					end
				end
			end
			Result := internal_name
		ensure then
			result_exists: Result /= void
		end

    parameters: PARAMETER_ENUMERATOR is
            -- Feature parameters.
        local
            l_parameters: ARRAYED_LIST [PARAMETER_DESCRIPTOR]
            args: FEAT_ARG
        do
            if compiler_feature.has_arguments then
                args := compiler_feature.arguments
                create l_parameters.make (args.count)
                from
                    args.start
                until
                    args.after  
                loop
                    l_parameters.extend (create {PARAMETER_DESCRIPTOR}.make (args.item_name (args.index), args.item.dump))
                    args.forth
                end
            else
                create l_parameters.make (0)
            end
            create Result.make (l_parameters)
        end
    
    return_type: STRING is
            -- Feature return type
        do
            Result := compiler_feature.type.dump
        end
        
	exports: IEIFFEL_ENUM_STRING_INTERFACE is
			-- Exported classes
		local
			l_exp_set: EXPORT_SET_I
			l_list: ARRAYED_LIST [STRING]
			l_clients: LIST [STRING]
		do
			if compiler_feature.export_status.is_set then
				create l_list.make (4)
				l_list.compare_objects
				
				l_exp_set ?= compiler_feature.export_status
				check
					l_exp_set_not_void: l_exp_set /= Void	
				end
				if l_exp_set /= Void then
					from
						l_exp_set.start
					until
						l_exp_set.after
					loop
						l_clients := l_exp_set.item.clients
						if l_clients /= Void then
							from
								l_clients.start
							until
								l_clients.after
							loop
								if not l_list.has (l_clients.item) then
									l_list.extend (l_clients.item)
								end
								l_clients.forth
							end
						end
						l_exp_set.forth
					end
				end
			else
				create l_list.make (1)
				if compiler_feature.export_status.is_none then
					l_list.extend ("NONE")
				elseif compiler_feature.export_status.is_all then
					l_list.extend ("ANY")
				else
					l_list.extend ("[export clause not accounted for]")
				end
			end
			create {EIFFEL_STRING_ENUMERATOR}Result.make (l_list)
		end
        
    external_name: STRING is
            -- Feature external name.
        do
            Result := compiler_feature.external_name
        ensure then
            result_exists: Result /= Void
        end
        
    written_class: STRING is
            -- Name of the class where the feature is written in.
        do
            Result := compiler_feature.e_feature.associated_class.lace_class.name_in_upper
        ensure then
            result_exists: Result /= void           
        end

    evaluated_class: STRING is
            -- Name of the class where the feature was evaluated in.
        do
            Result := compiler_class.name_in_upper
        ensure then
            result_exists: Result /= void           
        end

	description: STRING is
			-- Feature description.
		local
			l_index: INTEGER
			l_overloads: STRING
			l_new_lines: BOOLEAN
		do
			if internal_description = Void then
	 			extract_description (compiler_feature, compiler_class, name)
	 			internal_description := extracted_description
	 			if overload_count >0 then
		 			l_index := internal_description.index_of ('%N', 1)
		 			l_new_lines := l_index > 0
		 			if l_new_lines then
		 				internal_description.remove (l_index)
		 			else
		 				l_index := Result.count + 1
		 			end
		 			create l_overloads.make (20)
		 			l_overloads.append (" (+")
		 			l_overloads.append (overload_count.out)
		 			l_overloads.append (" ")
		 			if overload_count = 1 then
		 				l_overloads.append ("overload")
		 			else
		 				l_overloads.append ("overloads")
		 			end
		 			l_overloads.append_character (')')
		 			if l_new_lines then
		 				l_overloads.append_character ('%N')
		 			end
		 			internal_description.insert_string (l_overloads, l_index)
	 			end
			end
			Result := internal_description
        ensure then
            result_exists: Result /= void           
        end

    signature: STRING is
            -- Feature signature.
            -- Do not use E_FEATURE as `name' might be different
        local
            type: TYPE_AS
            args: FEAT_ARG
        do
			create Result.make (50)
			Result.append (name)
			args := compiler_feature.arguments
			if args /= Void then
				Result.append (" (")
				from
					args.start
				until
					args.after
				loop
					Result.append (args.item_name (args.index))
					Result.append (": ")
					Result.append (args.item.dump)
					args.forth
					if not args.after then
						Result.append ("; ")
					end
				end
				Result.append (")")
			end
            type := compiler_feature.type          
            if type /= Void and then not type.is_void then
                Result.append (": ")
                Result.append (type.dump)
            end
         ensure then
            result_exists: Result /= void           
        end
        
	summary: STRING is
			-- Feature summary
		local
			l_desc: STRING
			l_lines: LIST [STRING]
			l_remove: BOOLEAN
			l_count: INTEGER
			l_comment_start: INTEGER
		do
			l_desc := description
			if l_desc /= Void and then not l_desc.is_empty then
				l_lines := l_desc.split ('%N')
				from
					l_lines.start	
					l_lines.forth
				until
					l_lines.after
				loop
					l_comment_start := l_lines.item.substring_index ("--", 1)
					if l_comment_start > 1  then
						if l_lines.item.count - (l_comment_start + 2) > 0 then
							if l_lines.item.substring (1, l_comment_start - 1).occurrences (' ') = l_comment_start - 1 then
									-- If nothing is before
								l_lines.item.keep_tail (l_lines.item.count - (l_comment_start + 2))
							end
						end
						l_lines.item.prune_all_leading (' ')
					end
					
					if not l_remove and then not l_lines.item.is_empty then
						if l_lines.item.count >= ensure_desc.count and then l_lines.item.substring (1, ensure_desc.count).is_equal (ensure_desc) then
							l_remove := True
						elseif l_lines.item.count >= require_desc.count and then l_lines.item.substring (1, require_desc.count).is_equal (require_desc) then
							l_remove := True
						end
					end
					if l_remove or l_lines.item.is_empty then
						l_lines.remove
					else
						l_count := l_count + l_lines.item.count + 2
						l_lines.forth
					end
				end
				create Result.make (l_count)
				if not l_lines.is_empty then
					from
						l_lines.start
						l_lines.forth
					until
						l_lines.after
					loop
						Result.append (l_lines.item)
						if not l_lines.islast then
							if l_lines.item.item (1) = '(' or l_lines.item.item (1) = ' ' or l_lines.item.item (1) = '%T' then
								Result.append_character ('%N')
							elseif l_lines.item.item (l_lines.item.count) /= ' ' then
								Result.append_character (' ')
							end
						end
						l_lines.forth
					end
				end
			end
		end

	overload_count: INTEGER
			-- Overload count, used for completion

    all_callers: FEATURE_ENUMERATOR is
            -- List of all feature callers, including callers of ancestor and descendant versions.
        local
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
        do
            res := all_callers_internal
            create Result.make (res)
        ensure then
            result_exists: Result /= Void
        end

    all_callers_count: INTEGER is
            -- Number of all callers.
        do
            Result := all_callers_internal.count
        end
        
    local_callers: FEATURE_ENUMERATOR is
            -- List of feature callers.
        local
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
        do
            res := local_callers_internal
            create Result.make (res)
        ensure then
            result_exists: Result /= Void
        end
        
    local_callers_count: INTEGER is
            -- Number of local callers.
        do
            Result := local_callers_internal.count
        end
        
    descendant_callers: FEATURE_ENUMERATOR is
            -- List of feature callers, including callers of descendant versions.
        local
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
        do
            res := descendant_callers_internal
            create Result.make (res)
        ensure then
            result_exists: Result /= Void
        end

    descendant_callers_count: INTEGER is
            -- Number of descendant callers.
        do
            Result := descendant_callers_internal.count
        end
        
    implementers: FEATURE_ENUMERATOR is
            -- List of implementers.
        local
            classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
            rout_id_set: ROUT_ID_SET
            rout_id: INTEGER
            current_feature: E_FEATURE
            current_class, written_cl, c: CLASS_C
            precursors: LIST [CLASS_C]
            rc, i: INTEGER
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
            desc: FEATURE_DESCRIPTOR
            feat: FEATURE_I
            written_in: INTEGER
        do
            current_class := compiler_class.compiled_class
            current_feature := compiler_feature.api_feature (current_class.class_id)
            written_cl := current_feature.written_class
            precursors := current_feature.precursors
            create classes.make
            record_descendants (classes, current_class)
            if not classes.has (current_class) then
                classes.extend (current_class)
            end
            if precursors /= Void then
                classes.append (precursors)
            end
            rout_id_set := current_feature.rout_id_set
            rc := rout_id_set.count
            create res.make (classes.count * rc)
            from
                i := 1
            until
                i > rc
            loop
                rout_id := rout_id_set.item (i)
                from
                    classes.start
                until
                    classes.after
                loop
                    c := classes.item
                    written_in := c.class_id
                    feat := c.feature_table.feature_of_rout_id (rout_id)
                    if feat /= Void and then feat.written_in = written_in then
                        create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (c.lace_class, feat)
                        res.extend (desc)
                    end
                    classes.forth
                end
                i := i + 1
            end
            create Result.make (res)
        ensure then
            result_exists: Result /= void           
        end

    implementers_count: INTEGER is
            -- Number of feature implementers.
        do
            Result := implementers.count
        end

    ancestor_versions: FEATURE_ENUMERATOR is
            -- List of ancestor versions.
        local
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
        do
            res := ancestor_versions_internal
            create Result.make (res)
        ensure then
            result_exists: Result /= void   
        end

    ancestor_versions_count: INTEGER is
            -- Number of ancestor versions.
        do
            Result := ancestor_versions_internal.count
        end
        
    descendant_versions: FEATURE_ENUMERATOR is
            -- List of descendant versions.
        local
            res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
        do
            res := descendant_versions_internal
            create Result.make (res)
        end

    descendant_versions_count: INTEGER is
            -- Number of descendant versions.
        do
            Result := descendant_versions_internal.count
        end
        
    exported_to_all: BOOLEAN is
            -- Is feature exported to all classes?
        do
            Result := compiler_feature.export_status.is_all
        end

    is_once: BOOLEAN is
            -- Is once feature?
        do
            Result := compiler_feature.is_once
        end

    is_external: BOOLEAN is
            -- Is external feature?
        do
            Result := compiler_feature.is_external and then not compiler_feature.is_il_external
        end

    is_deferred: BOOLEAN is
            -- Is deferred feature?
        do
            Result := compiler_feature.is_deferred
        end

    is_constant: BOOLEAN is
            -- Is constant?
        do
            Result := compiler_feature.is_constant
        end

    is_frozen: BOOLEAN is
            -- is frozen feature?
        do
            Result := compiler_feature.is_frozen
        end

    is_infix: BOOLEAN is
            -- Is infix?
        do
            Result := compiler_feature.is_infix
        end

    is_prefix: BOOLEAN is
            -- Is prefix?
        do
            Result := compiler_feature.is_prefix
        end

    is_attribute: BOOLEAN is
            -- Is attribute?
        do
            Result := compiler_feature.is_attribute
        end

    is_procedure: BOOLEAN is
            -- Is procedure?
        do
            Result := compiler_feature.is_routine and not compiler_feature.is_function
        end

    is_function: BOOLEAN is
            -- Is function?
        do
            Result := compiler_feature.is_function
        end

    is_unique: BOOLEAN is
            -- Is unique?
        do
            Result := compiler_feature.is_unique
        end

    is_obsolete: BOOLEAN is
            -- Is obsolete feature?
        do
            Result := compiler_feature.is_obsolete
        end
        
    obsolete_message: STRING is
            -- Obsolete message?
        do
            Result := compiler_feature.obsolete_message
        end

    has_precondition: BOOLEAN is
            -- Does feature have precondition?
        do
            Result := compiler_feature.has_precondition
        end
        
    preconditions: STRING is
            --  Feature preconditions
		local
			l_desc: like description
			l_lines: LIST [STRING]
			l_stop: BOOLEAN
        do
			l_desc := description
			if l_desc /= Void then
				l_lines := l_desc.split ('%N')
				from
					l_lines.start	
				until
					l_lines.after or l_stop
				loop
					if Result /= Void then
						if l_lines.item.count >= ensure_desc.count and then l_lines.item.substring (1, ensure_desc.count).is_equal (ensure_desc) then
							l_stop := True
						else
							if l_lines.item.count >= require_else_desc.count and then l_lines.item.substring (1, require_else_desc.count).is_equal (require_else_desc) then
								Result.append ("- require else -%N")
							else
								l_lines.item.prune_all_leading (' ')
								if not l_lines.item.is_empty then
									Result.append (l_lines.item)
									if not l_lines.islast then
										Result.append_character ('%N')	
									end									
								end
							end
							l_lines.forth
						end
					elseif not l_stop then
						if Result = Void and then l_lines.item.count >= require_desc.count and then l_lines.item.substring (1, require_desc.count).is_equal (require_desc) then
							create Result.make (350)
						end
						l_lines.forth
					end
				end
				if Result /= Void then
					Result.prune_all_trailing ('%N')
				end
			else
				create Result.make_empty
			end
        end

    has_postcondition: BOOLEAN is
            -- Does feature have postcondition?
        do
            Result := compiler_feature.has_postcondition
        end
        
    postconditions: STRING is
            -- Feature postconditions
		local
			l_desc: like description
			l_lines: LIST [STRING]
        do
			l_desc := description
			if l_desc /= Void then
				l_lines := l_desc.split ('%N')
				from
					l_lines.start	
				until
					l_lines.after
				loop
					if Result /= Void then
						if l_lines.item.count >= ensure_then_desc.count and then l_lines.item.substring (1, ensure_then_desc.count).is_equal (ensure_then_desc) then
							Result.append ("- ensure then -%N")
						else
							l_lines.item.prune_all_leading (' ')
							if not l_lines.item.is_empty then
								Result.append (l_lines.item)
								if not l_lines.islast then
									Result.append_character ('%N')	
								end
							end
						end
						l_lines.forth
					elseif l_lines.item.count >= ensure_desc.count and then l_lines.item.substring (1, ensure_desc.count).is_equal (ensure_desc) then
						create Result.make (350)
						l_lines.forth
					else
						l_lines.forth
					end
				end
				if Result /= Void then
					Result.prune_all_trailing ('%N')
				end				
			else
				create Result.make_empty
			end
        end

    is_feature (return_value: BOOLEAN_REF) is
            -- Is a feature (from COMPLETION_ENTRY)
        do
            return_value.set_item (True)
        end
        
	member_of: CLASS_DESCRIPTOR is
			-- Class feature is member of
		do
			create Result.make_with_class_i (compiler_class)
		end

feature -- Basic Operations

    feature_location (file_path: CELL [STRING]; line_number: INTEGER_REF) is
            -- Feature location, full path to file and line number
            -- `file_path' [in, out].  
            -- `line_number' [in, out].
        local
            start_position: INTEGER
            txt: STRING
            e_feature: E_FEATURE
            ast: FEATURE_AS
        do
            if file_path /= Void and line_number /= Void then
            	e_feature := compiler_feature.e_feature
                file_path.replace (e_feature.written_class.file_name)
                ast := e_feature.ast
                if ast /= Void then
                    -- AST may be Void for inherited features.
                    start_position := ast.start_position
                    txt := compiler_feature.written_class.lace_class.text.substring (1, start_position)
                    line_number.set_item (txt.occurrences ('%N'))                   
                end
            end
        end
	
feature {COMPLETION_HELPERS} -- Element settings

	set_name (a_name: like internal_name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			internal_name := a_name
		ensure
			name_set: name = a_name
		end
	
	increment_overload_count is
			-- Increment `overload_count'.
		do
			overload_count := overload_count + 1
		ensure
			overload_count_incremented: overload_count = old overload_count + 1
		end
		
feature {FEATURE_DESCRIPTOR} -- Implementation

    local_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
            -- Callers of `compiler_feature'.
        local
            client, current_class: CLASS_C
            clients: LIST [CLASS_C]
            list: SORTED_LIST [STRING]
            feat: FEATURE_I
            feat_desc: FEATURE_DESCRIPTOR
            i: INTEGER
        do
            create Result.make (Initial_array_size)
            current_class := compiler_class.compiled_class
            clients := current_class.clients
            from
                clients.start
                Result.start
            until
                clients.after
            loop
                client := clients.item
                list := compiler_feature.api_feature (current_class.class_id).callers (client, 0)
                if list /= Void then
                    from
                        list.start
                    until
                        list.after
                    loop
                        feat := client.feature_table.item (list.item)
                        if feat /= Void then
                            create feat_desc.make_with_class_i_and_feature_i (client.lace_class, feat)
                            Result.extend (feat_desc)
                        end
                        i := i + 1
                        list.forth
                    end
                end
                clients.forth
            end
        ensure
            result_exists: Result /= Void
        end

feature {NONE} -- Implementation

	require_desc: STRING is "require"
			-- require part of description to parse

	require_else_desc: STRING is "require else"
			-- require part of description to parse
		
	ensure_desc: STRING is "ensure"
			-- ensure part of description to parse

	ensure_then_desc: STRING is "ensure then"
			-- ensure then part of description to parse
			
	internal_description: like description
			-- cached description
			
	internal_name: STRING
			-- Feature name

    compiler_feature: FEATURE_I
            -- Associated compiler structure.
            
    compiler_class: CLASS_I
            -- Compiler structure ot the class `compiler_feature' was evaluated in.

    record_descendants (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; e_class: CLASS_C) is
            -- Record the descendants of `class_c' to `classes'.
        require
            valid_classes: classes /= Void
            valid_e_class: e_class /= Void
        local
            descendants: LIST [CLASS_C]
            desc_c: CLASS_C
        do
            descendants := e_class.descendants
            classes.extend (e_class)
            from
                descendants.start
            until
                descendants.after
            loop
                desc_c := descendants.item
                if not classes.has (desc_c) then
                    record_descendants (classes, desc_c)
                end
                descendants.forth
            end
        end

    record_parents (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; e_class: CLASS_C) is
            -- Record parents of `class_c' to `classes'.    
        local
            parents: FIXED_LIST [CL_TYPE_A]
            e_parent: CLASS_C
        do
            parents := e_class.parents
            classes.extend (e_class)
            from
                parents.start
            until
                parents.after
            loop
                e_parent := parents.item.associated_class
                if not classes.has (e_parent) then
                    record_parents (classes, e_parent)
                end
                parents.forth
            end
        end

    descendant_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
            -- Callers of `compiler_feature' and of its descendant versions.
        local
            desc_vers: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
            feat_desc: FEATURE_DESCRIPTOR
        do
            desc_vers := descendant_versions_internal
            Result := local_callers_internal
            from
                desc_vers.start
            until
                desc_vers.after
            loop
                feat_desc ?= desc_vers.item
                Result.finish
                Result.merge_right (feat_desc.local_callers_internal)
                desc_vers.forth
            end
        ensure
            result_exists: Result /= Void
        end
        
    all_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
            -- Callers of `compiler_feature' and of its descendant and ancestor versions.
        local
            vers: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
            feat_desc: FEATURE_DESCRIPTOR
        do
            vers := ancestor_versions_internal
            vers.finish
            vers.merge_right (descendant_versions_internal)
            Result := local_callers_internal
            from
                vers.start
            until
                vers.after
            loop
                feat_desc ?= vers.item
                Result.finish
                Result.merge_right (feat_desc.local_callers_internal)
                vers.forth
            end
        ensure
            result_exists: Result /= Void
        end
                
    ancestor_versions_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
            -- Ancestor versions of `compiler_feature'.
        local
            classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
            rout_id_set: ROUT_ID_SET
            rout_id, i: INTEGER
            current_feature: E_FEATURE
            other_feature: FEATURE_I
            c, current_class: CLASS_C
            desc: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
        do
            current_class := compiler_class.compiled_class
            current_feature := compiler_feature.api_feature (current_class.class_id)
            create classes.make
            record_parents (classes, current_class)
            classes.prune_all (current_class)

            rout_id_set := current_feature.rout_id_set
            create Result.make (0)
            from
                i := 1
            until
                i > rout_id_set.count
            loop
                rout_id := rout_id_set.item (i)
                from
                    classes.start
                until
                    classes.after
                loop
                    c := classes.item
                    other_feature := c.feature_table.origin_table.item (rout_id)
                    if other_feature /= Void then
                        create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (c.lace_class, other_feature)
                        Result.extend (desc)
                    end
                    classes.forth
                end
                i := i + 1
            end
        ensure
            result_exists: Result /= Void
        end

    descendant_versions_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
            -- Descendant versions of `compiler_feature'.
        local
            classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
            rout_id_set: ROUT_ID_SET
            rout_id, i: INTEGER
            other_feature: FEATURE_I
            e_class, current_class: CLASS_C
            current_feature: E_FEATURE
            desc: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
        do
            current_class := compiler_class.compiled_class
            current_feature := compiler_feature.api_feature (current_class.class_id)
            create classes.make
            record_descendants (classes, current_class)
            classes.prune_all (current_class)

            rout_id_set := current_feature.rout_id_set
            create Result.make (0)
            from
                i := 1
            until
                i > rout_id_set.count
            loop
                rout_id := rout_id_set.item (i)
                from
                    classes.start
                until
                    classes.after
                loop
                    e_class := classes.item
                    other_feature := e_class.feature_table.origin_table.item (rout_id)
                    if other_feature /= Void then
                        create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (e_class.lace_class, other_feature)
                        Result.extend (desc)
                    end
                    classes.forth
                end
                i := i + 1
            end
        ensure
            result_exists: Result /= Void
        end
        
    Initial_array_size: INTEGER is 0;

            
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
end -- class FEATURE_DESCRIPTOR
