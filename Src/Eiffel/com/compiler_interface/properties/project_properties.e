indexing
    description: "Information on the ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

class
    PROJECT_PROPERTIES

inherit
    IEIFFEL_PROJECT_PROPERTIES_IMPL_STUB
        redefine
            system_name,
            set_system_name,
            root_class_name,
            set_root_class_name,
            creation_routine,
            set_creation_routine,
            namespace_generation,
            set_namespace_generation,
            default_namespace,
            set_default_namespace,
            project_type,
            set_project_type,
            dot_net_naming_convention,
            set_dot_net_naming_convention,
            target_clr_version,
            set_target_clr_version,
            generate_debug_info,
            set_generate_debug_info,
            precompiled_library,
            set_precompiled_library,
            assertions,
            set_assertions,
            clusters,
            externals,
            assemblies,
            title,
            set_title,
            description,
            set_description,
            company,
            set_company,
            product,
            set_product,
            version,
            set_version,
            trademark,
            set_trademark,
            copyright,
            set_copyright,
            culture,
            set_culture,
            key_file_name,
            set_key_file_name,
            working_directory,
            set_working_directory,
            apply,
            set_metadata_cache_path
        end
    
    SHARED_EIFFEL_PROJECT
        export {NONE}
            all
        end
        
    ECOM_EXCEPTION
    	export {NONE}
    		all
    	end
    	
    ECOM_EXCEPTION_CODES
    	export {NONE}
    		all
    	end


create
    make,
    make_from_project,
    make_in_memory

feature {NONE} -- Initialization

    make is
            -- Initialize structure.
        require
            initialized: Eiffel_project.initialized
        do
        	if (create {RAW_FILE}.make (Eiffel_ace.file_name)).exists then
	            create ace.make (Eiffel_ace.file_name)
				if not msil_generation then
					ace.set_il_generation (True)
				end        		
			else
					-- There is no ace file so create properties from project.
				make_from_project
        	end
        end
    
    make_from_project is
    		-- Initializes properties from project rather than ace
    	do
    		create ace.make_from_ast (eiffel_project.ace.ast)
    	end
    
    make_in_memory is
    		-- Initialize properties from in memory ace AST
       require
            initialized: Eiffel_project.initialized
        do
            create ace.make_in_memory
			if not msil_generation then
				ace.set_il_generation (True)
			end
        end   	
    	
feature -- Access
    
    system_name: STRING is
            -- System name.
        do
            Result := ace.system_name
        end
    
    root_class_name: STRING is
            -- Root class name.
        do
            Result := ace.root_class_name
        end
    
    creation_routine: STRING is
            -- Creation routine name.
        do
            Result := ace.creation_routine_name
        end
        
    namespace_generation: INTEGER is
            -- Namespace generation for cluster
        do
            if ace.use_cluster_name_as_namespace then
                Result := feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_cluster_name
            elseif ace.use_all_cluster_name_as_namespace then
                Result := feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_full_cluster_name
            else
                Result := feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_none                
            end
        ensure then
            valid_result:
                Result >= feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_none and then
                Result <= feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_full_cluster_name
        end
        
    default_namespace: STRING is
            -- Default namespace
        do
            Result := ace.default_namespace
        end

    project_type: INTEGER is
            -- Project type
        local
            l_console: BOOLEAN
            l_dll: BOOLEAN
            l_root_class_name: STRING
        do
            l_console := ace.is_console_application
            l_root_class_name := ace.root_class_name.twin
            l_root_class_name.to_upper
            l_dll := ace.il_generation_type = ace.Il_generation_dll
            
            if l_dll then
                Result := feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_class_library
            else
                if l_console then
                    Result := feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_console_application
                else
                    Result := feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_windows_application
                end
            end
        ensure then
            valid_result:
                Result >= feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_console_application and then
                Result <= feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_class_library
        end
        
    dot_net_naming_convention: BOOLEAN is
            -- .NET Naming convention
        do
            Result := ace.dot_net_naming_convention
        end
        
    target_clr_version: STRING is
            -- Version of CLR to target
        do
            Result := ace.target_clr_version
        end
        
    generate_debug_info: BOOLEAN is
            -- Generate debug info?
        do
            Result := ace.line_generation
        end
        
    precompiled_library: STRING is
            -- Precompiled library
        do
            Result := ace.precompiled
        end
        
    assertions: INTEGER is
            -- Project assertions
        do
            if ace.require_evaluated then
                Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_require
            end
            if ace.ensure_evaluated then
                Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_ensure
            end
            if ace.check_evaluated then             
                Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_check
            end
            if ace.invariant_evaluated then
                Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_invariant
            end
            if ace.loop_evaluated then
                Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_loop
            end
        ensure then
            valid_result: Result >= 0
        end
        
    clusters: SYSTEM_CLUSTERS is
            -- List of clusters in current project (list of IEiffelClusterProperties*).
       	once
            create Result.make (ace)
        end
        
    externals: SYSTEM_EXTERNALS is
            -- List of the externals in the current project (IEiffelExternalProperties*)
        once
            create Result.make (ace)
        end
        
    assemblies: SYSTEM_ASSEMBLIES is
            -- System assemblies
        once
            create Result.make (ace)
        end
        
    title: STRING is
            -- Title of the system
        do
            Result := ace.title
        end
        
    description: STRING is 
            -- Description of the system
        do
            Result := ace.description
        end
        
    company: STRING is
            -- Company that own the system
        do
            Result := ace.company
        end
        
    product: STRING is
            -- Product information
        do
            Result := ace.product
        end
        
    version: STRING is
            -- Four part version number for system
        do
            Result := ace.version
        end

    trademark: STRING is
            -- Trademark related information
        do
            Result := ace.trademark
        end
        
    copyright: STRING is
            -- Copyright information
        do
            Result := ace.copyright
        end
        
    culture: STRING is
            -- Assembly culture (short code - 'en-gb' etc.)
        do
            Result := ace.msil_culture
        end
    
    key_file_name: STRING is
            -- assembly sign key filename
        do
            Result := ace.msil_key_file_name
        end
        
    working_directory: STRING is
            -- system working directory
        do
            Result := ace.working_directory
        end
        
