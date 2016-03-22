note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER_APPLICATION

inherit
	ANY
--	SHARED_FILE_SYSTEM

	SHARED_EXECUTION_ENVIRONMENT

	LIBRARY_INDEXER_OBSERVER
		redefine
			on_ecf_file_found,
			on_folder_enter,
			on_folder_leave,
			on_ecf_file_enter,
			on_ecf_file_leave,
--			on_system_enter,
--			on_system_leave,
			on_target,
			on_library,
			on_cluster,
			on_class
		end

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			arg_parser: LIBRARY_INDEXER_ARGUMENTS
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				create arg_parser.make
				arg_parser.execute (agent start (arg_parser))
			end
		rescue
			l_rescued := True
			retry
		end

feature {NONE} -- Execution

	is_verbose: BOOLEAN

	start (a_options: LIBRARY_INDEXER_ARGUMENTS)
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			db: like saved_database
			l_db_manager: LIBRARY_DATABASE_MANAGER
			is_updating: BOOLEAN
			ctx: LIBRARY_DATABASE_CONTEXT
		do
			is_verbose := a_options.is_verbose

			variables := a_options.variable_definitions

			create ctx.make
			ctx.set_platform (a_options.platform)
			ctx.set_concurrency (a_options.concurrency)
			ctx.set_void_safety (a_options.void_safety)
			ctx.set_is_il_generation (a_options.is_dotnet)
			ctx.set_build (a_options.build)
			ctx.use_any_settings (a_options.is_any)

			if not a_options.reset_requested then
				db := saved_database (ctx)
			end
			if db = Void or a_options.reset_requested or a_options.update_requested then
				if db /= Void then
					if a_options.reset_requested then
						if is_verbose then
							print ("Reset database%N")
						end
						db.wipe_out
					else
						check a_options.update_requested end
						is_updating := True
						if is_verbose then
							print ("Update database%N")
						end
					end
				else
					if is_verbose then
						print ("Building database%N")
					end
					create db.make (ctx)
				end

				create l_db_manager.make_with_database (db)
				l_db_manager.set_is_stopping_at_library (a_options.is_only_libs)
				l_db_manager.set_is_verbose (a_options.is_verbose)

				reset_counters
				index_all (l_db_manager, a_options, is_updating)
				if is_verbose then
					print ("- ecf files: " + ecf_counter.out + "%N")
					print ("- classes  : " + class_counter.out + "%N")
				end
				check l_db_manager.database = db end
				save_database (db, ctx)
			else
				print ("Database loaded%N")
			end

			if a_options.is_browsing then
				execute_browsing (a_options.browsing_term, db)
			end

			if attached a_options.searching_term as t then
				execute_query (t, db)
			end
		end

	reset_counters
		do
			ecf_counter := 0
			class_counter := 0
		end

	variables: detachable STRING_TABLE [READABLE_STRING_32]

	ecf_counter: INTEGER
	class_counter: INTEGER

	index_all (a_dbm: LIBRARY_DATABASE_MANAGER; a_options: LIBRARY_INDEXER_ARGUMENTS; is_updating: BOOLEAN)
		require
			a_dbm_attached: a_dbm /= Void
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			db: LIBRARY_DATABASE
			l_arg_dirs: LIST [PATH]
			l_lib_indexer: LIBRARY_INDEXER
			lst: ARRAYED_LIST [PATH]
		do
			l_lib_indexer := a_dbm.library_indexer
