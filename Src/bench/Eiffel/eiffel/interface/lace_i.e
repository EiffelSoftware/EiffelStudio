-- Lace controller

class LACE_I

inherit
	SHARED_WORKBENCH
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	SHARED_LACE_PARSER
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Lace initialization
		do
			create argument_list.make (2)
		end

feature -- Access

	file_name: STRING
			-- Path to the universe/system description

	date: INTEGER
			-- Time stamp of file named `file_name'

	argument_list: ARRAYED_LIST [STRING]
			-- List of command line arguments stored in Ace file.
	
	application_working_directory: STRING
			-- Current directory stored in Ace file.

	successful: BOOLEAN
			-- Is the last compilation successful?

	not_first_parsing: BOOLEAN
			-- Has first parsing been done?

	full_degree_6_needed: BOOLEAN
			-- Must a full degree 6 be performed?
			-- (Used when adding new clusters)

	need_directory_lookup: BOOLEAN
			-- Some Eiffel classes were not found after a first directory browsing,
			-- we force a complete browsing of directory structure for all clusters.

	has_changed: BOOLEAN
			-- Did AST changed after a recompilation?

	old_universe: UNIVERSE_I
			-- Universe of the previous compilation
			-- usefull for checking  the removed clusters

	date_has_changed: BOOLEAN is
		local
			str: ANY
			new_date: INTEGER
		do
			str := file_name.to_c
			new_date := eif_date ($str)
			Result := new_date /= date
		end

feature -- Status setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		require
			s_not_void: s /= Void
		do
			file_name := s
		ensure
			file_name_set: file_name = s
		end

	set_application_working_directory (s: STRING) is
			-- Assign `s' to `application_working_directory'.
		do
			application_working_directory := s
		ensure
			application_working_directory_set: application_working_directory = s
		end

	set_need_directory_lookup (v: BOOLEAN) is
			-- Assign `v' to `need_directory_lookup'.
		do
			need_directory_lookup := v
		ensure
			need_directory_lookup_set: need_directory_lookup = v
		end

	reset_date_stamp is
			-- Reset `date' information, that way a complete recompilation
			-- is done on Lace.
		do
				-- Dummy value to make sure it is different from before.
			date := date - 1
		end

	recompile is
			-- Recompile ACE description
		require
			file_name_exists: file_name /= Void
		local
			ptr: ANY
			file: PLAIN_TEXT_FILE
			vd22: VD22
		do
			if not full_degree_6_needed then
				ptr := file_name.to_c
				create file.make (file_name)
				has_changed := False
				if not file.exists then
					successful := False
					create vd22
					vd22.set_file_name (file_name)
					Error_handler.insert_error (vd22)
					Error_handler.raise_error
				end
					
					-- If last compilation was not successful, we have to trigger
					-- the parse again even though the `date' on file did not change.
				if
					root_ast = Void or else
					date_has_changed or else
					not successful
				then
					do_recompilation
					date := eif_date ($ptr)
				else
					build_universe
				end
			else
				force_recompile
			end
		end

	force_recompile is
			-- Force a complete recompilation to find any missing classes
			-- or clusters.
		local
			new_ast: like root_ast
			conv_opt: FREE_OPTION_SD
			tmp_ast: like root_ast
		do
			new_ast := parsed_ast
			root_ast := new_ast
			saved_root_ast := new_ast
			build_universe
			if successful and full_degree_6_needed then
				full_degree_6_needed := False
					-- Remove the force_recompile option(s) from the Ace file.
					--| We can't just save the contents of `root_ast' because at this point `all' clusters are expanded.
				tmp_ast := root_ast
				root_ast := parsed_ast
				
				if root_ast /= Void and then root_ast.defaults /= Void then
					from
						root_ast.defaults.start
					until
						root_ast.defaults.after
					loop
						conv_opt ?= root_ast.defaults.item.option
						if conv_opt /= Void and then conv_opt.code = feature {FREE_OPTION_SD}.force_recompile then
							root_ast.defaults.remove
						else
							root_ast.defaults.forth
						end
					end
					save_content
				end
				root_ast := tmp_ast
			end
		end
	
	parent_of_cluster (c: CLUSTER_SD): CLUSTER_SD is
			-- Parent of `c'.
		local
			cluster_list: ARRAYED_LIST [CLUSTER_SD]
			cu: CURSOR
		do
			if
				root_ast.clusters /= Void and then
				c.parent_name /= Void
			then
				from 
					cluster_list := root_ast.clusters
					cu := cluster_list.cursor
					cluster_list.start
				until
					cluster_list.after or
					Result /= Void
				loop
					if cluster_list.item.cluster_name /= Void then
						if cluster_list.item.cluster_name.is_equal (c.parent_name) then
							Result := cluster_list.item
						end
					end
					cluster_list.forth
				end
				cluster_list.go_to (cu)
			end
		end
	
	path_of_cluster (c: CLUSTER_SD): STRING is
			-- Full path of `c'.
		local
			i: INTEGER
			ee:EXECUTION_ENVIRONMENT
		do
			if c = Void then
				Result := "Void"
			else
				create ee
				if c.directory_name.item (1) /= '$' then
					Result := c.directory_name
				else
					if c.directory_name.item (2) = '/' then
						Result :=
							path_of_cluster (parent_of_cluster (c)) +
							c.directory_name.substring (2, c.directory_name.count)
					else
						i := c.directory_name.index_of ('/', 1)
						if i > 0 then
							Result :=
								ee.get (c.directory_name.substring (2, i -1)) +
								c.directory_name.substring (i, c.directory_name.count)
						else
							Result :=
								ee.get (c.directory_name.substring (2, c.directory_name.count))
						end
					end
				end
			end
		end
	
	dependency_dates: HASH_TABLE [INTEGER, STRING]
			-- Dates that files changed last.
	
	process_external_dependencies is
			-- Process `dependencies'.
		local
			cluster: CLUSTER_SD
			cluster_list: LINEAR [CLUSTER_SD]

			ds: LINEAR [DEPEND_SD]
			fs: ARRAYED_LIST [ID_SD]
			d: INTEGER
			str: ANY
			changed: BOOLEAN
			old_cwd: STRING
			ee:EXECUTION_ENVIRONMENT
			new_dates: HASH_TABLE [INTEGER, STRING]
			path: STRING
		do
			create ee
			if dependency_dates = Void then
				create dependency_dates.make (10)
			end
			if root_ast.clusters /= Void then
				create new_dates.make (dependency_dates.count)
				from 
					cluster_list := root_ast.clusters
					cluster_list.start
				until
					cluster_list.after
				loop
					cluster := cluster_list.item
					cluster_list.forth
					if
						not cluster.belongs_to_all and then
						cluster.cluster_properties /= Void and then
						cluster.cluster_properties.dependencies /= Void
					then
						old_cwd := ee.current_working_directory
						ee.change_working_directory (path_of_cluster (cluster))
						from
							ds := cluster.cluster_properties.dependencies
							ds.start
						until
							ds.after
						loop
							from
								fs := ds.item.depend_on
								fs.start
								changed := False
							until
								fs.after
							loop
								path := fs.item
								if path.item (1) = '$' then
									path :=
										path_of_cluster (cluster) +
										path.substring (2, path.count)
								end
								str := path.to_c
								d := eif_date ($str)
								if d /= dependency_dates.item (fs.item) then
									changed := True
								end
								new_dates.force (d, fs.item)
								fs.forth
							end
							if changed then
								ee.system (ds.item.script)
							end
							ds.forth
						end
						ee.change_working_directory (old_cwd)
					end
				end
				from
					new_dates.start
				until
					new_dates.after
				loop
					dependency_dates.force (
						new_dates.item_for_iteration,
						new_dates.key_for_iteration
					)
					new_dates.forth
				end
			end
		end

	root_ast: ACE_SD
			-- Root of last parsed ACE

	saved_root_ast: like root_ast
			-- Root of last parsed ACE. Untouched after building clusters.

	ace_options: ACE_OPTIONS is
			-- Options explicitly set in the ace file
		once
				!! Result
		end

	parsed_ast: ACE_SD is
			-- Parse Ace file and return a new AST.
		do
			Parser.reset_comment_list
			Parser.parse_file (file_name, False)
			Result ?= Parser.ast
			if Result /= Void then
				Result.set_comment_list (Parser.comment_list)
			end
		end

	do_recompilation is
			-- Recompile ACE description
		local
			old_ast, new_ast: like root_ast
			conv_opt: FREE_OPTION_SD
		do
				-- Lace parsing
			old_ast := saved_root_ast
			new_ast := parsed_ast

			if new_ast = Void or else error_handler.error_list.count > 0 then
				successful := False
			else
				if
					new_ast.defaults /= Void
				then
					from
						new_ast.defaults.start
					until
						new_ast.defaults.after
					loop
						conv_opt ?= new_ast.defaults.item.option
						if
							conv_opt /= Void and then
							conv_opt.code = feature {FREE_OPTION_SD}.Force_recompile and then
							new_ast.defaults.item.value.is_yes
						then
							full_degree_6_needed := True
						end
						new_ast.defaults.forth
					end
				end
				if not full_degree_6_needed then
					if old_ast /= Void then
							-- Adapt changes from `new_ast' to `old_ast' and
							-- return new updated AST.
						if not new_ast.same_as (old_ast) then
							saved_root_ast := new_ast
							root_ast := root_ast.updated_ast (old_ast, new_ast)
							has_changed := True
						end
					else
						saved_root_ast := new_ast.duplicate
						root_ast := new_ast
						has_changed := True
					end
					build_universe
				else
					force_recompile
				end
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successful := False
			end
		end

	build_universe is
			-- Build the universe using the AST
		require
			valid_root: root_ast /= Void
		local
			precomp_r: PRECOMP_R
			old_system: SYSTEM_I
			precompiled_project: PAIR [D_PRECOMPILED_SD, STRING]
			sys: SYSTEM_I
		do
			argument_list.wipe_out
			application_working_directory := Void
			process_external_dependencies
				-- Options explicitely set in the ace file
				--| Processing is done in `build_universe' in ACE_SD
			ace_options.reset

			if not not_first_parsing then
				precompiled_project := root_ast.precompiled_project
				if precompiled_project /= Void then
					Degree_output.put_string ("Retrieving precompile...")
					create precomp_r
					precomp_r.retrieve_precompiled (precompiled_project)
				else
					create sys
					Workbench.set_system (sys)
					Eiffel_project.init_system
					sys.make
				end
				not_first_parsing := True
			end

			old_universe := clone (Universe)
			old_system := clone (System)

			Universe.clusters.wipe_out

				-- Recompilation
			root_ast.build_universe

			if not Workbench.is_already_compiled then
					-- Check presence of basic classes in the universe, only
					-- once at the beginning
				Universe.check_universe
			end

				-- Check sum error
			Error_handler.checksum

			old_universe := Void

			successful := True
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				if old_system /= Void then
					Universe.copy (old_universe)
					Universe.reset_clusters
					System.copy (old_system)
				end
				old_universe := Void
				successful := False
			end
		end
		
	compile_all_classes: BOOLEAN is
			-- Is the root class NONE, i.e. all the classes must be compiled
		require
			parsed: successful
		do
			Result := root_ast.compile_all_classes
		end

	set_full_degree_6_needed (value: BOOLEAN) is
			-- Change the value of `full_degree_6_needed'.
		do
			full_degree_6_needed := value
		end

feature -- Access

	has_assertions: BOOLEAN is
		do
			Result := ace_options.has_assertion
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Time stamp primitive
		external
			"C"
		end

feature {NONE} -- Implementation

	save_content is
			-- Store `Ace' file with/without new cluster.
		local
			st: GENERATION_BUFFER
			ace_file: PLAIN_TEXT_FILE
			ast: like root_ast
		do
			if root_ast = Void then
					-- Creation of AST.
				create root_ast
			end

			ast := root_ast.duplicate
			
			create st.make (2048)
			ast.save (st)
			if Eiffel_ace.file_name /= Void then
				create ace_file.make_open_write (Eiffel_ace.file_name)
				ace_file.put_string (st)
				ace_file.close
			end
		end

invariant
	argument_list_created: argument_list /= Void

end