feature {PROJECT_MANAGER} -- Access     

    msil_generation: BOOLEAN is
            -- Msil generation
        do
            Result := ace.msil_generation
        end
        
feature -- Element change

    set_system_name (a_system_name: STRING) is
            -- Assign `a_system_name' to system name.
        require else
            non_void_system_name: a_system_name /= Void
            valid_system_name: not a_system_name.is_empty
        do
            if a_system_name /= Void and then not a_system_name.is_empty then
                ace.set_system_name (a_system_name)
            end
        end
        
    set_root_class_name (a_name: STRING) is
            -- Assign `return_value' to root class name.
        require else
            non_void_name: a_name /= Void
            valid_name: not a_name.is_empty
        do
            if a_name /= Void and then not a_name.is_empty then
                ace.set_root_class_name (a_name)
            end
        end
    
    set_creation_routine (a_routine: STRING) is
            -- Assign `return_value' to creation routine name.
        do
            ace.set_creation_routine_name (a_routine)
        end
        
    set_namespace_generation (a_namespace_generation: INTEGER) is
            -- Assign `a_namespace_generation' to namespace generation for cluster
        require else
            valid_namespace_generation:
                a_namespace_generation >= feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_none and then
                a_namespace_generation <= feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_full_cluster_name
        do
            if a_namespace_generation = feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_none then
                ace.set_use_cluster_name_as_namespace (False)
                ace.set_use_all_cluster_name_as_namespace (False)
            elseif a_namespace_generation = feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_cluster_name then
                ace.set_use_cluster_name_as_namespace (True)
                ace.set_use_all_cluster_name_as_namespace (False)
            elseif a_namespace_generation = feature {ECOM_EIF_CLUSTER_NAMESPACE_GENERATION_ENUM}.eif_cluster_namespace_generation_full_cluster_name then
                ace.set_use_cluster_name_as_namespace (False)
                ace.set_use_all_cluster_name_as_namespace (True)
            end
        end

    set_default_namespace (a_namespace: STRING) is
            -- Assign `a_namespace' to default namespace.
        do
            ace.set_default_namespace (a_namespace)
        end
        
    set_project_type (a_project_type: INTEGER) is
            -- Assign `a_project_type' to project type
        require else
            valid_project_type:
                a_project_type >= feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_console_application and then
                a_project_type <= feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_class_library
        do
            if a_project_type = feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_console_application then
                ace.set_console_application (True)
                ace.set_il_generation_type (ace.Il_generation_exe)
            elseif a_project_type = feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_windows_application then
                ace.set_console_application (False)
                ace.set_il_generation_type (ace.Il_generation_exe)
            elseif a_project_type = feature {ECOM_EIF_PROJECT_TYPES_ENUM}.eif_project_types_class_library then
                ace.set_console_application (False)
                ace.set_il_generation_type (ace.Il_generation_dll)
            end 
        end
        
    set_dot_net_naming_convention (a_use_convention: BOOLEAN) is
            -- Assign `a_use_convention' to dot net naming convention
        do
            ace.set_dot_net_naming_convention (a_use_convention)
        end
        
    set_target_clr_version (a_version: STRING) is
            -- Assign 'a_version' to Version of CLR to target
        do
        	if (valid_clr_versions.has (a_version)) then
	            ace.set_target_clr_version (a_version)        		
        	end
        end
        
    set_generate_debug_info (a_generate_debug_info: BOOLEAN) is
            -- Generate debug info?
        do
            ace.set_line_generation (a_generate_debug_info)
        end
        
    set_precompiled_library (a_path: STRING) is
            -- Set precompiled to `a_path' 
        do
            ace.set_precompiled (a_path)
        end
        
    set_assertions (a_assertions: INTEGER) is
            -- Set project assertions dependant on `a_assertions' value
        require else
            valid_assertions: 
                a_assertions >= 0 and then 
                a_assertions <= feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_require + 
                    feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_ensure +
                    feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_check +
                    feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_invariant +
                    feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_loop
        local
            l_require: BOOLEAN
            l_ensure: BOOLEAN
            l_check: BOOLEAN
            l_invariant: BOOLEAN
            l_loop: BOOLEAN
        do
            if a_assertions > 0 then
                l_require := a_assertions.bit_and (feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_require) /= 0
                l_ensure := a_assertions.bit_and (feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_ensure) /= 0
                l_check := a_assertions.bit_and (feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_check) /= 0
                l_invariant := a_assertions.bit_and (feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_invariant) /= 0
                l_loop := a_assertions.bit_and (feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_loop) /= 0    
            end

            ace.set_assertions (l_require, l_ensure, l_check, l_loop, l_invariant)
        end
        
    set_title(a_title: STRING) is
            -- Set title of the system
        do
            ace.set_title (a_title)
        end
        
    set_description (a_description: STRING) is 
            -- Set description of the system
        do
            ace.set_description (a_description)
        end
        
    set_company (a_company: STRING) is
            -- Set company that own the system
        do
            ace.set_company (a_company)
        end
        
    set_product (a_product: STRING) is
            -- Set product information
        do
            ace.set_product (a_product)
        end
        
    set_version (a_version: STRING) is
            -- Set the four part version number for system
        do
            ace.set_version (a_version)
        end
    
    set_trademark (a_trademark: STRING) is
            -- Set trademark related information
        do
            ace.set_trademark (a_trademark)
        end
        
    set_copyright (a_copyright: STRING) is
            -- Set copyright information
        do
            ace.set_copyright (a_copyright)
        end

    set_culture (a_culture: STRING) is
            -- Set assembly culture (short code - 'en-gb' etc.)
        do
            ace.set_msil_culture (a_culture)
        end
        
    set_key_file_name (a_filename: STRING) is 
            -- Set the assembly sign key file name
        do
            ace.set_msil_key_file_name (a_filename)
        end
        
    set_working_directory (a_directory: STRING) is 
            -- Set the systems working directory
        do
            ace.set_working_directory (a_directory)
        end
        
    set_metadata_cache_path (a_path: STRING) is 
            -- Set path to EAC.
        do
            ace.set_metadata_cache_path (a_path)
        end
        
feature -- Basic operations

    apply is
            -- Apply changes.
        do
           	clusters.store
           	externals.store
           	assemblies.store
			ace.apply
        end

feature {NONE} -- Implementation

    ace: ACE_FILE_ACCESSER
            -- Access to the Ace file.
            
    valid_clr_versions: ARRAYED_LIST [STRING] is
    		-- valid version of CLR
    	once
    		create Result.make_from_array(<<"v1.0.3705", "v1.1.4322">>)
    		Result.compare_objects
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
end -- class PROJECT_PROPERTIES
