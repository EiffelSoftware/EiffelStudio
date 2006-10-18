indexing
	description: "ECF configuration file generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ECF_FILE_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
			{ANY} client
			{ANY} server
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	CONF_ACCESS

feature -- Basic Operations

	generate (a_dummy: STRING) is
			-- Generate configuration file.
		local
			a_text: STRING
		do
			generate_configuration
		end

feature {NONE} -- Implementation

	generate_configuration is
			-- Generate a configuration file according to the current environment.
		local
			l_name: STRING
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_root: CONF_ROOT
			l_file_loc: CONF_FILE_LOCATION
			l_dir_loc: CONF_DIRECTORY_LOCATION
			l_lib: CONF_LIBRARY
			l_cl: CONF_CLUSTER
			l_excludes: CONF_FILE_RULE
			l_dir: DIRECTORY_NAME
			l_fn: FILE_NAME
			l_dest_dir: DIRECTORY_NAME
			l_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_as: CONF_ASSERTIONS
		do
			if environment.is_client then
				l_name := client
			else
				l_name := server
			end
			create l_dest_dir.make_from_string (environment.destination_folder.substring (1, environment.destination_folder.count - 1))

				-- system, target, root, settings
			if environment.is_client then
				l_system := new_system (environment.project_name + "_client")
			else
				l_system := new_system (environment.project_name)
			end
			if environment.is_eiffel_interface then
				l_target := l_system.targets.item (environment.eiffel_target)
				l_target.set_name ("default")
			else
				l_target := conf_factory.new_target ("default", l_system)
				l_system.add_target (l_target)
			end
			if environment.is_client then
				l_system.set_library_target (l_target)
				l_root := conf_factory.new_root (Void, "ANY", Void, False)
			elseif not system_descriptor.coclasses.is_empty then
				l_root := conf_factory.new_root (Void, Registration_class_name, "make", False)
					-- add shared library definition
				if environment.is_in_process then
					l_target.update_setting (conf_constants.s_shared_library_definition, user_def_file_name)
				end
			else
				l_root := conf_factory.new_root (Void, Void, Void, True)
			end
			l_target.set_root (l_root)
			l_as := conf_factory.new_assertions
			l_as.enable_precondition
			l_target.changeable_internal_options.set_assertions (l_as)

				-- needed libraries
			l_libs := l_target.libraries
			if not l_libs.has ("base") then
				l_file_loc := conf_factory.new_location_from_full_path ("$ISE_LIBRARY\library\base\base.ecf", l_target)
				l_lib := conf_factory.new_library ("base", l_file_loc, l_target)
				l_target.add_library (l_lib)
			end
			if not l_libs.has ("wel") then
				l_file_loc := conf_factory.new_location_from_full_path ("$ISE_LIBRARY\library\wel\wel.ecf", l_target)
				l_lib := conf_factory.new_library ("wel", l_file_loc, l_target)
				l_target.add_library (l_lib)
			end
			if not l_libs.has ("com") then
				l_file_loc := conf_factory.new_location_from_full_path ("$ISE_LIBRARY\library\com\com.ecf", l_target)
				l_lib := conf_factory.new_library ("com", l_file_loc, l_target)
				l_target.add_library (l_lib)
			end

				-- cluster
			l_dir_loc := conf_factory.new_location_from_path (l_dest_dir, l_target)
			l_cl := conf_factory.new_cluster (l_name.as_lower, l_dir_loc, l_target)
			l_target.add_cluster (l_cl)
			l_cl.set_recursive (True)
			l_excludes := conf_factory.new_file_rule
			l_excludes.add_exclude ("Clib")
			l_excludes.add_exclude ("Include")
			l_excludes.add_exclude ("EIFGENs")
			l_cl.add_file_rule (l_excludes)

				-- visible
			add_visible (l_cl, system_descriptor.visible_classes_client)
			add_visible (l_cl, system_descriptor.visible_classes_common)
			add_visible (l_cl, system_descriptor.visible_classes_server)
			if not environment.is_client and not system_descriptor.coclasses.is_empty then
				l_cl.add_visible (registration_class_name, Void, Void, Void)
			end

				-- external includes
			l_dir := l_dest_dir.twin
			l_dir.extend_from_array (<<client, include>>)
			l_target.add_external_include (conf_factory.new_external_include (l_dir))
			l_dir := l_dest_dir.twin
			l_dir.extend_from_array (<<common, include>>)
			l_target.add_external_include (conf_factory.new_external_include (l_dir))
			l_dir := l_dest_dir.twin
			l_dir.extend_from_array (<<server, include>>)
			l_target.add_external_include (conf_factory.new_external_include (l_dir))

				-- external libs
			add_libs (l_target, client)
			add_libs (l_target, server)

				-- store it
			create l_fn.make_from_string (environment.destination_folder)
			l_fn.extend (l_name)
			l_fn.set_file_name (environment.ecf_file_name)
			l_system.set_file_name (l_fn)
			l_system.store
		end

	add_visible (a_visible: CONF_VISIBLE; a_classes: LIST [WIZARD_WRITER_VISIBLE_CLAUSE]) is
			-- Add `a_classes' to the list of visible classes in `a_visible'.
		require
			a_visible_not_void: a_visible /= Void
		local
			l_vis: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			if a_classes /= Void then
				from
					a_classes.start
				until
					a_classes.after
				loop
					l_vis := a_classes.item
					if l_vis.exported_features.is_empty then
						a_visible.add_visible (l_vis.name, Void, Void, Void)
					else
						l_vis.exported_features.do_all (agent a_visible.add_visible (l_vis.name, ?, Void, Void))
					end
					a_classes.forth
				end
			end
		end

	add_libs (a_target: CONF_TARGET; a_folder: STRING) is
			-- Add libraries of `a_folder' to `a_target'.
		require
			a_target_not_void: a_target /= Void
			a_folder_not_void: a_folder /= Void and then a_folder.is_equal (client) or a_folder.is_equal (server)
		local
			l_dir: STRING
			l_ex_obj: CONF_EXTERNAL_OBJECT
			l_cond: CONF_CONDITION
		do
			if not is_empty_clib_folder (a_folder) then
				create l_dir.make (50)
				l_dir := environment.destination_folder + a_folder + "\Clib\$(ISE_C_COMPILER)\"
				l_ex_obj := conf_factory.new_external_object (l_dir + "ecom_final.lib")
				create l_cond.make
				l_cond.add_build (conf_constants.build_finalize)
				l_ex_obj.add_condition (l_cond)
				a_target.add_external_object (l_ex_obj)
				l_ex_obj := conf_factory.new_external_object (l_dir + "ecom.lib")
				create l_cond.make
				l_cond.add_build (conf_constants.build_workbench)
				l_ex_obj.add_condition (l_cond)
				a_target.add_external_object (l_ex_obj)
			end
		end

	new_system (a_name: STRING): CONF_SYSTEM is
			-- Create a new configuration system with `a_name'.
			-- If we are building from an eiffel interface, use the old project as source.
		local
			l_load: CONF_LOAD
		do
			if environment.is_eiffel_interface then
				create l_load.make (conf_factory)
				l_load.retrieve_configuration (environment.source_ecf_file_name)
				if l_load.is_error then
					Result := conf_factory.new_system_generate_uuid (a_name)
				else
					Result := l_load.last_system
					Result.set_name (a_name)
					Result.set_uuid (conf_factory.uuid_generator.generate_uuid)
				end
			else
				Result := conf_factory.new_system_generate_uuid (a_name)
			end
		end

	user_def_file_name: STRING is
			-- ".def" file name used for DLL compilation
		do
			create Result.make (100)
			Result.append (environment.project_name)
			Result.append (Def_file_extension)
		end

	is_empty_clib_folder (a_folder: STRING): BOOLEAN is
			-- Is folder `a_folder' is_empty?
		local
			l_directory: DIRECTORY
			l_dn: DIRECTORY_NAME
		do
			create l_dn.make_from_string (environment.destination_folder)
			l_dn.extend_from_array (<<a_folder, clib>>)
			create l_directory.make_open_read (l_dn)
			Result := l_directory.is_empty
		end

	Def_file_extension: STRING is ".def"
			-- DLL definition file extension

feature {NONE} -- Onces

	conf_factory: CONF_PARSE_FACTORY is
			-- Configuration factory.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	conf_constants: CONF_CONSTANTS is
			-- Configuration constants.
		once
			create Result
		ensure
			result_not_void: Result /= Void
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
end
