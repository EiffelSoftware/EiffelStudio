note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER_APPLICATION

inherit
	ANY
	SHARED_FILE_SYSTEM

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
			l_file_path: PATH
		do
			is_verbose := a_options.is_verbose

			create l_file_path.make_from_string ("library.db")

			db := saved_database (l_file_path)
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
					create db.make
				end

				create l_db_manager.make_with_database (db)
				index_all (l_db_manager, a_options, is_updating)
				check l_db_manager.database = db end
				save_database (db, l_file_path)
			else
				print ("Database loaded%N")
			end

			if attached a_options.searching_term as t then
				execute_class_query (t, db)
			end
		end

	deep_visit (a_options: LIBRARY_INDEXER_ARGUMENTS)
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			l_arg_dirs: LIST [PATH]
			vvv: PACKAGE_CONF_VISITOR
			l_limit: INTEGER
		do
			l_limit := a_options.recursion_limit

			create vvv.make
			across
				a_options.files as ic
			loop
				vvv.visit_ecf_file (ic.item)
			end

			l_arg_dirs := a_options.directories
			if l_arg_dirs.is_empty then
				if a_options.files.is_empty then
						-- No files or directories, use current directory
					if l_limit > 0 then
						vvv.visit_folder_with_depth (execution_environment.current_working_path, l_limit)
					else
						vvv.visit_folder (execution_environment.current_working_path)
					end
				end
			else
				across
					l_arg_dirs as ic
				loop
					if l_limit > 0 then
						vvv.visit_folder_with_depth (ic.item, l_limit)
					else
						vvv.visit_folder (ic.item)
					end
				end
			end
		end

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
			create l_lib_indexer.make

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
--			l_lib_indexer.execute
			a_dbm.import_files (l_lib_indexer.files)
		end

	execute_class_query (a_classname: READABLE_STRING_8; db: LIBRARY_DATABASE)
		local
			q: LIBRARY_DATABASE_QUERY
		do
			print ("Libraries containing {" + a_classname + "} -> ")
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
						localized_print (ic.key.location.name)
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

feature -- Storage

	save_database (db: detachable LIBRARY_DATABASE; a_file_path: PATH)
		local
			sed: SED_STORABLE_FACILITIES
			w: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			if db /= Void then
				create f.make_with_path (a_file_path)
				f.open_write
				create w.make_for_writing (f)
				create sed
				sed.basic_store (db, w, True)
				f.close
			else
				create f.make_with_path (a_file_path)
				if f.exists then
					f.delete
				end
			end
		end

	has_saved_database (a_file_path: PATH): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_file_path)
			Result := f.exists and then f.is_access_readable
		end

	saved_database (a_file_path: PATH): detachable LIBRARY_DATABASE
		local
			sed: SED_STORABLE_FACILITIES
			r: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			create f.make_with_path (a_file_path)
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
		do
			if is_verbose then
				print ("+ Target %"")
				print (a_target.name)
				print ("%"%N")
			end
		end

	on_library (a_library: CONF_LIBRARY)
		do
			if is_verbose then
				print (" - library: " + a_library.name)
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
			if is_verbose then
				print (" - class: " + a_class.name)
				print ("%N")
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
