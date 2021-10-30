note
	description: "Manager to build {LIBRARY_DATABASE}"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_MANAGER

inherit
	ANY

	SHARED_EXECUTION_ENVIRONMENT

	LIBRARY_INDEXER_OBSERVER
		redefine
			on_ecf_file_found,
			on_folder_enter,
			on_folder_leave,
			on_ecf_file_enter,
			on_ecf_file_leave,
			on_system_enter,
			on_system_leave,
			on_application_system,
			on_target,
			on_library,
			on_cluster,
			on_class
		end

	LOCALIZED_PRINTER

create
	make,
	make_with_database

feature {NONE} -- Initialization

	make (ctx: detachable LIBRARY_DATABASE_CONTEXT)
			-- Instantiate Current based on context `ctx'.
		do
			make_with_database (create {LIBRARY_DATABASE}.make (ctx))
		end

	make_with_database (db: like database)
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			database := db
			if attached db.context as ctx then
				create l_lib_indexer.make (ctx.to_table)
			else
				create l_lib_indexer.make (Void)
			end
			library_indexer := l_lib_indexer
			l_lib_indexer.register_observer (Current)

			is_verbose := True
			is_stopping_at_library := True
			is_indexing_class := True
			is_ignoring_redirection := True
		end

feature -- Access

	database: LIBRARY_DATABASE

	last_indexed_data: detachable LIBRARY_INFO

	is_updating: BOOLEAN
			-- Is updating `database' ?

feature -- Settings

	is_stopping_at_library: BOOLEAN

	is_indexing_class: BOOLEAN

	is_ignoring_redirection: BOOLEAN

	is_verbose: BOOLEAN

feature -- Change

	set_is_stopping_at_library (b: BOOLEAN)
		do
			is_stopping_at_library := b
		end

	set_is_indexing_class (b: BOOLEAN)
		do
			is_indexing_class := b
		end

	set_is_ignoring_redirection (b: BOOLEAN)
		do
			is_ignoring_redirection := b
		end

	set_is_verbose (b: BOOLEAN)
		do
			is_verbose := b
		end

	import_folders (a_folders: ITERABLE [PATH]; flag_is_recursive: BOOLEAN)
			-- Import ecf from folder `a_folder'.
			-- If `flag_is_recursive' then is recursive.
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			l_lib_indexer := library_indexer
			l_lib_indexer.reset
			l_lib_indexer.set_is_stopping_at_library (is_stopping_at_library)
			l_lib_indexer.set_is_indexing_class (is_indexing_class)
			l_lib_indexer.set_is_ignoring_redirection (is_ignoring_redirection)
			l_lib_indexer.scan (a_folders, flag_is_recursive)
			l_lib_indexer.execute
		end

	import_files (a_files: ITERABLE [PATH])
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			l_lib_indexer := library_indexer
			l_lib_indexer.reset
			l_lib_indexer.set_is_stopping_at_library (is_stopping_at_library)
			across
				a_files as ic
			loop
				l_lib_indexer.add_file (ic)
			end
			l_lib_indexer.execute
		end

	import_folder (a_folder: PATH; flag_is_recursive: BOOLEAN)
			-- Import ecf from folder `a_folder'.
			-- If `flag_is_recursive' then is recursive.
		do
			import_folders (<<a_folder>>, flag_is_recursive)
		end

	import_file (a_file: PATH)
		do
			import_files (<<a_file>>)
		end

	import_file_name (a_file_name: READABLE_STRING_GENERAL)
		do
			import_file (create {PATH}.make_from_string (a_file_name))
		end

feature -- Indexer

	library_indexer: LIBRARY_INDEXER

feature -- Visit

	on_ecf_file_found (p: PATH)
		do
		end

	on_folder_enter (p: PATH)
		do
		end

	on_folder_leave (p: PATH)
		do
		end

	on_ecf_file_enter (p: PATH)
		do
--			if is_verbose then
--				print ("# ")
--				localized_print (p.name)
--				print ("%N")
--			end
		end

	on_ecf_file_leave (p: PATH)
		do
--			if is_verbose then
--				print ("%N")
--			end
		end

	on_system_enter (a_cfg: CONF_SYSTEM)
		do
			check last_indexed_data = Void end
			create last_indexed_data.make_from_conf_system (a_cfg)
		ensure then
			has_last_indexed_data: last_indexed_data /= Void
		end

	on_system_leave (a_cfg: CONF_SYSTEM)
		local
			d: like last_indexed_data
			db: Like database
		do
			check last_indexed_data /= Void end
			d := last_indexed_data
			if
				d /= Void and then
				not d.is_testing_project
			then
				db := database
				if db.has (d) then
--					check already_recorded: False end
					db.force (d)
				else
					db.put (d)
				end
			end
			last_indexed_data := Void
		ensure then
			no_last_indexed_data: last_indexed_data = Void
		end

	on_application_system (a_cfg: CONF_SYSTEM)
		local
			t: CONF_TARGET
		do
			if is_verbose then
				debug
					print ("  This is not a library.%N")
				end
				across
					a_cfg.targets as ic
				loop
					t := ic
					on_target (t)
					across
						t.libraries as lib_ic
					loop
						on_library (lib_ic)
					end

				end
			end
		end

	on_target (a_target: CONF_TARGET)
		local
--			l_options: CONF_OPTION
		do
--			if is_verbose then
--				print ("+ Target %"")
--				print (a_target.name)
--				print ("%"")
--				l_options := a_target.options
--				if l_options.void_safety.is_set then
--					print (" void-safe=%"")
--					print (l_options.void_safety.out)
--					print ("%"")
--				end
--				if l_options.is_attached_by_default then
--					print (" attached-by-default")
--				end
--				print ("%N")
--			end
		end

	on_library (a_library: CONF_LIBRARY)
		local
--			l_options: CONF_OPTION
		do
--			if is_verbose then
--				print (" - library: " + a_library.name)
--				l_options := a_library.options
--				if l_options.void_safety.is_set then
--					print (" (void-safe=%"")
--					print (l_options.void_safety.out)
--					print ("%")")
--				end
--				print ("%N")
--			end
			if attached last_indexed_data as d then
				d.add_dependency (a_library)
			end
		end

	on_cluster (a_cluster: CONF_CLUSTER)
		do
--			if is_verbose then
--				print (" - cluster: " + a_cluster.name)
--				print ("%N")
--			end
		end

	on_class (a_class: CONF_CLASS)
		do
--			if is_verbose then
--				print (" - class: " + a_class.name)
--				print ("%N")
--			end
			if attached last_indexed_data as d then
				d.classes.force (a_class.name)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
