indexing
	description: "Load configuration from the old lace format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_LACE

inherit
	CONF_ACCESS

	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CONF_VALIDITY

	CONF_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_factory: like factory; an_extension: like extension_name) is
			-- Create.
		require
			a_factory_not_void: a_factory /= Void
			an_extension_not_void: an_extension /= Void
			an_extension_not_empty: not an_extension.is_empty
		do
			factory := a_factory
			extension_name := an_extension
			create current_overrides.make (1)
			is_library_conversions := True
		ensure
			factory_set: factory = a_factory
			extension_name_set: extension_name = an_extension
		end

feature -- Status

	is_library_conversions: BOOLEAN
			-- Should we do conversion of clusters into libraries and similar things?

	is_error: BOOLEAN
			-- Was there an error during the retrieval?

	last_error: CONF_ERROR
			-- The last error message.

	is_warning: BOOLEAN
			-- Was there a warning during the retrieval?

	warnings: ARRAYED_LIST [STRING]
			-- The warnings.

	extension_name: STRING
			-- Name of the config file extension.

	has_vision2: BOOLEAN
			-- Did the old configuration have vision2?

	has_wel: BOOLEAN
			-- Did the old configuration have wel?

feature -- Status update

	disable_library_conversions is
			-- Disable conversions of cluster that correspond to a library into libraries.
		do
			is_library_conversions := False
		ensure
			not_is_library_conversions: not is_library_conversions
		end

feature -- Access

	last_system: CONF_SYSTEM
			-- The last retrieved system.

feature -- Basic operation

	retrieve_configuration (a_file: STRING) is
			-- Retreive the configuration in `a_file' and make it available in `last_system'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_parser: LACE_PARSER
			l_ast: ACE_SD
			l_desc: STRING
		do
			create l_parser.make
			l_parser.parse_file (a_file, False)
			l_ast ?= l_parser.ast
			if l_ast = Void then
				if l_parser.last_syntax_error /= Void then
					set_error (create {CONF_ERROR_PARSE}.make (l_parser.last_syntax_error))
				else
					set_error (create {CONF_ERROR_PARSE})
				end
			else
				last_system := factory.new_system_generate_uuid (mask_special_characters_config (l_ast.system_name.as_lower))
				current_target := factory.new_target (mask_special_characters_config (l_ast.system_name.as_lower), last_system)
				last_system.add_target (current_target)

				process_defaults (l_ast.defaults)
				if not l_parser.comments.is_empty then

					if current_target.description /= Void then
						l_desc := l_parser.comments + current_target.description
					else
						l_desc := l_parser.comments
					end
					l_desc.replace_substring_all ("<", "&lt;")
					l_desc.replace_substring_all (">", "&gt;")
					current_target.set_description (l_desc)
				end
				if current_options = Void then
					create current_options
				end
				current_options.set_warning (True)
					-- disable some warnings by default
				current_options.add_warning (w_vjrv, False)
				current_options.add_warning (w_export_class_missing, False)
				if current_options.warnings /= Void and then not current_options.warnings.has (w_syntax) then
					current_options.add_warning (w_syntax, False)
				end

				current_target.set_options (current_options)
				current_options := Void

				process_root (l_ast.root)
				create ignored_clusters.make (5)
				if l_ast.clusters /= Void then
					l_ast.clusters.do_all (agent process_cluster)
				end
				if l_ast.assemblies /= Void then
					l_ast.assemblies.do_all (agent process_assembly)
				end
				process_externals (l_ast.externals)
				convert_old_default_boolean
			end
		ensure
			no_error_implies_last_system_not_void: not is_error implies last_system /= Void
		end

