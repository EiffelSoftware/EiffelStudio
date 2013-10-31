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
			on_system_enter,
			on_system_leave,
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
			flag_is_new: BOOLEAN
		do
			is_verbose := a_options.is_verbose

			if a_options.reset_requested then
				if has_saved_database then
					print ("Reset database%N")
				end
				flag_is_new := True
				database := Void
			else
				database := saved_database
				if database /= Void then
					print ("Database loaded%N")
				end
			end
			index_all (a_options, flag_is_new)

			if attached a_options.searching_term as t then
				execute_class_query (t)
			end
		end

	deep_visit (a_options: LIBRARY_INDEXER_ARGUMENTS)
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			l_arg_dirs: LIST [PATH]
			vvv: PACKAGE_CONF_VISITOR
		do
			if a_options.use_directory_recursion then
				create vvv.make
			else
				create vvv.make_with_depth (1)
			end
			across
				a_options.files as ic
			loop
				vvv.visit_ecf_file (ic.item)
			end

			l_arg_dirs := a_options.directories
			if l_arg_dirs.is_empty then
				if a_options.files.is_empty then
						-- No files or directories, use current directory
					vvv.visit_folder (execution_environment.current_working_path)
				end
			else
				across
					l_arg_dirs as ic
				loop
					vvv.visit_folder (ic.item)
				end
			end
		end

	index_all (a_options: LIBRARY_INDEXER_ARGUMENTS; flag_is_new: BOOLEAN)
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			l_is_new: BOOLEAN
			l_arg_dirs: LIST [PATH]
			l_lib_indexer: LIBRARY_INDEXER
			db: like saved_database
			lst: ARRAYED_LIST [PATH]
		do
			is_updating := a_options.update_requested

			l_is_new := flag_is_new
			if l_is_new then
				create db.make
				database := db
			else
				db := database
				if db = Void then
					l_is_new := True
					create db.make
					database := db
				end
			end
			if l_is_new or is_updating then
				if is_updating then
					print ("Updating database%N")
				end
				if a_options.use_directory_recursion then
					create l_lib_indexer.make
				else
					create l_lib_indexer.make_with_depth (1)
				end

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

				save_database (db)
			else
				database := db
			end
		end

	execute_class_query (a_classname: READABLE_STRING_8)
		local
			q: LIBRARY_DATABASE_QUERY
		do
			print ("Libraries containing {" + a_classname + "} -> ")
			if attached database as db then
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
			else
				print (" ERROR database not found!%N")
			end
		end

feature -- Access

	database: detachable LIBRARY_DATABASE

	last_indexed_data: detachable LIBRARY_INFO

	is_updating: BOOLEAN
			-- Is updating `database' ?

feature -- Storage

	save_database (db: detachable LIBRARY_DATABASE)
		local
			sed: SED_STORABLE_FACILITIES
			w: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			if db /= Void then
				create f.make_with_name ("library.db")
				f.open_write
				create w.make_for_writing (f)
				create sed
				sed.basic_store (db, w, True)
				f.close
			else
				create f.make_with_name ("library.db")
				if f.exists then
					f.delete
				end
			end
		end

	has_saved_database: BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_name ("library.db")
			Result := f.exists and then f.is_access_readable
		end

	saved_database: detachable LIBRARY_DATABASE
		local
			sed: SED_STORABLE_FACILITIES
			r: SED_MEDIUM_READER_WRITER
			f: RAW_FILE
		do
			create f.make_with_name ("library.db")
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

	on_system_enter (a_cfg: CONF_SYSTEM)
		do
			check last_indexed_data = Void end
			create last_indexed_data.make (a_cfg)
			check last_indexed_data /= Void end
		end

	on_system_leave (a_cfg: CONF_SYSTEM)
		local
			d: like last_indexed_data
		do
			check last_indexed_data /= Void end
			d := last_indexed_data
			if
				d /= Void and then
				not d.is_testing_project
			then
				if attached database as db then
					if db.has (d.uuid.out) then
--						check already_recorded: False end
						db.force (d)
					else
						db.put (d)
					end
				else
					check has_database: False end
				end
			end
			last_indexed_data := Void
			check last_indexed_data = Void end
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
			if attached last_indexed_data as d then
				d.add_dependency (a_library)
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
			if attached last_indexed_data as d then
				d.classes.force (a_class.name)
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
