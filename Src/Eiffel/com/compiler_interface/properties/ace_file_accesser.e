indexing
	description: "Facilities for accessing and modifying project properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ACE_FILE_ACCESSER

inherit
	LACE_AST_FACTORY
		export {NONE}
			all
		end

	SHARED_LACE_PARSER
		export {NONE}
			all
		end
		
create
	make,
	make_from_ast,
	make_in_memory

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
			-- Initialize ast.
		do
			ace_file_name := a_file_name
			if ace_file_name = Void then
				ace_file_name := default_ace_file_name.twin
			end
			root_ast := parsed_ast (ace_file_name)
			if root_ast = Void then
				create root_ast
			end
		ensure
			non_void_ast: root_ast /= Void
		end
		
	make_from_ast (a_ast: like root_ast) is
			-- Initialize `root_ast' with `a_ast'
		require
			a_ast_not_void: a_ast /= Void
		do
			root_ast := a_ast
		ensure
			root_ast_set: root_ast = a_ast
		end

	make_in_memory is
			-- Initialize AST in memory.
		do
			create root_ast
		ensure
			non_void_ast: root_ast /= Void
		end
		
feature{NONE} -- Access
	
	string_default(def_opt: INTEGER): STRING is
			-- retrieve the string default option corresponding to 'def_opt'
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			found: BOOLEAN
		do
			Result := ""
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after or found
			loop
				if l_defaults.item.option.is_free_option then
					free_opt ?= l_defaults.item.option
					if free_opt.code = def_opt then
						found := true
						Result := l_defaults.item.value.value
					end
				end
				l_defaults.forth
			end
		ensure
			non_void_result: Result /= Void
		end
		
	boolean_default(def_opt:INTEGER): BOOLEAN is
			-- retrieve the boolean default option corresponding to 'def_opt'
		require
			valid_default: def_opt >= 0
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			found: BOOLEAN
		do
			l_defaults := defaults
			from
				l_defaults.start
			until
				found or l_defaults.after
			loop
				if l_defaults.item.option.is_free_option then
					free_opt ?= l_defaults.item.option
					if free_opt.code = def_opt then
						found := true
						Result := l_defaults.item.value.is_yes
					end
				end
				l_defaults.forth
			end
		end
		
