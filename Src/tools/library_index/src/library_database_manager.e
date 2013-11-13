note
	description: "Summary description for {LIBRARY_DATABASE_MANAGER}."
	author: ""
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

	make
			-- Instantiate Current.
		do
			make_with_database (create {LIBRARY_DATABASE}.make)
		end

	make_with_database (db: like database)
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			database := db

			is_verbose := True
			create l_lib_indexer.make
			library_indexer := l_lib_indexer
			l_lib_indexer.register_observer (Current)
		end

feature -- Access

	database: LIBRARY_DATABASE

feature -- Settings

	is_verbose: BOOLEAN

feature -- Change

	import_folders (a_folders: ITERABLE [PATH]; flag_is_recursive: BOOLEAN)
			-- Import ecf from folder `a_folder'.
			-- If `flag_is_recursive' then is recursive.
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			l_lib_indexer := library_indexer
			l_lib_indexer.reset
			l_lib_indexer.scan (a_folders, flag_is_recursive)
			l_lib_indexer.execute
		end

	import_folder (a_folder: PATH; flag_is_recursive: BOOLEAN)
			-- Import ecf from folder `a_folder'.
			-- If `flag_is_recursive' then is recursive.
		do
			import_folders (<<a_folder>>, flag_is_recursive)
		end

	import_files (a_files: ITERABLE [PATH])
		local
			l_lib_indexer: LIBRARY_INDEXER
		do
			l_lib_indexer := library_indexer
			l_lib_indexer.reset
			across
				a_files as ic
			loop
				l_lib_indexer.add_file (ic.item)
			end
			l_lib_indexer.execute
		end

	import_file (a_file: PATH)
		do
			import_files (<<a_file>>)
		end

	import_file_name (a_file_name: READABLE_STRING_GENERAL)
		do
			import_file (create {PATH}.make_from_string (a_file_name))
		end

feature {NONE} -- Implementation

	library_indexer: LIBRARY_INDEXER

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

	last_indexed_data: detachable LIBRARY_INFO

	is_updating: BOOLEAN
			-- Is updating `database' ?

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
			db: Like database
		do
			check last_indexed_data /= Void end
			d := last_indexed_data
			if
				d /= Void and then
				not d.is_testing_project
			then
				db := database
				if db.has (d.uuid.out) then
--					check already_recorded: False end
					db.force (d)
				else
					db.put (d)
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