--			l_lib_indexer.set_is_any_setting (a_options.is_any) -- Should be set last, if True.
			l_lib_indexer.register_observer (Current)

			across
				a_options.files as ic
			loop
				l_lib_indexer.add_file (ic.item)
			end

			l_arg_dirs := a_options.directories
			if l_arg_dirs.is_empty then
				if a_options.files.is_empty then
						-- No files or directories, use current directory
					l_lib_indexer.scan (<<execution_environment.current_working_path>>, a_options.use_directory_recursion)
				end
			else
				l_lib_indexer.scan (l_arg_dirs, a_options.use_directory_recursion)
			end
			print (l_lib_indexer.count.out + " ecf file(s).%N")

			if is_updating then
				create lst.make (0)
				db := a_dbm.database
				across
					l_lib_indexer.files as ic
				loop
					if db.has_ecf_file (ic.item) then
						if is_verbose then
							print ("File %"")
							localized_print (ic.item.name)
							print ("%" already indexed.%N")
						end
						lst.force (ic.item)
					else
					end
				end
				from
					lst.start
				until
					lst.after
				loop
					l_lib_indexer.remove_file (lst.item)
					lst.remove
				end
			end
			l_lib_indexer.execute
			l_lib_indexer.unregister_observer (Current)
		end

	execute_query (a_pattern: READABLE_STRING_8; db: LIBRARY_DATABASE)
		local
			p: INTEGER
		do
			p := a_pattern.index_of ('=', 1)
			if p > 0 then
				if a_pattern.starts_with_general ("lib=") then
					execute_library_query (a_pattern.substring (p + 1, a_pattern.count), db)
				elseif a_pattern.starts_with_general ("library=") then
					execute_library_query (a_pattern.substring (p + 1, a_pattern.count), db)
				else
					execute_class_query (a_pattern.substring (p + 1, a_pattern.count), db)
				end
			else
				execute_class_query (a_pattern, db)
			end
		end

	execute_library_query (a_libname: READABLE_STRING_8; db: LIBRARY_DATABASE)
		local
			q: LIBRARY_DATABASE_LIB_QUERY
		do
			print ("Libraries matching {" + a_libname + "} -> ")
			create q.make (db, a_libname)
			q.execute
			if attached q.items as lst then
				if lst.is_empty then
					print (" none.%N")
				else
					if lst.count = 1 then
						print ("%N")
					else
						print ("found " + lst.count.out + "%N")
					end
					across
						lst as ic
					loop
						browse_library_info (ic.key, db)
					end
				end
			end
		end

	execute_class_query (a_classname: READABLE_STRING_8; db: LIBRARY_DATABASE)
		local
			q: LIBRARY_DATABASE_CLASS_QUERY
		do
			print ("Search libraries with class name matching %"" + a_classname + "%" -> ")
			create q.make (db, a_classname)
			q.execute
			if attached q.items as lst then
				if lst.is_empty then
					print (" none.%N")
				else
					if lst.count = 1 then
						print ("%N")
					else
						print ("found " + lst.count.out + "%N")
					end
					across
						lst as ic
					loop
						print ("  ")
						print (ic.key.name)
						print (" @ ")
						print_library_location (ic.key.location)
						print ("%N")
						if q.pattern_has_wildchar then
							across
								ic.item as ic_classes
							loop
								print ("    - ")
								print (ic_classes.item)
								print ("%N")
							end
						end
					end
				end
			end
		end

	execute_browsing (a_name: detachable READABLE_STRING_32; db: LIBRARY_DATABASE)
		do
			print ("Browsing database:%N")
			print ("NOT YET IMPLEMENTED!%N")
		end

	browse_library_info (a_lib: LIBRARY_INFO; db: LIBRARY_DATABASE)
		do
			print ("  ")
			print (a_lib.name)
			print (" @ ")
			print_library_location (a_lib.location)
			print ("%N")
			if is_verbose then
				if attached a_lib.void_safety_option as l_void_safety_option then
					print ("    - void-safe=" + l_void_safety_option + "%N")
				end
				if attached a_lib.dependencies as l_deps then
					across
						l_deps as ic
					loop
						if attached db.item_by_location (ic.item.evaluated_location) as l_dep then
							localized_print ("    -> ")
							localized_print (l_dep.name)
							if attached l_dep.void_safety_option as l_void_safety_option then
								print (" (void-safe=" + l_void_safety_option + ")")
							end
							localized_print ("%N")
						else
							localized_print ("    -> ")
							localized_print (ic.item.name)
							localized_print ("%N")
						end
					end
				end
			end
		end

	print_library_location (p: PATH)
		local
			s: STRING_32
			l_done: BOOLEAN
		do
			s := p.name
			if attached variables as vars then
				across
					vars as ic
				until
					l_done
				loop
					if s.starts_with (ic.item) then
						l_done := True
						localized_print ("$")
						localized_print (ic.key)
						localized_print (s.tail (s.count - ic.item.count))
					end
				end
				if not l_done then
					localized_print (s)
				end
			else
				localized_print (s)
			end
		end

feature -- Storage

	database_location (ctx: LIBRARY_DATABASE_CONTEXT): PATH
		do
			if ctx.is_any_settings then
				Result := execution_environment.current_working_path.extended ("library-any.db")
			else
				Result := execution_environment.current_working_path.extended ("library-" + ctx.platform + ".db")
			end
		end

	save_database (db: detachable LIBRARY_DATABASE; ctx: LIBRARY_DATABASE_CONTEXT)
		local
			sed: SED_STORABLE_FACILITIES
			w: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			if db /= Void then
				check db.context ~ ctx end
				create f.make_with_path (database_location (ctx))
				f.open_write
				create w.make_for_writing (f)
				create sed
				sed.basic_store (db, w, True)
				f.close
			else
				create f.make_with_path (database_location (ctx))
				if f.exists then
					f.delete
				end
			end
		end

	has_saved_database (ctx: LIBRARY_DATABASE_CONTEXT): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_path (database_location (ctx))
			Result := f.exists and then f.is_access_readable
		end

	saved_database (ctx: LIBRARY_DATABASE_CONTEXT): detachable LIBRARY_DATABASE
		local
			sed: SED_STORABLE_FACILITIES
			r: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			create f.make_with_path (database_location (ctx))
			if f.exists and then f.is_access_readable then
				f.open_read
				create r.make_for_reading (f)
				if r.is_ready_for_reading then
					create sed
					if attached {like saved_database} sed.retrieved (r, False) as res then
						Result := res
					end
				end
				f.close
			end
		end

feature -- Visit

	on_ecf_file_found (p: PATH)
		do
			ecf_counter := ecf_counter + 1
		end

	on_folder_enter (p: PATH)
		do
		end

	on_folder_leave (p: PATH)
		do
		end

	on_ecf_file_enter (p: PATH)
		do
			if is_verbose then
				print ("# ")
				localized_print (p.name)
				print ("%N")
			end
		end

	on_ecf_file_leave (p: PATH)
		do
			if is_verbose then
				print ("%N")
			end
		end

	on_target (a_target: CONF_TARGET)
		local
			l_options: CONF_OPTION
		do
			if is_verbose then
				print ("+ Target %"")
				print (a_target.name)
				print ("%"")
				l_options := a_target.options
				if l_options.void_safety.is_set then
					print (" void-safe=%"")
					print (l_options.void_safety.out)
					print ("%"")
				end
				if l_options.is_attached_by_default then
					print (" attached-by-default")
				end
				print ("%N")
			end
		end

	on_library (a_library: CONF_LIBRARY)
		local
			l_options: CONF_OPTION
		do
			if is_verbose then
				print (" - library: " + a_library.name)
				l_options := a_library.options
				if l_options.void_safety.is_set then
					print (" (void-safe=%"")
					print (l_options.void_safety.out)
					print ("%")")
				end
				print ("%N")
			end
		end

	on_cluster (a_cluster: CONF_CLUSTER)
		do
			if is_verbose then
				print (" - cluster: " + a_cluster.name)
				print ("%N")
			end
		end

	on_class (a_class: CONF_CLASS)
		do
			class_counter := class_counter + 1

			if is_verbose then
				print (" - class: " + a_class.name)
				print ("%N")
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