feature -- Access

	ace_file_name: STRING 
			-- Name of ace file

	root_ast: ACE_SD
			-- Parsed/Newly created Ace file

	system_name: STRING is
			-- System name.
		do
			Result := root_ast.system_name
		end
		
	root_class_name: STRING is
			-- Root class name.
		do
			if root_ast.root /= Void then
				Result := root_ast.root.root_name.twin
			end
		end

	creation_routine_name: STRING is
			-- Creation routine name.
		do
			if root_ast.root /= Void then
				Result := root_ast.root.creation_procedure_name
			end
		end
		
	dot_net_naming_convention: BOOLEAN is
			-- .NET naming convention
		do
			Result := boolean_default(feature {FREE_OPTION_SD}.Dotnet_naming_convention)
		end
		
	target_clr_version: STRING is
			-- Version number of CLR compiler targets
		do
			Result := string_default(feature {FREE_OPTION_SD}.Msil_clr_version)
		end
			
	use_cluster_name_as_namespace: BOOLEAN is
			-- should cluster name be used as namespace name?
		do
			Result := boolean_default (feature {FREE_OPTION_SD}.Use_cluster_name_as_namespace)
		end
		
	use_all_cluster_name_as_namespace: BOOLEAN is
			-- should full cluster name be used as namespace name?
		do
			Result := boolean_default (feature {FREE_OPTION_SD}.Use_all_cluster_name_as_namespace)
		end
		
	require_evaluated: BOOLEAN is
			-- Are preconditions evaluated?
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			l_defaults := defaults
			from
				l_defaults.start
			until
				Result or else l_defaults.after
			loop
				opt := l_defaults.item.option
				if opt.is_assertion then
					val := l_defaults.item.value
					if val.is_require or else val.is_all then
						Result := True
					end
				end
				l_defaults.forth
			end
		end
		
	ensure_evaluated: BOOLEAN is
			-- Are postconditions evaluated?
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			l_defaults := defaults
			if l_defaults /= Void then
				from
					l_defaults.start
				until
					Result or else l_defaults.after
				loop
					opt := l_defaults.item.option
					if opt.is_assertion then
						val := l_defaults.item.value
						if val.is_ensure or else val.is_all then
							Result := True
						end
					end
					l_defaults.forth
				end
			end
		end

	check_evaluated: BOOLEAN is
			-- Are check statements evaluated?
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			l_defaults := defaults
			from
				l_defaults.start
			until
				Result or else l_defaults.after
			loop
				opt := l_defaults.item.option
				if opt.is_assertion then
					val := l_defaults.item.value
					if val.is_check or else val.is_all then
						Result := True
					end
				end
				l_defaults.forth
			end
		end

	loop_evaluated: BOOLEAN is
			-- Are loop assertions evaluated?
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			l_defaults := defaults
			from
				l_defaults.start
			until
				Result or else l_defaults.after
			loop
				opt := l_defaults.item.option
				if opt.is_assertion then
					val := l_defaults.item.value
					if val.is_loop or else val.is_all then
						Result := True
					end
				end
				l_defaults.forth
			end		
		end

	invariant_evaluated: BOOLEAN is
			-- Are invariants evaluated?
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			l_defaults := defaults
			from
				l_defaults.start
			until
				Result or else l_defaults.after
			loop
				opt := l_defaults.item.option
				if opt.is_assertion then
					val := l_defaults.item.value
					if val.is_invariant or else val.is_all then
						Result := True
					end
				end
				l_defaults.forth
			end
		end

	precompiled: STRING is
			-- Precompiled file
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			found: BOOLEAN
		do
			Result := ""
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after or found
			loop
				if l_defaults.item.option.is_precompiled then
					found := true
					Result := l_defaults.item.value.value
				end
				l_defaults.forth
			end
		ensure
			non_void_result: Result /= Void
		end
		

	working_directory: STRING is
			-- Application working directory.
		do
			Result := string_default(feature {FREE_OPTION_SD}.Working_directory);	
		end
		
	il_generation: BOOLEAN is
			-- Is IL code generated?
		do
			Result := boolean_default(feature {FREE_OPTION_SD}.Msil_generation);	
		end

	il_generation_type: INTEGER is
			-- Type of the IL file generated if any.
		local
			value: STRING
		do
			value := string_default(feature {FREE_OPTION_SD}.Msil_generation_type);	
			if value.is_equal ("exe") then
				Result := il_generation_exe
			elseif value.is_equal ("dll") then
				Result := il_generation_dll
			else
				Result := il_generation_no
			end
		ensure
			known_result: Result = il_generation_no
				or	Result = il_generation_exe
				or Result = il_generation_dll
		end
		
	default_namespace: STRING is
			-- Default namespace for system.
		do
			Result := string_default(feature {FREE_OPTION_SD}.Namespace);	
		end
		
	override_cluster: STRING is
			-- Name of the override cluster.
		do
			Result := string_default(feature {FREE_OPTION_SD}.Override_cluster)
		end

		
		
	is_console_application: BOOLEAN is
			-- Does application use console mode?
		do
			Result := boolean_default(feature {FREE_OPTION_SD}.Console_application);	
		end

	line_generation: BOOLEAN is
			-- Line generation status for current system.
		do
			Result := boolean_default(feature {FREE_OPTION_SD}.Line_generation);	
		end
	
	title: STRING is
			-- Title of the system
		do
			Result := string_default(feature {FREE_OPTION_SD}.title)
		end
		
	description: STRING is
			-- Description of the system
		do
			Result := string_default(feature {FREE_OPTION_SD}.description)
		end
		
	company: STRING is
			-- Ownership of the system
		do
			Result := string_default(feature {FREE_OPTION_SD}.company)
		end
		
	product: STRING is
			-- product label
		do
			Result := string_default(feature {FREE_OPTION_SD}.product)
		end
		
	copyright: STRING is
			-- system copyright information
		do
			Result := string_default(feature {FREE_OPTION_SD}.copyright)
		end
		
	trademark: STRING is
			-- system trademark information
		do
			Result := string_default(feature {FREE_OPTION_SD}.trademark)
		end
		
	version: STRING is
			-- system version number
		do
			Result := string_default(feature {FREE_OPTION_SD}.version)
		end	
		
	msil_key_file_name: STRING is
			-- msil assembly signable key file name
		do
			Result := string_default(feature {FREE_OPTION_SD}.msil_key_file_name)
		end
		
	msil_culture: STRING is
			-- msil assembly signable key file name
		do
			Result := string_default(feature {FREE_OPTION_SD}.Msil_culture)
		end
		
	msil_generation: BOOLEAN is
			-- msil generation 
		do
			Result := boolean_default(feature {FREE_OPTION_SD}.Msil_generation)
		end
		
		