feature {NONE} -- Implementation of data retrieval

	factory: CONF_PARSE_FACTORY
			-- Factory for node creation.

	current_target: CONF_TARGET

	current_cluster: CONF_CLUSTER

	current_options: CONF_OPTION

	current_overrides: SEARCH_TABLE [STRING]

	process_assembly (an_assembly: ASSEMBLY_SD) is
			-- Process `an_assembly'.
		require
			current_target_not_void: current_target /= Void
			an_assembly_not_void: an_assembly /= Void
		local
			l_name: STRING
			l_assembly: CONF_ASSEMBLY
		do
			if an_assembly.version /= Void then
				l_assembly := factory.new_assembly_from_gac (mask_special_characters_config (an_assembly.cluster_name.as_lower), an_assembly.assembly_name, an_assembly.version, an_assembly.culture, an_assembly.public_key_token, current_target)
			else
				if is_library_conversions then
						-- correct path of mscorlib, system and system_xml
					l_name := an_assembly.assembly_name.as_lower
					if l_name.is_equal ("mscorlib") then
						l_assembly := factory.new_assembly ("mscorlib", "$ISE_DOTNET_FRAMEWORK\mscorlib.dll", current_target)
					elseif l_name.is_equal ("system_") then
						l_assembly := factory.new_assembly ("system_", "$ISE_DOTNET_FRAMEWORK\System.dll", current_target)
					elseif l_name.is_equal ("system_xml") then
						l_assembly := factory.new_assembly ("system_xml", "$ISE_DOTNET_FRAMEWORK\System.Xml.dll", current_target)
					end
				end

				if l_assembly = Void then
					l_name := an_assembly.assembly_name
					l_name.replace_substring_all ("$ISE_LIBRARY", "$ISE_EIFFEL")
					l_assembly := factory.new_assembly (mask_special_characters_config (l_name), an_assembly.assembly_name, current_target)
				end
			end
			if an_assembly.prefix_name /= Void and then not an_assembly.prefix_name.is_empty then
				l_assembly.set_name_prefix (mask_special_characters_config (an_assembly.prefix_name))
			end
			current_target.add_assembly (l_assembly)
		end

	process_cluster (a_cluster: CLUSTER_SD) is
			-- Process `a_cluster'.
		require
			ignored_clusters_not_void: ignored_clusters /= Void
			current_target_not_void: current_target /= Void
			current_options_void: current_options = Void
			a_cluster_not_void: a_cluster /= Void
		local
			l_over: CONF_OVERRIDE
			l_name, l_parent, l_str: STRING
			l_location: CONF_DIRECTORY_LOCATION
			l_file_loc: CONF_FILE_LOCATION
			l_lib, l_lib_pre: CONF_LIBRARY
			l_normal_cluster: BOOLEAN
		do
			l_name := mask_special_characters_config (a_cluster.cluster_name)
			if is_library_conversions then
					-- convert base, wel, vision2 and time clusters into library equivalents
				if l_name.is_case_insensitive_equal ("base") then
					l_file_loc := factory.new_location_from_full_path ("$ISE_LIBRARY\library\base\base.ecf", current_target)
					l_lib := factory.new_library ("base", l_file_loc, current_target)
					ignored_clusters.force ("base")
				elseif l_name.is_case_insensitive_equal ("wel") then
					l_file_loc := factory.new_location_from_full_path ("$ISE_LIBRARY\library\wel\wel.ecf", current_target)
					l_lib := factory.new_library ("wel", l_file_loc, current_target)
					ignored_clusters.force ("wel")
					has_wel := True
				elseif l_name.is_case_insensitive_equal ("vision2") then
					l_file_loc := factory.new_location_from_full_path ("$ISE_LIBRARY\library\vision2\vision2.ecf", current_target)
					l_lib := factory.new_library ("vision2", l_file_loc, current_target)
					ignored_clusters.force ("vision2")
					has_vision2 := True
				elseif l_name.is_case_insensitive_equal ("time") then
					l_file_loc := factory.new_location_from_full_path ("$ISE_LIBRARY\library\time\time.ecf", current_target)
					l_lib := factory.new_library ("time", l_file_loc, current_target)
					ignored_clusters.force ("time")
				end

				l_parent := a_cluster.parent_name
				if l_parent /= Void then
					l_parent.to_lower
					l_parent := mask_special_characters_config (l_parent)
				end

				if l_lib /= Void then
						-- remove the same library if it has already been added because of a precompile
					l_lib_pre := current_target.libraries.item ("pre_"+l_lib.name)
					if l_lib_pre /= Void and then l_lib_pre.location.is_equal (l_lib.location) then
						current_target.remove_library ("pre_"+l_lib.name)
					end

					current_target.add_library (l_lib)
						-- create a dummy cluster to get the cluster options and set the ones that make sense on the library
					current_cluster := factory.new_cluster ("dummy", factory.new_location_from_path (".", current_target), current_target)
					process_cluster_properties (a_cluster.cluster_properties)

						-- take visible clause
					l_lib.set_visible (current_cluster.visible)

						-- take options
					l_lib.set_options (current_cluster.internal_options)

					current_cluster := Void
				elseif
					a_cluster.directory_name.has_substring ("library.net") or
					(l_parent /= Void and then ignored_clusters.has (l_parent))
				then
						-- ignore it as well
					ignored_clusters.force (l_name)
				else
					l_normal_cluster := True
				end
			else
				l_normal_cluster := True
			end

				-- convert normal clusters
			if l_normal_cluster then
				l_str := a_cluster.directory_name
				l_str.replace_substring_all ("$ISE_LIBRARY", "$ISE_EIFFEL")
				l_location := factory.new_location_from_path (l_str, current_target)
				if current_overrides.has (l_name) then
					l_over := factory.new_override (l_name, l_location, current_target)
					current_cluster := l_over
					current_target.add_override (l_over)
				else
					current_cluster := factory.new_cluster (l_name, l_location, current_target)
					current_target.add_cluster (current_cluster)
				end
				if a_cluster.is_library then
					current_cluster.set_readonly (True)
					current_cluster.set_recursive (True)
				end
				if a_cluster.is_recursive then
					current_cluster.set_recursive (True)
				end
				if a_cluster.has_parent then
					if not current_target.clusters.has (a_cluster.parent_name) then
						set_error (create {CONF_ERROR_PARSE}.make ("Parent not found: "+a_cluster.parent_name))
					else
						current_target.clusters.item (a_cluster.parent_name).add_child (current_cluster)
						current_cluster.set_parent (current_target.clusters.item (a_cluster.parent_name))
						l_location.set_parent (current_cluster.parent.location)
					end
				end

				process_cluster_properties (a_cluster.cluster_properties)
			end
		ensure
			current_options_void: current_options = Void
		end

	add_visibility_rename (a_cluster: CONF_CLUSTER; a_class: STRING; a_visible_class: STRING; a_rename: TWO_NAME_SD) is
			-- Add `a_rename' as a visibility rename to `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
			a_rename_not_void: a_rename /= Void
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_lower: a_class.is_equal (a_class.as_lower)
		do
			a_cluster.add_visible (a_class, a_rename.old_name.as_lower, a_visible_class, a_rename.new_name.as_lower)
		end

	process_cluster_properties (a_properties: CLUST_PROP_SD) is
			-- Process `a_properties'.
		require
			current_cluster_not_void: current_cluster /= Void
			current_target_not_void: current_target /= Void
		local
			l_parser: LACE_PARSER
			l_name: STRING
			l_location: CONF_LOCATION
			l_use_prop: CLUST_PROP_SD
			l_excludes: LACE_LIST [FILE_NAME_SD]
			l_cl_opt: LACE_LIST [O_OPTION_SD]
			l_fr: CONF_FILE_RULE
			l_str, l_path: STRING
			l_file_path: FILE_NAME
			l_file: PLAIN_TEXT_FILE
			l_opt_map: HASH_TABLE [LACE_LIST [D_OPTION_SD], STRING]
			l_lst: LACE_LIST [D_OPTION_SD]
			l_option: O_OPTION_SD
			l_targets: LACE_LIST [ID_SD]
			l_vis_lst: LACE_LIST [CLAS_VISI_SD]
			l_vis: CLAS_VISI_SD
			l_class, l_class_vis: STRING
		do
			if a_properties /= Void then
				l_location := current_cluster.location

					-- handle use
				l_str := a_properties.use_name
				if l_str /= Void then
					l_path := execution_environment.interpreted_string (l_str)
					create l_file_path.make_from_string (l_location.evaluated_directory)
					l_file_path.set_file_name (l_path)
					if l_file_path.is_empty then
						set_error (create {CONF_ERROR_FILE}.make (l_file_path))
					else
						create l_file.make (l_file_path)
						if not l_file.exists or else l_file.is_directory or else not l_file.is_readable then
							set_error (create {CONF_ERROR_FILE}.make (l_file_path))
						else
							l_file.open_read
							create l_parser.make
							l_parser.parse_file (l_file_path, True)
							l_use_prop ?= l_parser.ast
							if l_use_prop = Void then
								set_error (create {CONF_ERROR_PARSE}.make ("Problem in use file:"+l_file_path))
							else
								process_cluster_properties (l_use_prop)
							end
						end
					end
				end

					-- handle defaults
				process_defaults (a_properties.default_option)
				if current_options /= Void then
					current_cluster.set_options (current_options)
					current_options := Void
				end

					-- handle excludes
				l_excludes := a_properties.exclude_option
				if l_excludes /= Void and then not l_excludes.is_empty then
					create l_fr.make
					from
						l_excludes.start
					until
						l_excludes.after
					loop
						l_str := "/"+l_excludes.item.file__name+"$"
						if valid_regexp (l_str) then
							l_fr.add_exclude (l_str)
						else
							set_error (create {CONF_ERROR_REGEXP}.make (l_str))
						end
						l_excludes.forth
					end
					current_cluster.add_file_rule (l_fr)
				end

					-- handle class defaults
				l_cl_opt := a_properties.options
				if l_cl_opt /= Void then
						-- resort the options that the are per class instead of per option
					create l_opt_map.make (1)
					from
						l_cl_opt.start
					until
						l_cl_opt.after
					loop
						l_option := l_cl_opt.item
						l_targets := l_option.target_list
						if l_targets = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("No target for class option."))
						else
							from
								l_targets.start
							until
								l_targets.after
							loop
								l_name := l_targets.item.as_lower
								l_lst := l_opt_map.item (l_name)
								if l_lst = Void then
									create l_lst.make (1)
									l_opt_map.force (l_lst, l_name)
								end
								l_lst.force (l_option)
								l_targets.forth
							end
						end
						l_cl_opt.forth
					end

						-- add the options
					from
						l_opt_map.start
					until
						l_opt_map.after
					loop
						process_defaults (l_opt_map.item_for_iteration)
						if current_options /= Void then
							current_cluster.add_class_options (current_options, l_opt_map.key_for_iteration.as_upper)
							current_options := Void
						end
						l_opt_map.forth
					end
				end

					-- visibility
				l_vis_lst := a_properties.visible_option
				if l_vis_lst /= Void then
					from
						l_vis_lst.start
					until
						l_vis_lst.after
					loop
						l_vis := l_vis_lst.item
						l_class := l_vis.class_name.as_upper
						l_class_vis := l_vis.visible_name
						if l_class_vis /= Void then
							l_class_vis.to_upper
						end

						if l_vis.export_restriction = Void then
							current_cluster.add_visible (l_class, Void, l_class_vis, Void)
						else
							l_vis.export_restriction.do_all (agent current_cluster.add_visible (l_class, {ID_SD}?, l_class_vis, Void))
						end

						if l_vis.renamings /= Void then
							l_vis.renamings.do_all (agent add_visibility_rename (current_cluster, l_class, l_class_vis, ?))
						end

						l_vis_lst.forth
					end
				end

					-- add warnings for things we don't handle.
				if a_properties.include_option /= Void then
					is_warning := True
					if warnings = Void then
						create warnings.make (1)
					end
					warnings.extend ("Include option will not be automatically converted. Support for include options has been droped.")
				end
				if a_properties.adapt_option /= Void then
					is_warning := True
					if warnings = Void then
						create warnings.make (1)
					end
					warnings.extend ("Adapt option will not be automatically converted. Please refer to the renaming and dependencies sections of your configuration.")
				end
			end

		end

	process_defaults (a_defaults: LACE_LIST [D_OPTION_SD]) is
			-- Process `a_defaults'.
		require
			current_target_not_void: current_target /= Void
		local
			l_d_opt: D_OPTION_SD
			l_precomp: D_PRECOMPILED_SD
			l_option: OPTION_SD
			l_debug: DEBUG_SD
			l_value: OPT_VAL_SD
			l_name: STRING
			l_conf_vers: CONF_VERSION
			l_conf_pre: CONF_PRECOMPILE
			l_assertions: CONF_ASSERTIONS
			l_str: STRING
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
			l_rename: LACE_LIST [TWO_NAME_SD]
			l_loader: CONF_LOAD
			l_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_pre_lib: CONF_LIBRARY
		do
			if a_defaults /= Void then
				from
					a_defaults.start
				until
					a_defaults.after
				loop
					l_d_opt := a_defaults.item
					l_option := l_d_opt.option
					l_name := l_option.option_name
					l_value := l_d_opt.value
					if l_name.is_case_insensitive_equal ("description") then
						current_target.set_description (l_value.value)
					elseif l_option.is_debug then
						l_debug ?= l_option
						if current_options = Void then
							create current_options
						end
							-- because the old config had debugs enabled by default we enable them
						if not current_options.is_debug_configured then
							current_options.set_debug (True)
						end

						if l_value = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("Empty debug value."))
						else
							l_name := l_value.value
							if l_name.is_case_insensitive_equal ("yes") then
								l_name := unnamed_debug
								current_options.add_debug (l_name, l_debug.enabled)
							elseif l_name.is_case_insensitive_equal ("no") then
								current_options.set_debug (False)
							else
								current_options.add_debug (l_name.as_lower, l_debug.enabled)
							end
						end
					elseif l_option.is_trace then
						if current_options = Void then
							create current_options
						end
						if l_value = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("Empty trace value."))
						else
							current_options.set_trace (l_value.is_yes)
						end
					elseif l_option.is_optimize then
						if current_options = Void then
							create current_options
						end
						if l_value = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("Empty optimize value."))
						else
							current_options.set_optimize (l_value.is_yes)
						end
					elseif l_option.is_assertion then
						if current_options = Void then
							create current_options
						end
						l_assertions := current_options.assertions
						if l_assertions = Void then
							l_assertions := factory.new_assertions
							current_options.set_assertions (l_assertions)
						end
						if l_value = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("Empty assertion value."))
						else
							if l_value.is_all then
								l_assertions.enable_check
								l_assertions.enable_invariant
								l_assertions.enable_loop
								l_assertions.enable_postcondition
								l_assertions.enable_precondition
							elseif l_value.is_no then
								l_assertions.disable_check
								l_assertions.disable_invariant
								l_assertions.disable_loop
								l_assertions.disable_postcondition
								l_assertions.disable_precondition
							elseif l_value.is_check then
								l_assertions.enable_check
							elseif l_value.is_ensure then
								l_assertions.enable_postcondition
							elseif l_value.is_invariant then
								l_assertions.enable_invariant
							elseif l_value.is_loop then
								l_assertions.enable_loop
							elseif l_value.is_require then
								l_assertions.enable_precondition
							end
						end
					elseif l_option.is_precompiled then
						l_precomp ?= l_d_opt
						if l_precomp.value = Void then
							set_error (create {CONF_ERROR_PARSE}.make ("Incorrect precompile."))
						else
								-- we try to guess the correct configuration location, may not always work
								-- what we guess is that the path looks like this something/base and
								-- we convert it into something/base.`extension_name'.
							l_str := l_precomp.value.value
							l_str.append ("." + extension_name)
								-- replace $ISE_LIBRARY with $ISE_EIFFEL for precompiles
							l_str.replace_substring_all ("$ISE_LIBRARY", "$ISE_EIFFEL")

							l_conf_pre := factory.new_precompile ("precompile", l_str, current_target)
							l_rename := l_precomp.renamings
							if l_rename /= Void then
								from
									l_rename.start
								until
									l_rename.after
								loop
									l_conf_pre.add_renaming (l_rename.item.old_name, l_rename.item.new_name)
									l_rename.forth
								end
							end
							current_target.set_precompile (l_conf_pre)

								-- open precompile and add libraries of precompile
							if is_library_conversions then
								create l_loader.make (factory)
								l_loader.retrieve_configuration (l_conf_pre.location.evaluated_path)
								if not l_loader.is_error and then l_loader.last_system.library_target /= Void then
									from
										l_libs := l_loader.last_system.library_target.libraries
										l_libs.start
									until
										l_libs.after
									loop
										l_pre_lib := l_libs.item_for_iteration
										l_pre_lib.name.prepend ("pre_")
										current_target.add_library (l_pre_lib)
										l_libs.forth
									end
								end
							end
						end
					elseif l_option.is_free_option then
						if l_name.is_equal ("company") then
							if l_conf_vers = Void then
								create l_conf_vers.make
							end
							l_conf_vers.set_company (l_value.value)
						elseif l_name.is_equal ("copyright") then
							if l_conf_vers = Void then
								create l_conf_vers.make
							end
							l_conf_vers.set_copyright (l_value.value)
						elseif l_name.is_equal ("namespace") then
							if current_options = Void then
								create current_options
							end
							current_options.set_local_namespace (l_value.value)
						elseif l_name.is_equal ("override_cluster") then
							current_overrides.force (l_value.value)
						elseif l_name.is_equal ("product") then
							if l_conf_vers = Void then
								create l_conf_vers.make
							end
							l_conf_vers.set_product (l_value.value)
						elseif l_name.is_equal ("profile") then
							if current_options = Void then
								create current_options
							end
							current_options.set_profile (l_value.is_yes)
						elseif l_name.is_equal ("trademark") then
							if l_conf_vers = Void then
								create l_conf_vers.make
							end
							l_conf_vers.set_trademark (l_value.value)
						elseif l_name.is_equal ("version") then
								-- there is no format for this, we try to parse it if it is in the format
								-- w.x.y.z (x, y and z are optional)
							l_str := l_value.value
							create l_regexp.make
							l_regexp.compile ("(\d{1,4})(\.(\d{1,4}))?(\.(\d{1,4}))?(\.(\d{1,4}))?")
							l_regexp.match (l_str)
							if l_regexp.has_matched then
								if l_conf_vers = Void then
									create l_conf_vers.make
								end
								check
									major_number: l_regexp.captured_substring (1).is_natural_16
								end
								l_conf_vers.set_major (l_regexp.captured_substring (1).to_natural_16)
								if l_regexp.match_count >= 3 then
									check
										minor_number: l_regexp.captured_substring (3).is_natural_16
									end
									l_conf_vers.set_minor (l_regexp.captured_substring (3).to_natural_16)
									if l_regexp.match_count >= 5 then
										check
											release_number: l_regexp.captured_substring (5).is_natural_16
										end
										l_conf_vers.set_release (l_regexp.captured_substring (5).to_natural_16)
										if l_regexp.match_count >= 7 then
											check
												build_number: l_regexp.captured_substring (7).is_natural_16
											end
											l_conf_vers.set_build (l_regexp.captured_substring (7).to_natural_16)
										end
									end
								end
							end
						elseif l_name.is_equal ("syntax_warning") and l_value /= Void then
							if current_options = Void then
								create current_options
							end
							current_options.add_warning (w_syntax, l_value.is_yes)
						elseif l_name.is_equal ("old_verbatim_strings_warning") and l_value /= Void then
								-- This option has no effect in 6.3 or later, so we accept it but we don't do anything with it.
						elseif valid_setting (l_name) and l_value /= Void then
							current_target.add_setting (l_name, l_value.value)
						end
					end
					a_defaults.forth
				end
				if l_conf_vers /= Void then
					current_target.set_version (l_conf_vers)
				end
			end
		end

	process_root (a_root: ROOT_SD) is
			-- Process `a_root'.
		require
			current_target_not_void: current_target /= Void
		local
			l_cluster, l_class, l_feature: STRING
			l_root: CONF_ROOT
		do
			if a_root /= Void then
				l_class := a_root.root_name
				if l_class /= Void and then not l_class.is_empty then
					l_class.to_upper
					l_cluster := a_root.cluster_mark
					if l_cluster /= Void then
						l_cluster.to_lower
						l_cluster := mask_special_characters_config (l_cluster)
					end
					l_feature := a_root.creation_procedure_name
					if l_feature /= Void and then l_feature.is_empty then
						l_feature := Void
					end
					if l_feature /= Void then
						l_feature.to_lower
					end
					if l_class.is_equal ("NONE") then
						l_root := factory.new_root (Void, Void, Void, True)
					else
						l_root := factory.new_root (l_cluster, l_class, l_feature, False)
					end

					current_target.set_root (l_root)
				end
			end
		end

	process_externals (a_externals: LACE_LIST [LANG_TRIB_SD]) is
			-- Process `a_externals'.
		require
			current_target_not_void: current_target /= Void
		local
			l_external: LANG_TRIB_SD
			l_type: LANGUAGE_NAME_SD
			l_files: LACE_LIST [ID_SD]
			l_loc: STRING
			l_ignore: RX_PCRE_REGULAR_EXPRESSION
			l_has_ignores: BOOLEAN
		do
			if a_externals /= Void then
				create l_ignore.make
				if is_library_conversions then
					if has_wel and has_vision2 then
						l_ignore.compile (".*library.(vision2|wel)")
						l_has_ignores := True
					elseif has_wel then
						l_ignore.compile (".*library.wel")
						l_has_ignores := True
					elseif has_vision2 then
						l_ignore.compile (".*library.vision2")
						l_has_ignores := True
					end
					if l_has_ignores then
						l_ignore.optimize
					end
				end

				from
					a_externals.start
				until
					a_externals.after
				loop
					l_external := a_externals.item
					l_type := l_external.language_name
					l_files := l_external.file_names
					from
						l_files.start
					until
						l_files.after
					loop
						l_loc := l_files.item
						if l_has_ignores then
								-- ignore externals of vision2 and wel
							l_ignore.match (l_loc)
						end
						if not l_has_ignores or else not l_ignore.has_matched then
							if l_type.is_include_path then
								current_target.add_external_include (factory.new_external_include (l_loc, current_target))
							elseif l_type.is_object then
								current_target.add_external_object (factory.new_external_object (l_loc, current_target))
							elseif l_type.is_dotnet_resource then
								current_target.add_external_resource (factory.new_external_resource (l_loc, current_target))
							elseif l_type.is_make then
								current_target.add_external_make (factory.new_external_make (l_loc, current_target))
							else
								set_error (create {CONF_ERROR_PARSE}.make ("Unkown external: "+l_type.language_name))
							end
						end

						l_files.forth
					end

					a_externals.forth
				end
			end
		end

	convert_old_default_boolean is
			-- Convert yes/no values of defaults into True/False.
		require
			current_target /= Void
		local
			l_settings: HASH_TABLE [STRING, STRING]
			l_name, l_value: STRING
		do
			from
				l_settings := current_target.settings
				l_settings.start
			until
				l_settings.after
			loop
				l_name := l_settings.key_for_iteration
				if boolean_settings.has (l_name) then
					l_value := l_settings.item_for_iteration
					if l_value.is_case_insensitive_equal ("yes") then
						l_settings.force ("true", l_name)
					elseif l_value.is_case_insensitive_equal ("no") then
						l_settings.force ("false", l_name)
					else
						set_error (create {CONF_ERROR_PARSE}.make ("Invalid value for option, must be yes or no: "+l_name))
					end
				end
				l_settings.forth
			end
		end

feature {NONE} -- Implementation

	ignored_clusters: SEARCH_TABLE [STRING]
			-- Clusters that have been ignored (and of which child clusters can be ignored as well)

	set_error (an_error: CONF_ERROR) is
			-- Set `an_error'.
		require
			an_error_not_void: an_error /= Void
		do
			is_error := True
			last_error := an_error
		end

	mask_special_characters_config (a_string: STRING): STRING is
			-- Return a string with the special characters in `a_string' masked,
			-- so that it is a valid configuration identifier.
		require
			a_string_not_void: a_string /= Void and then not a_string.is_empty
		do
			create Result.make_from_string (a_string)
			invalid_config_regexp.match (Result)
			Result := invalid_config_regexp.replace_all ("_")
			if not Result.item (1).is_alpha then
				Result.precede ('a')
			end
		ensure
			result_valid: is_valid_config_identifier (Result)
		end

	invalid_config_regexp: RX_PCRE_REGULAR_EXPRESSION is
			-- Regular expression that matches all invalid characters in a configuration identifier.
		once
			create Result.make
			Result.compile ("[^\w._-]")
			Result.optimize
		end

invariant
	factory_not_void: factory /= Void
	extension_name_not_void: extension_name /= Void
	extension_name_not_empty: not extension_name.is_empty

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
end
