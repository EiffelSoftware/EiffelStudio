note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER

inherit
	TARGET_INDEXER
		redefine
			make,
			reset,
			visit_ecf_file,
			visit_system,
			visit_target
		end

create
	make

feature {NONE} -- Initialization

	make (opts: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL])
		do
			Precursor (opts)
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
			Precursor
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
				on_folder_enter (ic)
				l_scanner.process_directory (ic)
				on_folder_leave (ic)
			end

			across
				l_scanner.items as ic
			loop
				add_file (ic)
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
				p := ic
				if not p.is_empty then
					create f.make_with_path (p)
					if f.exists and then f.is_access_readable then
						visit_ecf_file (p)
					else
						debug
							print ("Invalid file [" + p.utf_8_name + "]!%N")
						end
					end
				end
			end
		end

	visit_ecf_file (p: PATH)
		do
			on_ecf_file_enter (p)
			Precursor (p)
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
					Precursor (a_system)
					on_system_leave (a_system)
				end
			else
				on_application_system (a_system)
			end
		end

	visit_target (a_target: CONF_TARGET)
		do
			if a_target = a_target.system.library_target then
				Precursor (a_target)
			else
					-- Only library target is relevant
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