feature{NONE} -- Element change

	set_string_default (def_opt:INTEGER; new_value: STRING) is
			-- Set the default
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after
			loop
				is_item_removable := False
				if l_defaults.item.option.is_free_option then
					free_opt ?= l_defaults.item.option
					if free_opt.code = def_opt then
						is_item_removable := True
					end
				end
				if is_item_removable then
					l_defaults.remove
				else
					l_defaults.forth
				end
			end
			if new_value /= Void and then new_value.count > 0 then
				l_defaults.extend (new_special_option_sd (def_opt, new_value , True))
			end
			
		end

	set_boolean_default (def_opt: INTEGER; new_value: BOOLEAN) is
			-- Set a default boolean option
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after
			loop
				is_item_removable := False
				if l_defaults.item.option.is_free_option then
					free_opt ?= l_defaults.item.option
					if free_opt.code = def_opt then
						is_item_removable := True
					end
				end
				if is_item_removable then
					l_defaults.remove
				else
					l_defaults.forth
				end
			end
			l_defaults.extend (new_special_option_sd (def_opt, Void, new_value))
		end

feature -- Element change

	set_system_name (new_name: STRING) is
			-- Assign `new_name' to system name.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			root_ast.set_system_name (new_id_sd (new_name, true))
		end
		
	set_root_class_name (new_name: STRING) is
			-- Set class named `new_name' as new root class.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		local
			id_sd: ID_SD
			root: ROOT_SD
		do
			if root_ast.root = Void then
				create id_sd.initialize (new_name)
				create root.initialize (id_sd, Void, Void)
				root_ast.set_root (root)
			else
				root_ast.root.set_root_name (new_id_sd (new_name, True))
			end
		end

	set_creation_routine_name (new_name: STRING) is
			-- Set `a_creation_routine_name' as new creation routine.
		do
			if new_name /= Void and not new_name.is_empty then
				root_ast.root.set_creation_procedure_name (new_id_sd (new_name, True))
			else
				root_ast.root.set_creation_procedure_name (Void)
			end

		end
		
	set_dot_net_naming_convention (a_use_convention: BOOLEAN) is
			-- .NET naming convention
		do
			set_boolean_default (feature {FREE_OPTION_SD}.Dotnet_naming_convention, a_use_convention)
		end

	set_target_clr_version (a_version: STRING) is
			-- Set version number of CLR compiler targets
		require else
			valid_version: clr_versions.has(a_version)
		do
			set_string_default(feature {FREE_OPTION_SD}.Msil_clr_version, a_version)
		end

	set_assertions (evaluate_require, evaluate_ensure, evaluate_check, evaluate_loop, evaluate_invariant: BOOLEAN) is
			-- Change assertion settings.
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
			had_assertion: BOOLEAN
		do
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after
			loop
				if l_defaults.item.option.is_assertion then
					l_defaults.remove
				else
					l_defaults.forth
				end
			end
			
			had_assertion := False
			if evaluate_invariant then
				had_assertion := True
				create v.make_invariant
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)
			end			
			if evaluate_loop then
				had_assertion := True
				create v.make_loop
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)	
			end
			if evaluate_check then
				had_assertion := True
				create v.make_check
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)	
			end
			if evaluate_ensure then
				had_assertion := True
				create v.make_ensure
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)	
			end
			if evaluate_require then
				had_assertion := True
				create v.make_require
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)	
			end
			if not had_assertion then
				create v.make_no
				create ass
				create d_option.initialize (ass, v)
				l_defaults.put_front (d_option)	
			end		
		end
		
	set_precompiled (filename: STRING) is
			-- Set precompiled default option with 'filename'
		local
			l_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			found: BOOLEAN
			value: ID_SD 
			d_option: D_OPTION_SD
		do
			l_defaults := defaults
			from
				l_defaults.start
			until
				l_defaults.after or found
			loop
				opt := l_defaults.item.option
				if opt.is_precompiled then
					l_defaults.remove
					found := True
				end
				l_defaults.forth
			end
			
			if filename /= Void and not filename.is_empty then
				value := new_id_sd (filename, true)
				create d_option.initialize (create {PRECOMPILED_SD}, create {OPT_VAL_SD}.make (value))
				l_defaults.extend (d_option)				
			end
		end
		

	set_il_generation (b: BOOLEAN) is
			-- Generate IL code if `b'.
		do
			set_boolean_default(feature {FREE_OPTION_SD}.Msil_generation, b)			
		end

	set_il_generation_type (type: INTEGER) is
			-- Set IL generation type to `type'.
			-- If `type' is unknown or `Il_generation_no', remove IL generation.
		do
			if type = Il_generation_exe then
				set_string_default(feature {FREE_OPTION_SD}.Msil_generation_type, "exe")
			elseif type = Il_generation_dll then
				set_string_default(feature {FREE_OPTION_SD}.Msil_generation_type, "dll")
			end
		end

	set_default_namespace (namespace: STRING) is
			-- Set the default namespace
		do
			set_string_default(feature {FREE_OPTION_SD}.Namespace, namespace)
		end
		
	set_use_cluster_name_as_namespace (a_new_value: BOOLEAN) is
			-- set use_cluster_name_as_namespace with `a_new_value'
		do
			set_boolean_default (feature {FREE_OPTION_SD}.Use_cluster_name_as_namespace, a_new_value)
		end

	set_use_all_cluster_name_as_namespace (a_new_value: BOOLEAN) is
			-- set use_all_cluster_name_as_namespace with `a_new_value'
		do
			set_boolean_default (feature {FREE_OPTION_SD}.Use_all_cluster_name_as_namespace, a_new_value)
		end
		
		
	set_working_directory (directory: STRING) is
			-- Set the system's working directory
		do
			set_string_default(feature {FREE_OPTION_SD}.Working_directory, directory)
		end
		
	set_console_application (b: BOOLEAN) is
			-- Set `is_console_application' to `b'.
		do
			set_boolean_default(feature {FREE_OPTION_SD}.Console_application, b)
		end
		
	set_line_generation (b: BOOLEAN) is
			-- Generate debug information if `b'.
		do
			set_boolean_default(feature {FREE_OPTION_SD}.Line_generation, b)
		end
		
	set_override_cluster (name: STRING) is
			-- Set cluster named `name' as override cluster.
		do
			set_string_default(feature {FREE_OPTION_SD}.Override_cluster, name)
		end
		
	set_title (new_value: STRING) is
			-- Set the Title of the system
		do
			set_string_default(feature {FREE_OPTION_SD}.title, new_value)
		end
		
	set_description (new_value: STRING) is
			-- Set the Description of the system
		do
			set_string_default(feature {FREE_OPTION_SD}.description, new_value)
		end
		
	set_company (new_value: STRING) is
			-- Set the Ownership of the system
		do
			set_string_default(feature {FREE_OPTION_SD}.company, new_value)
		end
		
	set_product (new_value: STRING) is
			-- Set the product label
		do
			set_string_default(feature {FREE_OPTION_SD}.product, new_value)
		end
		
	set_copyright (new_value: STRING) is
			-- Set the system copyright information
		do
			set_string_default(feature {FREE_OPTION_SD}.copyright, new_value)
		end
		
	set_trademark (new_value: STRING) is
			-- Set the system trademark information
		do
			set_string_default(feature {FREE_OPTION_SD}.trademark, new_value)
		end
		
	set_version (new_value: STRING) is
			-- Set the system version number
		do
			set_string_default(feature {FREE_OPTION_SD}.version, new_value)
		end	
		
	set_msil_key_file_name (new_value: STRING) is
			-- Set the msil assembly signable key file name
		do
			set_string_default(feature {FREE_OPTION_SD}.msil_key_file_name, new_value)
		end
		
	set_msil_culture (new_value: STRING) is
			-- Set the msil assembly's culture
		do
			set_string_default(feature {FREE_OPTION_SD}.Msil_culture, new_value)
		end
		
	set_metadata_cache_path (new_value: STRING) is
			-- Set EAC path
		do
			set_string_default(feature {FREE_OPTION_SD}.Metadata_cache_path, new_value)
		end
		
