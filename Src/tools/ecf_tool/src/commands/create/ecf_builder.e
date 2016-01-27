note
	description: "[
				ECF builder code.
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_BUILDER

inherit
	LOCALIZED_PRINTER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (args: ECF_CREATE_APPLICATION_ARGUMENTS)
		local
			app_ecf: detachable APPLICATION_ECF
			vis: ECF_PRINT_VISITOR
			conf_sys_builder_vis: ECF_SYSTEM_BUILDER_VISITOR
			ecf: ECF
		do
			create errors.make (0)
			create warnings.make (0)

			verbose := args.verbose

			if verbose then
				io.output.put_string ("Verbose=" + verbose.out + "%N")
			end

			if args.is_application_target then
				create app_ecf.make (args.target_name)
				ecf := app_ecf
			elseif args.is_library_target then
				create {LIBRARY_ECF} ecf.make (args.target_name)
			elseif args.is_testing_target then
				create {TESTING_ECF} app_ecf.make (args.target_name)
				ecf := app_ecf
			else
				--| Default ...
				create {LIBRARY_ECF} ecf.make (args.target_name)
			end
			ecf.set_syntax (args.syntax_mode)
			ecf.set_uuid (args.uuid)

			if app_ecf /= Void then
				if attached args.executable_name as s then
					app_ecf.set_executable_name (s)
				end
				if attached args.root_info as tu then
					if args.is_testing_target then
						print ("Ignoring provided root_info settings%N")
					else
						if attached tu.cluster as l_root_cluster then
							app_ecf.set_root_info (l_root_cluster, tu.class_name, tu.feature_name)
						else
							app_ecf.set_root_info (Void, tu.class_name, tu.feature_name)
						end
					end
				end
				if args.is_testing_target then
					print ("Ignoring provided console_application settings%N")
				else
					app_ecf.set_is_console_application (args.is_console_application)
				end
				if attached args.concurrency as l_concurrency then
					app_ecf.set_concurrency (l_concurrency)
				end
			end
			if attached args.clusters as l_clusters then
				across
					l_clusters as cl
				loop
					ecf.clusters.force (cl.item)
				end
			end
			if attached args.tests_clusters as l_clusters then
				across
					l_clusters as cl
				loop
					ecf.tests_clusters.force (cl.item)
				end
			end
			if attached args.libraries as l_libraries then
				across
					l_libraries as libs
				loop
					ecf.libraries.force (libs.item)
				end
			end

			if not ecf.libraries.has ("base") then
				ecf.libraries.force ("base")
			end
			if args.is_testing_target and then not ecf.libraries.has ("testing") then
				ecf.libraries.force ("testing")
			end
			if not args.is_testing_target and ecf.clusters.is_empty then
				ecf.clusters.force (".")
			end
			if args.is_testing_target and ecf.tests_clusters.is_empty then
				ecf.tests_clusters.force (".")
			end

			if app_ecf /= Void and then app_ecf.concurrency.is_case_insensitive_equal ("thread") then
				if not ecf.libraries.has ("thread") then
					ecf.libraries.force ("thread")
				end
			end

			create vis
			ecf.process (vis)

			create conf_sys_builder_vis.make

			ecf.process (conf_sys_builder_vis)
			if attached conf_sys_builder_vis.system as l_system then
				conf_sys_builder_vis.reset
				l_system.set_file_name (ecf_file_name (ecf, args.base_location).name)
				save_system (l_system, ecf, args.base_location, args.execution_forced)
			end

			ecf.set_is_voidsafe (True)
			ecf.process (conf_sys_builder_vis)
			if attached conf_sys_builder_vis.system as l_system then
				conf_sys_builder_vis.reset
				l_system.set_file_name (ecf_file_name (ecf, args.base_location).name)
				save_system (l_system, ecf, args.base_location, args.execution_forced)
			end

			if
				args.is_application_target and then
				attached args.root_info as l_root_info
			then
				if attached args.clusters as l_clusters and then not l_clusters.is_empty then
					if
						attached l_root_info.cluster as cl and then
						across l_clusters as ic some ic.item.is_case_insensitive_equal_general (cl) end
					then
						ensure_root_class_exists (args.base_location, cl, l_root_info.class_name, l_root_info.feature_name)
					else
						ensure_root_class_exists (args.base_location, l_clusters.first, l_root_info.class_name, l_root_info.feature_name)
					end
				else
					ensure_root_class_exists (args.base_location, Void, l_root_info.class_name, l_root_info.feature_name)
				end
			end
		end

	ensure_root_class_exists (a_dir: PATH; a_cluster: detachable READABLE_STRING_GENERAL; a_classname: READABLE_STRING_8; a_feature_name: READABLE_STRING_8)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				p := a_dir
				if a_cluster /= Void then
					p := p.extended (a_cluster)
				end
				p := p.extended (a_classname.as_lower).appended_with_extension ("e")
				create f.make_with_path (p)
				if not f.exists then
					f.create_read_write
					f.put_string ("{
note
	description: "[
			Enter class description here!
		]"

