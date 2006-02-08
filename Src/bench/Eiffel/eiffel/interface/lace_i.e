indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			vd21: VD21
			d1, d2: DATE_TIME
		do
			debug ("Timing")
				create d1.make_now
			end
			if not full_degree_6_needed then
				ptr := file_name.to_c
				create file.make (file_name)
				has_changed := False
				if not file.exists then
					successful := False
					create vd21
					vd21.set_file_name (file_name)
					Error_handler.insert_error (vd21)
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
			debug ("Timing")
				create d2.make_now
				print ("Degree 6 duration: ")
				print (d2.relative_duration (d1).fine_seconds_count)
				print ("%N")
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
						if conv_opt /= Void and then conv_opt.code = {FREE_OPTION_SD}.force_recompile then
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
				create Result
		end

	parsed_ast: ACE_SD is
			-- Parse Ace file and return a new AST.
		do
			Parser.reset_comment_list
			Parser.parse_file (file_name, False)
			Result ?= Parser.ast
			if Result /= Void then
				update_ace_for_eweasel_on_dotnet (Result)
				update_ace_for_dotnet (Result)
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
							conv_opt.code = {FREE_OPTION_SD}.Force_recompile and then
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
					create sys.make
					Eiffel_project.init_system
				end
				not_first_parsing := True
			end

			old_universe := Universe.twin
			old_system := System.twin

			Universe.clusters.wipe_out

				-- Recompilation
			root_ast.build_universe

				-- Check presence of basic classes in the universe.
				-- Do it on every recompilation, as these classes
				-- may be removed from universe between recompilations.
			Universe.check_universe

				-- Check sum error
			Error_handler.checksum

			add_missing_assemblies

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
				st.put_in_file (ace_file)
				ace_file.close
			end
		end

	add_missing_assemblies is
			-- Create a copy of Ace file on disk with missing assemblies added.
		require
			parsed_ast_not_void: parsed_ast /= Void
		local
			st: GENERATION_BUFFER
			ace_file: PLAIN_TEXT_FILE
			ast: like root_ast
			l_missing: ARRAYED_LIST [ASSEMBLY_I]
			l_assembly: ASSEMBLY_SD
			l_factory: LACE_AST_FACTORY
			retried: BOOLEAN
			vd66: VD66
		do
			if not retried then
				l_missing := Universe.assemblies_to_be_added

				if l_missing /= Void then
					ast := parsed_ast

					check
						has_assemblies: ast.assemblies /= Void
					end

					from
						l_missing.start
						create l_factory
					until
						l_missing.after
					loop
						create l_assembly.initialize (
							l_factory.new_id_sd (l_missing.item.cluster_name, True),
							l_factory.new_id_sd (l_missing.item.assembly_path, True),
							l_factory.new_id_sd (l_missing.item.prefix_name, True),
							Void,
							Void,
							Void)
						ast.assemblies.extend (l_assembly)
						l_missing.forth
					end

					Universe.reset_assemblies_to_be_added

					create st.make (2048)
					ast.save (st)
					if Eiffel_ace.file_name /= Void then
						create ace_file.make_open_write (Eiffel_ace.file_name)
						st.put_in_file (ace_file)
						ace_file.close
					end
				end
			else
				create vd66.make (l_missing)
				Error_handler.insert_warning (vd66)
			end
		rescue
			retried := True
			retry
		end

	update_ace_for_dotnet (a_root: ACE_SD) is
			-- Update `a_root' with data required to compile a .NET system.
			-- At the moment it only adds a reference to the Eiffel .NET runtime.
		require
			a_root_not_void: a_root /= Void
		local
			l_assemblies: LACE_LIST [ASSEMBLY_SD]
			l_assembly: ASSEMBLY_SD
			l_factory: LACE_AST_FACTORY
			l_found: BOOLEAN
			l_runtime_path: ID_SD
			l_runtime, l_other: STRING
		do
			if a_root.is_dotnet_project then
					-- Let's add a reference to EiffelSoftware.Runtime.dll
					-- needed to compile our kernel classes when IL code
					-- generation is enabled
				l_assemblies := a_root.assemblies
				create l_factory
				l_runtime := (create {EIFFEL_ENV}).eiffelsoftware_runtime_path.twin
				l_runtime_path := l_factory.new_id_sd (l_runtime, True)
				if l_assemblies = Void then
					create l_assemblies.make (3)
					a_root.set_assemblies (l_assemblies)
					create l_assembly.initialize (
						l_factory.new_id_sd ("eiffelsoftware_runtime", True),
						l_runtime_path, Void, Void, Void, Void)
					l_assemblies.extend (l_assembly)
				else
						-- Let's find if we already have a matching cluster, i.e.
						-- with the same `assembly_name'.
					from
						l_assemblies.start
						l_runtime.to_lower
					until
						l_assemblies.after or l_found
					loop
						l_other := l_assemblies.item.assembly_name.string
						l_other.replace_substring_all ("/", "\")
						l_other.to_lower
						l_found := l_other.is_equal (l_runtime)
						l_assemblies.forth
					end
						-- Assembly was not found, let's add it to the Ace file.
					if not l_found then
						create l_factory
						create l_assembly.initialize (
							l_factory.new_id_sd ("eiffelsoftware_runtime", True),
							l_runtime_path, Void, Void, Void, Void)
						l_assemblies.extend (l_assembly)
					end
				end
			end
		end

	update_ace_for_eweasel_on_dotnet (a_root: ACE_SD) is
			-- Update `a_root' with data required to compile a .NET system
			-- with eweasel. Mostly it will add .NET missing option and clusters.
		require
			a_root_not_void: a_root /= Void
		local
			l_shared: SHARED_CONFIGURE_RESOURCES
			l_defaults: LACE_LIST [D_OPTION_SD]
			l_factory: LACE_AST_FACTORY
			l_option: D_OPTION_SD
			l_assemblies: LACE_LIST [ASSEMBLY_SD]
			l_assembly: ASSEMBLY_SD
			l_runtime_version: STRING
		do
			create l_shared
			if l_shared.configure_resources.get_boolean ("eweasel_for_dotnet", False) then
				l_runtime_version := l_shared.configure_resources.get_string ("clr_version", Void)

					-- In the code below we use `compare_objects' on the list we manipulate
					-- to make sure that an option/assembly is not inserted more than twice in
					-- the Ace file.
				l_defaults := a_root.defaults
				if l_defaults = Void then
					create l_defaults.make (1)
					a_root.set_defaults (l_defaults)
				end
				l_defaults.compare_objects

				create l_factory
				l_option := l_factory.new_special_option_sd (
					{FREE_OPTION_SD}.msil_generation, Void, True)
				if not l_defaults.has (l_option) then
					l_defaults.extend (l_option)
				end
				if compilation_modes.is_precompiling then
					l_option := l_factory.new_special_option_sd (
						{FREE_OPTION_SD}.msil_generation_type, "dll", True)
				else
					l_option := l_factory.new_special_option_sd (
						{FREE_OPTION_SD}.msil_generation_type, "exe", True)
				end
				if not l_defaults.has (l_option) then
					l_defaults.extend (l_option)
				end

				if l_runtime_version /= Void then
					l_option := l_factory.new_special_option_sd (
						{FREE_OPTION_SD}.msil_clr_version, l_runtime_version, True)
					if not l_defaults.has (l_option) then
						l_defaults.extend (l_option)
					end
				end

				l_option := l_factory.new_special_option_sd (
					{FREE_OPTION_SD}.console_application, Void, True)
				l_defaults.extend (l_option)

				l_defaults.compare_references

				l_assemblies := a_root.assemblies
				if l_assemblies = Void then
					create l_assemblies.make (3)
					a_root.set_assemblies (l_assemblies)
				end
				check
					compare_references: not l_assemblies.object_comparison
				end
				l_assemblies.compare_objects

				create l_assembly.initialize (
					l_factory.new_id_sd ("mscorlib", True),
					l_factory.new_id_sd ("$ISE_DOTNET_FRAMEWORK\mscorlib.dll", True),
					Void, Void, Void, Void)
				if not l_assemblies.has (l_assembly) then
					l_assemblies.extend (l_assembly)
				end

				create l_assembly.initialize (
					l_factory.new_id_sd ("system_", True),
					l_factory.new_id_sd ("$ISE_DOTNET_FRAMEWORK\System.dll", True),
					l_factory.new_id_sd ("system_dll_", False), Void, Void, Void)
				if not l_assemblies.has (l_assembly) then
					l_assemblies.extend (l_assembly)
				end

				create l_assembly.initialize (
					l_factory.new_id_sd ("system_xml", True),
					l_factory.new_id_sd ("$ISE_DOTNET_FRAMEWORK\System.Xml.dll", True),
					l_factory.new_id_sd ("system_xml_", False), Void, Void, Void)
				if not l_assemblies.has (l_assembly) then
					l_assemblies.extend (l_assembly)
				end

					-- Restore previous comparison to ensure we do not break code.
				l_assemblies.compare_references
			end
		end

invariant
	argument_list_created: argument_list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