feature -- Status report

	last_error_message: STRING
			-- Message describing possible errors in `make' and `apply'.

feature -- Saving

	apply is
			-- Store `root_ast' in ace file.
		local
			st: GENERATION_BUFFER
			ace_file, backup_file: PLAIN_TEXT_FILE
			ast: like root_ast			
		do
			ast := root_ast.duplicate
			create st.make (2048)
			ast.save (st)
			create ace_file.make (ace_file_name)
			if not ace_file.exists or else ace_file.is_writable then
					-- Save a backup_file
				create backup_file.make_open_write (ace_file_name + ".swp")
				ace_file.open_read
				ace_file.copy_to (backup_file)
				backup_file.close
				ace_file.close

				ace_file.open_write
				st.put_in_file (ace_file)
				ace_file.close
				successful_save := True
			else
					-- Could not save Ace file
				successful_save := False
				last_error_message := Warning_messages.W_not_creatable (ace_file_name)
			end
		ensure
			successful_save: successful_save
		end
		
feature -- Environment

	ise_eiffel: STRING is 
			-- Return the ISE_EIFFEL environment var
		local
			env: EIFFEL_ENV
		do
			create env
			Result := env.Eiffel_installation_dir_name
		end
		
	ise_eiffel_envvar: STRING is "$ISE_EIFFEL"
		
	library_path: STRING is 
		once
			Result := ise_eiffel.twin
			Result.append ("\library")
		ensure
			non_void_result: Result /= Void
			empty_result: not Result.is_empty
		end
	
	library_dotnet_path: STRING is
		once
			Result := ise_eiffel.twin
			Result.append ("\library.net")
		ensure
			non_void_result: Result /= Void
			empty_result: not Result.is_empty
		end
		
	reserved_keywords: LINKED_LIST [STRING] is
			-- List of all of the word reserved by the ace file
		do
			Result := ace_dictionary.reserved_keywords;			
		end

	clr_versions: LINKED_LIST[STRING] is
			-- valid versions of CLR supported by compiler
		once
			create Result.make
			Result.compare_objects
			Result.extend("v1.0.3705")
			Result.extend("v1.1.4322") 
		end


feature -- Constants

	il_generation_no: INTEGER is 0
			-- No IL code will be generated.

	il_generation_exe: INTEGER is 1
			-- An IL exe will be generated.
	
	il_generation_dll: INTEGER is 2
			-- An IL dll will be generated.

feature {NONE} -- Internal status

	successful_save: BOOLEAN
			-- Did we successfully write our changes to disk?

feature {NONE} -- Interface names

	default_ace_file_name: STRING is "Ace.ace"
			-- Default ace file name.
			
	Warning_messages: WARNING_MESSAGES is
			-- All warnings used in the interface
		once
			create Result
		end
		
	ace_dictionary: ACE_FILE_DICTIONARY is
		-- Ace file keyword dictionary
		once
			create Result
		end

feature {NONE} -- Generation of AST

feature {NONE} -- Implementation

	parsed_ast (a_file_name: STRING): ACE_SD is
			-- Parse Ace file and return a new AST.
		do
			Parser.reset_comment_list
			Parser.parse_file (a_file_name, False)
			Result ?= Parser.ast
			if Result /= Void then
				Result.set_comment_list (Parser.comment_list)
			end
		end
	
	defaults: LACE_LIST [D_OPTION_SD] is
			-- Ace default clause, create it if needed
		do
			Result := root_ast.defaults
			if Result = Void then  
				-- No default option, we need to create them.  
				create Result.make (10) 
				root_ast.set_defaults (Result) 
			end 
		ensure
			non_void_defaults: Result /= Void
		end
		
invariant
	non_void_root_ast: root_ast /= Void
	
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
end -- class ACE_FILE_ACCESSER