class
							}")
					f.put_string ("%N%T" + a_classname + "%N%N")
					f.put_string ("create%N%T" + a_feature_name + "%N%N")
					f.put_string ("feature {NONE} -- Initialization%N%N")
					f.put_string ("%T" + a_feature_name + "%N")
					f.put_string ("{
			-- Instantiate Current object.
		do
		end

end
						}"
					)
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Storage

	ecf_file_name (ecf: ECF; dir: PATH): PATH
			-- Expected file name for output `ecf'.
		do
			if ecf.is_voidsafe then
				Result := dir.extended (ecf.name + "-safe")
			else
				Result := dir.extended (ecf.name)
			end
			Result := Result.appended_with_extension ("ecf")
		end

	save_system (a_system: CONF_SYSTEM; ecf: ECF; dir: PATH; a_force: BOOLEAN)
		local
			fn: PATH
			f: PLAIN_TEXT_FILE
		do
			fn := a_system.file_path

			create f.make_with_path (fn)
			if f.exists and not a_force then
				localized_print_error ({STRING_32} "File %""+ fn.name + "%" already exists ... delete it before!%N")
			elseif f.exists and not f.is_writable then
				localized_print_error ({STRING_32} "File %""+ fn.name +"%" already exists and is not writable!%N")
			else
				a_system.store
				if not a_system.store_successful then
					localized_print_error ({STRING_32} "Error while saving to %""+ fn.name +"%"!%N")
				end
			end
		end

feature -- Access

	verbose: BOOLEAN

	errors: ARRAYED_LIST [READABLE_STRING_GENERAL]
	warnings: ARRAYED_LIST [READABLE_STRING_GENERAL]

feature -- Basic operation

	same_path (p1, p2: READABLE_STRING_GENERAL): BOOLEAN
		local
			s1, s2: STRING_32
		do
			create s1.make_from_string (p1.as_string_32)
			create s2.make_from_string (p2.as_string_32)
			s1.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
			s2.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
			Result := s1.same_string (s2)
		end

feature {NONE} -- Implementation

	report_warning (m: READABLE_STRING_GENERAL)
		do
			warnings.extend (m)
			if verbose then
				localized_print ({STRING_32} "[Warning] " + m.to_string_32)
				io.error.put_new_line
			end
		end

	report_progress (m: READABLE_STRING_GENERAL)
		do
			localized_print (m)
			io.output.put_new_line
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			errors.extend (m)
			if verbose then
				localized_print_error ({STRING_32} "[Error] " + m.to_string_32)
				io.error.put_new_line
			end
		end

	relative_path (a: PATH; b: PATH): PATH
		local
			a_lst, b_lst: LIST [PATH]
			done: BOOLEAN
		do
			a_lst := a.components
			b_lst := b.components
			create Result.make_empty
			from
				a_lst.start
				b_lst.start
			until
				a_lst.after or b_lst.after or done
			loop
				if a_lst.item.name.same_string (b_lst.item.name) then
					Result := Result.extended_path (a_lst.item)
					b_lst.remove
					a_lst.remove
				else
					done := True
				end
			end
			if Result.is_empty then
				Result := b
			else
				create Result.make_empty
					-- Remove filename
				b_lst.finish
				if not b_lst.after then
					b_lst.remove
				end
					-- put the ..
				across
					b_lst as c
				loop
					Result := Result.extended ("..")
				end
				across
					a_lst as c
				loop
					Result := Result.extended_path (c.item)
				end

			end
		end

feature {NONE} -- Path manipulation

	reduced_path (fn: READABLE_STRING_GENERAL; a_depth: INTEGER): STRING_GENERAL
		local
			lst: like segments_from_string
		do
			create {STRING_32} Result.make (fn.count)
			lst := segments_from_string (fn)
			if a_depth > 0 then
				from
					lst.start
				until
					lst.count = a_depth
				loop
					lst.remove
				end
			end
			if fn.starts_with ("/") then
				Result.append ("/")
			end
			append_segments_to_string (lst, Result)
		end

	common_segment_count (p1, p2: detachable READABLE_STRING_GENERAL): INTEGER
			-- Number of segments common between p1 and p2 starting from the left.
		do
			if
				(p1 /= Void and then attached segments_from_string (p1) as lst_1) and
				(p2 /= Void and then attached segments_from_string (p2) as lst_2)
			then
				from
					lst_1.start
					lst_2.start
				until
					lst_1.after or lst_2.after
				loop
					if lst_1.item.same_string (lst_2.item) then
						Result := Result  + 1
					else
						lst_1.finish
						lst_2.finish
					end
					lst_1.forth
					lst_2.forth
				end
			end
		end

	append_segments_to_string (lst: LIST [READABLE_STRING_GENERAL]; s: STRING_GENERAL)
		do
			across
				lst as curs
			loop
				if
					not s.is_empty and then
					not s.ends_with ("/")
				then
					s.append ("/")
				end
				s.append (curs.item)
			end
		end

	segments_from_string (fn: READABLE_STRING_GENERAL): ARRAYED_LIST [READABLE_STRING_GENERAL]
		local
			c_slash, c_bslash: NATURAL_32
			i,p,n: INTEGER
			c: NATURAL_32
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			c_slash := ('/').natural_32_code
			c_bslash := ('\').natural_32_code
			from
				create lst.make (2)
				i := 1
				p := 1
				n := fn.count
			until
				i > n
			loop
				c := fn.code (i)
				if c = c_slash or c = c_bslash then
					lst.extend (fn.substring (p, i - 1))
					p := i + 1
				end
				i := i + 1
			end
			if i > p then
				lst.extend (fn.substring (p, n))
			end
			from
				lst.start
			until
				lst.after
			loop
				if not lst.isfirst and then lst.item.same_string ("..") then
					lst.remove_left
					lst.remove
				elseif lst.item.same_string (".") then
					lst.remove
				else
					lst.forth
				end
			end
			Result := lst
		end

	absolute_directory_path (dn: PATH): PATH
		do
			create Result.make_from_string (reduced_path (dn.absolute_path.name, 0))
		end

feature -- Constants

	library_target_type: STRING = "library"
	application_target_type: STRING = "application"
	testing_target_type: STRING = "testing"

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
