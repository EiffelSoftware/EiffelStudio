note
	description: "Implementation of {SVN} interface."
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE

inherit
	SVN
		rename
			print as ascii_print
		redefine
			default_create
		end

	SVN_CONSTANTS
		rename
			print as ascii_print
		redefine
			default_create
		end

	SHARED_PROCESS_MISC
		rename
			print as ascii_print
		redefine
			default_create
		end

	LOCALIZED_PRINTER
		rename
			print as ascii_print
		redefine
			default_create
		end

create
	default_create,
	make_with_executable_path

feature {NONE} -- Initialization

	default_create
		do
			make_with_executable_path ("svn")
		end

	make_with_executable_path (v: READABLE_STRING_GENERAL)
		do
			set_svn_executable_path (v)
		end

feature -- Access

	svn_executable_path: STRING_32

	svn_executable_location: PATH

feature -- Element change

	set_svn_executable_path (v: READABLE_STRING_GENERAL)
		do
			set_svn_executable_location (create {PATH}.make_from_string (v))
		end

	set_svn_executable_location (v: PATH)
		do
			svn_executable_location := v
			svn_executable_path := v.name
		end

feature -- Output

	print (a_str: detachable READABLE_STRING_GENERAL)
			-- Write `a_str' on standard output.
		do
			localized_print (a_str)
		end

feature -- Access tool info

	version: detachable IMMUTABLE_STRING_32
		local
			res: detachable PROCESS_COMMAND_RESULT
			cmd: STRING_32
		do
			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (" --version --quiet")
			res := process_misc.output_of_command (cmd, Void)
			if res /= Void and then res.exit_code = 0 then
				create Result.make_from_string_general (res.output)
			end
		end

feature -- Access: working copy

	statuses (a_path: READABLE_STRING_GENERAL; is_verbose, is_recursive, is_remote: BOOLEAN; a_options: detachable SVN_OPTIONS): detachable LIST [SVN_STATUS_INFO]
		do
			Result := impl_statuses (Void, create {PATH}.make_from_string (a_path), is_verbose, is_recursive, is_remote, a_options)
		end

	checkout (a_location: READABLE_STRING_GENERAL; a_path: READABLE_STRING_GENERAL; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn checkout from [" + a_location.as_string_32 + {STRING_32} "] into [" + a_path.as_string_32 +"].%N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" checkout ")

			if
				a_rev /= Void and then
				not a_rev.string.is_whitespace and then
				not a_rev.string.is_case_insensitive_equal_general ("0")
			then
				cmd.append_string_general (" -r")
				cmd.append_string_general (a_rev.string)
			end
			cmd.append_character (' ')

			cmd.append_string_general (a_location)
			cmd.append_string (" %"")
			cmd.append_string_general (a_path)
			cmd.append_string ("%"")

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
			end
		end

	update (a_changelist: SVN_CHANGELIST; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn update [" + a_changelist.as_command_line_arguments +"].%N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" update ")
			a_changelist.append_as_command_line_arguments_to (cmd)
			if
				a_rev /= Void and then
				not a_rev.string.is_whitespace and then
				not a_rev.string.is_case_insensitive_equal_general ("0")
			then
				cmd.append_string_general (" -r")
				cmd.append_string_general (a_rev.string)
			end

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
			end
		end

	add (a_changelist: SVN_CHANGELIST; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn add " + a_changelist.as_command_line_arguments + "%N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" add ")
			a_changelist.append_as_command_line_arguments_to (cmd)

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
			end
		end

	delete (a_changelist: SVN_CHANGELIST; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn delete ")
				across
					a_changelist as ic
				loop
					print ("%"")
					print (ic.item)
					print ("%" ")
				end
				print ("%N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" delete ")
			a_changelist.append_as_command_line_arguments_to (cmd)

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
			end
		end

	move (a_location, a_new_location: READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn move from [" + a_location.as_string_32 + {STRING_32} "] to [" + a_new_location.as_string_32 +"].%N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" move %"")
			cmd.append_string_general (a_location)
			cmd.append_string ("%" %"")
			cmd.append_string_general (a_new_location)
			cmd.append_string ("%" ")

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
			end
		end

	commit (a_changelist: SVN_CHANGELIST; a_log_message: detachable READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- <Precursor>
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd,msg: STRING_32
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "svn commit " + a_changelist.as_command_line_arguments + "%N")
			end

			create args.make (10)
			option_into_command_line_arguments (a_options, args)
			args.force ("commit")
			across
				a_changelist as ic
			loop
				args.force (ic.item)
			end
			if a_log_message /= Void then
				args.force ("--message")
				create msg.make_from_string_general (a_log_message)
				msg.prune_all ('%R')
				args.force (msg)
			end

			debug ("SVN_ENGINE")
				print ("Command: svn commit ...%N")
			end
			res := process_misc.output (svn_executable_path, args, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void or else res.exit_code /= 0 then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
				create Result.make_failure
					-- Compute pseudo command line for info.
				create cmd.make_from_string (svn_executable_path)
				cmd.append_string (option_to_command_line_flags (a_options))
				cmd.append_string (" commit ")
				a_changelist.append_as_command_line_arguments_to (cmd)
				if a_log_message /= Void then
					if a_log_message.has ('%N') then
						create msg.make_from_string_general (a_log_message)
						msg.replace_substring_all ("%N", "\n")
						cmd.append (" --message %"")
						cmd.append_string_general (msg)
						cmd.append ("%"")
					else
						cmd.append (" --message %"")
						cmd.append_string_general (a_log_message)
						cmd.append ("%"")
					end
				end
				Result.set_command (cmd)
				if res /= Void then
					Result.set_message ("Exit code: " + res.exit_code.out + "%N" + res.error_output)
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
				create Result.make_success
				Result.set_message (s)
			end
		end

feature -- Access: svn		

	repository_info (a_location: READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): detachable SVN_REPOSITORY_INFO
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "Fetch svn info from [" + a_location.as_string_32 + "] %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" --xml info ")
			cmd.append_string_general (a_location)

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
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

	diff (a_location: READABLE_STRING_GENERAL; a_start, a_end: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): detachable STRING
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "Fetch svn info from [" + a_location.as_string_32 + "] %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string (" diff ")
			cmd.append_string_general (a_location)

			if
				a_start /= Void and then
				not a_start.string.is_whitespace and then
				not a_start.string.is_case_insensitive_equal_general ("0")
			then
				cmd.append_string_general (" -r")
				cmd.append_string_general (a_start.string)
				if
					a_end /= Void and then
					not a_end.string.is_whitespace and then
					not a_end.string.is_case_insensitive_equal_general ("0")
				then
					cmd.append_character (':')
					cmd.append_string_general (a_end.string)
				end
			end

--			cmd.append_string (" --summarize ")

			debug ("SVN_ENGINE")
				print ("Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end

				Result := s
			end
		end

	path_content (a_location: READABLE_STRING_GENERAL; a_path: STRING; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): detachable STRING
		local
			s: STRING_32
		do
			create s.make_from_string_general (a_location)
			s.append_string_general (a_path)
			Result := content (s, a_rev, a_options)
		end

	content (a_location: READABLE_STRING_GENERAL; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): detachable STRING
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable STRING
			cmd: STRING_32
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "Fetch path content from [" + a_location.as_string_32 + "] %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			cmd.append_string_general (" cat ")
			if
				a_rev /= Void and then
				not a_rev.string.is_whitespace and then
				not a_rev.string.is_case_insensitive_equal_general ("0")
			then
				cmd.append_string_general (" -r")
				cmd.append_string_general (a_rev.string)
			end
			cmd.append_character (' ')
			cmd.append_string_general (a_location)

			debug ("SVN_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end

				Result := s
			end
		end

	logs (a_location: READABLE_STRING_GENERAL; is_verbose: BOOLEAN; a_start, a_end: detachable SVN_RANGE_INDEX; a_limit: INTEGER; a_options: detachable SVN_OPTIONS): detachable LIST [SVN_REVISION_INFO]
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "Fetch svn logs from [" + a_location.as_string_32 + "] (range [")
				if a_start /= Void then
					print (a_start.string)
				end
				if a_end /= Void then
					print ("..")
					print (a_end.string)
				end
				print ("] limit of " + a_limit.out + " entries) %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			if is_verbose then
				cmd.append_string_general (" -v ")
			end
			if
				a_start /= Void and then
				not a_start.string.is_whitespace and then
				not a_start.string.is_case_insensitive_equal_general ("0")
			then
				cmd.append_string_general (" -r")
				cmd.append_string_general (a_start.string)
				if
					a_end /= Void and then
					not a_end.string.is_whitespace and then
					not a_end.string.is_case_insensitive_equal_general ("0")
				then
					cmd.append_character (':')
					cmd.append_string_general (a_end.string)
				end
			end
			if a_limit > 0 then
				cmd.append_string_general (" --limit ")
				cmd.append_integer (a_limit)
			end
			cmd.append_string_general (" --xml log ")
			cmd.append_string_general (a_location)

			debug ("SVN_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, Void)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				debug ("SVN_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (res.output)
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

	option_to_command_line_flags (a_options: detachable SVN_OPTIONS): STRING_32
		do
			create Result.make_empty
			if a_options /= Void then
				if attached a_options.username as u then
					Result.append_string_general (" --username ")
					Result.append_string (u)
				end
				if attached a_options.password as p then
					Result.append_string_general (" --password ")
					Result.append_string (p)
				end
				if not a_options.auth_cached then
					Result.append_string_general (" --no-auth-cache " )
				end
				if
					attached a_options.parameters as l_params and then
					not l_params.is_whitespace
				then
					Result.append_string_general (" ")
					Result.append (l_params)
					Result.append_string_general (" ")
				end
			end
		end

	option_into_command_line_arguments (a_options: detachable SVN_OPTIONS; a_args: LIST [READABLE_STRING_GENERAL])
		do
			if a_options /= Void then
				if attached a_options.username as u then
					a_args.force ("--username")
					a_args.force (u)
				end
				if attached a_options.password as p then
					a_args.force ("--password")
					a_args.force (p)
				end
				if not a_options.auth_cached then
					a_args.force ("--no-auth-cache")
				end
				if
					attached a_options.parameters as l_params and then
					not l_params.is_whitespace
				then
					across
						l_params.split (' ') as ic
					loop
						if not ic.item.is_whitespace then
							a_args.force (ic.item)
						end
					end
				end
			end
		end

	svn_xml_manager: detachable SVN_XML_MANAGER

	impl_statuses (a_prefix_path: detachable STRING; a_path: PATH; is_verbose, is_recursive, is_remote: BOOLEAN; a_options: detachable SVN_OPTIONS): detachable ARRAYED_LIST [SVN_STATUS_INFO]
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
			info: SVN_STATUS_INFO
			lst, lst2: detachable ARRAYED_LIST [SVN_STATUS_INFO]
			l_svn_xml_manager: like svn_xml_manager
		do
			debug ("SVN_ENGINE")
				print ({STRING_32} "Fetch svn info from [" + a_path.name + "] (is_recursive=" + is_recursive.out + ") %N")
			end

			create cmd.make_from_string (svn_executable_path)
			cmd.append_string (option_to_command_line_flags (a_options))
			if not is_recursive then
				cmd.append_string_general (" -N ")
			end
			if is_verbose then
				cmd.append_string_general (" -v ")
			end
			if is_remote then
				cmd.append_string_general (" -u ")
			end
			cmd.append_string_general (" --xml status ")
			-- For unknown reason, it is better to pass the full `a_path.name`, rather than just "."
			-- even if the current directory is `a_path`
			-- cmd.append_string_general (".")
			cmd.append_string_general (a_path.name)

			debug ("SVN_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := process_misc.output_of_command (cmd, a_path)
			debug ("SVN_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("SVN_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
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
									print ({STRING_32} "Explore [" + info.absolute_path.name + "] %N")
								end
								lst2 := impl_statuses (info.display_path, info.absolute_path, is_verbose, is_recursive, is_remote, a_options)
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
	copyright: "Copyright (c) 2003-2021, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
