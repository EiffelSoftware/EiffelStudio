note
	description: "Summary description for {LIBRARY_INDEXER}."
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER

inherit
	SHARED_EXECUTION_ENVIRONMENT

	LIBRARY_INDEXER_OBSERVER_FORWARD
		rename
			make as make_observers
		end

	PACKAGE_CONF_VISITOR
		rename
			make as make_visitor,
			reset as reset_visitor
		export
			{NONE} all
		redefine
			visit_ecf_file,
			visit_system,
			visit_target,
			visit_library,
			visit_cluster,
			visit_class
		end

create
	make

feature {NONE} -- Initialization

	make (opts: detachable STRING_TABLE [READABLE_STRING_GENERAL])
		do
			make_visitor
			if opts /= Void then
				if attached opts.item ("is_il_generation") as s then
					is_il_generation := s.is_case_insensitive_equal ("True")
				else
					is_il_generation := False
				end
				set_platform (opts.item ("platform"))
				set_concurrency (opts.item ("concurrency"))
				set_build (opts.item ("build"))
			end

			make_observers (0)
			create files.make (0)
		end

feature -- Access

	files: ARRAYED_LIST [PATH]

	count: INTEGER
		do
			Result := files.count
		end

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

feature -- Settings

	include_application_target: BOOLEAN

feature -- Settings change

	set_include_application_target (b: BOOLEAN)
		do
			include_application_target := b
		end

feature -- Change

	reset
		do
			files.wipe_out
			reset_visitor
		end

	scan (a_locations: ITERABLE [PATH]; flag_is_recursive: BOOLEAN)
		local
			l_scanner: LIBRARY_ECF_SCANNER
		do
			if flag_is_recursive then
				create l_scanner.make
			else
				create l_scanner.make_with_depth (1)
			end
			across
				a_locations as ic
			loop
				on_folder_enter (ic.item)
				l_scanner.process_directory (ic.item)
				on_folder_leave (ic.item)
			end

			across
				l_scanner.items as ic
			loop
				add_file (ic.item)
			end
		end

	add_file (p: PATH)
		do
			files.force (p)
			on_ecf_file_found (p)
		end

	remove_file (p: PATH)
		do
			files.prune_all (p)
		end

feature -- Execution

	execute
		local
			p: PATH
			f: RAW_FILE
		do
			across
				files as ic
			loop
				p := ic.item
				if p.is_empty then
				else
					create f.make_with_path (p)
					if f.exists and then f.is_access_readable then
						visit_ecf_file (p)
					else
						debug
							print ("Invalid file ["+ p.utf_8_name +"]!%N")
						end
					end
				end
			end
		end

	visit_ecf_file (p: PATH)
		do
			on_ecf_file_enter (p)
			Precursor {PACKAGE_CONF_VISITOR}(p)
			on_ecf_file_leave (p)
		end

	visit_system (a_system: CONF_SYSTEM)
		local
			b_continue: BOOLEAN
		do
			if attached a_system.library_target as l_target then
				if attached l_target.root as l_root then
					b_continue := l_root.is_all_root
				else
						-- Only lib unless `include_application_target' is set to True
					b_continue := include_application_target
				end
				if b_continue then
					on_system_enter (a_system)
					Precursor {PACKAGE_CONF_VISITOR}(a_system)
					on_system_leave (a_system)
				end
			else
					-- Only library target is relevant
			end

		end

	visit_target (a_target: CONF_TARGET)
		do
			if a_target = a_target.system.library_target then
				on_target (a_target)
				Precursor {PACKAGE_CONF_VISITOR}(a_target)
			else
				-- Only library target is relevant
			end
		end

	visit_library (a_library: CONF_LIBRARY)
		do
			if
				attached last_state as l_state and then
				a_library.is_enabled (l_state)
			then
				on_library (a_library)
			end
			Precursor {PACKAGE_CONF_VISITOR}(a_library)
		end

	visit_cluster (a_cluster: CONF_CLUSTER)
		do
			if a_cluster.is_hidden then
					-- Class are not "visible"
			else
				on_cluster (a_cluster)
				Precursor {PACKAGE_CONF_VISITOR}(a_cluster)
			end
		end

	visit_class (a_class: CONF_CLASS)
		do
			on_class (a_class)
			Precursor {PACKAGE_CONF_VISITOR}(a_class)
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
