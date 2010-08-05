note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE

inherit
	SVN_CONSTANTS
		redefine
			default_create
		end

	SHARED_PROCESS_MISC
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			set_svn_executable_path ("svn")
		end

feature -- Access

	svn_executable_path: STRING

feature -- Element change

	set_svn_executable_path (v: like svn_executable_path)
		do
			svn_executable_path := v
		end

feature -- Status report

	statuses (a_path: STRING; is_verbose, is_recursive, is_remote: BOOLEAN): detachable LIST [SVN_STATUS_INFO]
		do
			Result := impl_statuses (Void, a_path, is_verbose, is_recursive, is_remote)
		end

	list_of_nodes_from (a_path: STRING; is_verbose, is_recursive, is_remote: BOOLEAN): detachable LIST [SVN_STATUS_INFO]
		obsolete
			"use statuses"
		do
			Result := statuses (a_path, is_verbose, is_recursive, is_remote)
		end

	repository_info (a_location: STRING): detachable SVN_REPOSITORY_INFO
		local
			s: detachable STRING
			cmd: STRING
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ("Fetch svn info from [" + a_location + "] %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (" --xml info ")
			cmd.append_string (a_location)

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			s := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if s = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
--				s.replace_substring_all ("%R%N", "%N")

				l_svn_xml_manager := svn_xml_manager
				if l_svn_xml_manager = Void then
					create l_svn_xml_manager
					svn_xml_manager := l_svn_xml_manager
 				end
				Result := l_svn_xml_manager.string_to_repository_info (a_location, s)
			end
		end

	diff (a_location: STRING; a_start, a_end: INTEGER): detachable STRING
		local
			s: detachable STRING
			cmd: STRING
		do
			debug ("SVN_ENGINE")
				print ("Fetch svn info from [" + a_location + "] %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (" diff ")
			cmd.append_string (a_location)

			if a_start > 0 then
				cmd.append_string (" -r")
				if a_end > a_start then
					cmd.append_integer (a_start)
					cmd.append_character (':')
					cmd.append_integer (a_end)
				else
					cmd.append_integer (a_start - 1)
					cmd.append_character (':')
					cmd.append_integer (a_start)
				end
			end
--			cmd.append_string (" --summarize ")

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			s := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if s = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end

				Result := s
			end
		end

	logs (a_location: STRING; is_verbose: BOOLEAN; a_start, a_end: INTEGER; a_limit: INTEGER): detachable LIST [SVN_REVISION_INFO]
		local
			s: detachable STRING
			cmd: STRING
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ("Fetch svn logs from [" + a_location + "] (range [" + a_start.out + ".." + a_end.out + "] limit of " + a_limit.out + " entries) %N")
			end

			create cmd.make_from_string (svn_executable_path)
			if is_verbose then
				cmd.append_string (" -v ")
			end
			if a_start > 0 then
				cmd.append_string (" -r" + a_start.out)
				if a_end > a_start then
					cmd.append_string (":" + a_end.out)
				end
			end
			if a_limit > 0 then
				cmd.append_string (" --limit " + a_limit.out)
			end
			cmd.append_string (" --xml log ")
			cmd.append_string (a_location)

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			s := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if s = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
--				s.replace_substring_all ("%R%N", "%N")

				l_svn_xml_manager := svn_xml_manager
				if l_svn_xml_manager = Void then
					create l_svn_xml_manager
					svn_xml_manager := l_svn_xml_manager
 				end
				Result := l_svn_xml_manager.string_to_logs (a_location, s)
			end
		end

feature {NONE} -- impl

	svn_xml_manager: detachable SVN_XML_MANAGER

	impl_statuses (a_prefix_path: detachable STRING; a_path: STRING; is_verbose, is_recursive, is_remote: BOOLEAN): detachable ARRAYED_LIST [SVN_STATUS_INFO]
		local
			s: detachable STRING
			cmd: STRING
			info: SVN_STATUS_INFO
			lst, lst2: detachable ARRAYED_LIST [SVN_STATUS_INFO]
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ("Fetch svn info from [" + a_path + "] (is_recursive=" + is_recursive.out + ") %N")
			end

			create cmd.make_from_string (svn_executable_path)
			if not is_recursive then
				cmd.append_string (" -N ")
			end
			if is_verbose then
				cmd.append_string (" -v ")
			end
			if is_remote then
				cmd.append_string (" -u ")
			end
			cmd.append_string (" --xml status ")

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			s := process_misc.output_of_command (cmd, a_path)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if s = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end

				l_svn_xml_manager := svn_xml_manager
				if l_svn_xml_manager = Void then
					create l_svn_xml_manager
					svn_xml_manager := l_svn_xml_manager
 				end
-- 				s.replace_substring_all ("%R%N", "%N")
				Result := l_svn_xml_manager.string_to_status_on_pathes (a_prefix_path, a_path, s)
				if is_recursive and Result /= Void and then Result.count > 0 then
					from
						Result.start
						create lst.make (10)
					until
						Result.after
					loop
						info := Result.item_for_iteration
						inspect info.wc_status_code
						when
							status_external,
							status_unknown,
							status_obstructed
						then
							if info.path_is_directory then
								debug ("SVN_ENGINE")
									print ("Explore [" + info.absolute_path + "] %N")
								end
								lst2 := impl_statuses (info.display_path, info.absolute_path.string, is_verbose, is_recursive, is_remote)
								if lst2 /= Void and then lst2.count > 0 then
									lst.append (lst2)
								end
							end
						else
						end
						Result.forth
					end
					if lst /= Void and then lst.count > 1 then
						Result.append (lst)
					end
				end
			end
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
