note
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	GIT_ENGINE

inherit
	SHARED_PROCESS_MISC
		redefine
			default_create
		end

	SHARED_EXECUTION_ENVIRONMENT
		redefine
			default_create
		end

create
	default_create,
	make_with_executable_path

feature {NONE} -- Initialization

	default_create
		do
			make_with_executable_path ("git")
		end

	make_with_executable_path (v: READABLE_STRING_GENERAL)
		do
			set_git_executable_path (v)
		end

feature -- Access

	git_executable_location: PATH

	pause_between_operations: INTEGER_64
			-- Pause in nanoseconds between two consecutive git operations.
			--| for instance in `commit` to avoid issue with index.lock ...

feature -- Element change

	set_pause_between_operations (d: INTEGER_64)
		do
			pause_between_operations := d
		end

	set_git_executable_path (v: READABLE_STRING_GENERAL)
		do
			set_git_executable_location (create {PATH}.make_from_string (v))
		end

	set_git_executable_location (v: PATH)
		do
			git_executable_location := v
		end

feature -- Access tool info

	version: detachable IMMUTABLE_STRING_32
		local
			res: detachable PROCESS_COMMAND_RESULT
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string (" --version")
			res := output_of_command (cmd, Void)
			if res /= Void and then res.exit_code = 0 then
				create Result.make_from_string_general (res.output)
			end
		end

feature -- Execution

	statuses (a_root_location, a_path: PATH; is_recursive, with_all_untracked: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable SCM_STATUS_LIST
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" status")
			cmd.append_string (option_to_command_line_flags ("status", a_options))


			cmd.append_string_general (" --porcelain=v1 --no-renames ")
			if with_all_untracked then
				cmd.append_string_general (" --untracked-files=all ")
			end
			cmd.append_string_general (" .")

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := output_of_command (cmd, a_path)
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("GIT_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				Result := status_from_porcelain_output (a_root_location, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (s))
				debug ("GIT_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
--					print (s)
				end
			end
		end

	diff (a_path: PATH; a_options: detachable SCM_OPTIONS): detachable SCM_RESULT
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
			fut: FILE_UTILITIES
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" diff")
			cmd.append_string (option_to_command_line_flags ("diff", a_options))

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if fut.file_path_exists (a_path) then
				cmd.append_string_general (" %"")
				cmd.append_string_general (a_path.name)
				cmd.append_string_general ("%"")
				res := output_of_command (cmd, a_path.parent)
			else
				cmd.append_string_general (" . ")
				res := output_of_command (cmd, a_path)
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("GIT_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				create Result.make_with_command (cmd)
				Result.set_message ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (s))
				debug ("GIT_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
			end
		end

	revert (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
		local
			cmd: STRING_32
			reset_cmd: STRING_32
			l_has_reset: BOOLEAN
			fn: READABLE_STRING_32
			msg: READABLE_STRING_8
		do
			create reset_cmd.make_empty
			create reset_cmd.make_from_string (git_executable_location.name)
			reset_cmd.append_string (option_to_command_line_flags ("reset", a_options))
			reset_cmd.append_string_general (" reset ")

			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string (option_to_command_line_flags ("checkout", a_options))
			cmd.append_string_general (" checkout -- ")
			across
				a_changelist as ic
			loop
				fn := ic.item.location.name
				cmd.append_character (' ')
				if fn.has (' ') or fn.has ('%T') then
					cmd.append_character ('"')
					cmd.append_string_general (fn)
					cmd.append_character ('"')
				else
					cmd.append_string_general (fn)
				end
				if
					attached {SCM_STATUS_ADDED} ic.item
					or attached {SCM_STATUS_DELETED} ic.item
				then
					l_has_reset := True
					reset_cmd.append_character (' ')
					if fn.has (' ') or fn.has ('%T') then
						reset_cmd.append_character ('"')
						reset_cmd.append_string_general (fn)
						reset_cmd.append_character ('"')
					else
						reset_cmd.append_string_general (fn)
					end
				end
			end

			if l_has_reset then
				debug ("GIT_ENGINE")
					print ({STRING_32} "Command: [" + reset_cmd + "]%N")
				end
				if attached output_of_command (reset_cmd, a_changelist.root.location) as res_reset then
					if res_reset.exit_code = 0 then
						msg := res_reset.output
					else
						msg := res_reset.error_output
					end
					if pause_between_operations > 0 then
							-- Wait a bit to avoid index.lock already exists...				
						execution_environment.sleep (pause_between_operations)
					end
				else
					msg := "Error: can not launch git [" + last_process_error.out + "]"
				end
				debug ("GIT_ENGINE")
					print ("-> terminated %N")
				end
			end

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_changelist.root.location) as res_revert then
				if res_revert.exit_code = 0 then
					create Result.make_success (cmd)
					if msg = Void then
						msg := res_revert.output
					elseif attached res_revert.output as m then
						msg := msg + " %N" + m
					end
					Result.set_message (msg)
				else
					create Result.make_failure (cmd)
					if msg = Void then
						msg := res_revert.error_output
					elseif attached res_revert.error_output as m then
						msg := msg + " %N" + m
					end
				end
			else
				create Result.make_failure (cmd)
				msg := "Error: can not launch git [" + last_process_error.out + "]"
			end
			Result.set_message (msg)
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	add (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Add items from `a_changelist`, and return information about command execution.
		local
			cmd: STRING_32
			fn: READABLE_STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" add")
			cmd.append_string (option_to_command_line_flags ("add", a_options))
			across
				a_changelist as ic
			loop
				fn := ic.item.location.name
				cmd.append_character (' ')
				if fn.has (' ') or fn.has ('%T') then
					cmd.append_character ('"')
					cmd.append_string_general (fn)
					cmd.append_character ('"')
				else
					cmd.append_string_general (fn)
				end
			end

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_changelist.root.location) as res_add then
				if res_add.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res_add.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res_add.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	delete (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Add items from `a_changelist`, and return information about command execution.
		local
			cmd: STRING_32
			fn: READABLE_STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" rm")
			cmd.append_string (option_to_command_line_flags ("rm", a_options))
			across
				a_changelist as ic
			loop
				fn := ic.item.location.name
				cmd.append_character (' ')
				if fn.has (' ') or fn.has ('%T') then
					cmd.append_character ('"')
					cmd.append_string_general (fn)
					cmd.append_character ('"')
				else
					cmd.append_string_general (fn)
				end
			end

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_changelist.root.location) as res_delete then
				if res_delete.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res_delete.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res_delete.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	commit (a_changelist: SCM_CHANGELIST; a_log_message: READABLE_STRING_GENERAL; a_options: SCM_OPTIONS): SCM_RESULT
			-- Commit changes for locations `a_changelist`, and return information about command execution.
		local
			cmd, msg: STRING_32
			fn: READABLE_STRING_32
			tmpfile: PLAIN_TEXT_FILE
			tmp: PATH
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" add --verbose")
			cmd.append_string (option_to_command_line_flags ("add", a_options))
			across
				a_changelist as ic
			loop
				fn := ic.item.location.name
				cmd.append_character (' ')
				if fn.has (' ') or fn.has ('%T') then
					cmd.append_character ('"')
					cmd.append_string_general (fn)
					cmd.append_character ('"')
				else
					cmd.append_string_general (fn)
				end
			end

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached command_execution (cmd, a_changelist.root.location, False) as res_add then
					-- Todo
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end

			if pause_between_operations > 0 then
					-- Wait a bit to avoid index.lock already exists...				
				execution_environment.sleep (pause_between_operations)
			end

			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" commit")
			cmd.append_string (option_to_command_line_flags ("commit", a_options))

			create msg.make_from_string_general (a_log_message)
			msg.prune_all ('%R')
			if msg.has ('%N') then
				msg.left_adjust
				msg.right_adjust
			end
			if
				msg.occurrences ('%N') = 1 and
				not msg.has ('`')
			then
				across
					msg.split ('%N') as ic
				loop
					cmd.append_string_general (" --message ")
					cmd.append_character ('"')
					append_escaped_string_to (ic.item, cmd)
					cmd.append_character ('"')
				end
			elseif msg.has ('%N') or msg.has ('`') then
				tmp := {EXECUTION_ENVIRONMENT}.temporary_directory_path
				if tmp = Void then
					tmp := {EXECUTION_ENVIRONMENT}.current_working_path
				end
				create tmpfile.make_open_temporary_with_prefix (tmp.extended ("tmp-eif-git-log_").name)
				tmpfile.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_log_message))
				tmpfile.flush
				tmpfile.close
				cmd.append_string_general (" --file ")
				cmd.append_character ('"')
				cmd.append_string_general (tmpfile.path.name)
				cmd.append_character ('"')
			else
				cmd.append_string_general (" --message ")
				cmd.append_character ('"')
				append_escaped_string_to (a_log_message, cmd)
				cmd.append_character ('"')
			end

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_changelist.root.location) as res_commit then
				if res_commit.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res_commit.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res_commit.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			if tmpfile /= Void and then tmpfile.exists then
				tmpfile.delete
				tmpfile := Void
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	push (a_push_op: SCM_PUSH_OPERATION; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Push `a_push_op` and return execution result.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" push ")
			cmd.append_string (option_to_command_line_flags ("push", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_push_op.remote)
			cmd.append_string_general (" ")
			cmd.append_string_general (a_push_op.remote_branch)

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_push_op.root_location.location) as res_push then
				if res_push.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res_push.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res_push.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	push_command_line (a_push_op: SCM_PUSH_OPERATION; a_options: detachable SCM_OPTIONS): detachable STRING_32
			-- Command line for the `a_push_op` push operation.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" push ")
			cmd.append_string (option_to_command_line_flags ("push", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_push_op.remote)
			cmd.append_string_general (" ")
			cmd.append_string_general (a_push_op.remote_branch)

			Result := cmd
		end

	pull (a_pull_op: SCM_PULL_OPERATION; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Pull `a_pull_op` and return execution result.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" pull ")
			cmd.append_string (option_to_command_line_flags ("pull", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_pull_op.remote)
			cmd.append_string_general (" ")
			cmd.append_string_general (a_pull_op.remote_branch)

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_pull_op.root_location.location) as res_pull then
				if res_pull.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res_pull.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res_pull.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	pull_command_line (a_pull_op: SCM_PULL_OPERATION; a_options: detachable SCM_OPTIONS): detachable STRING_32
			-- Command line for the `a_pull_op` pull operation.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" pull ")
			cmd.append_string (option_to_command_line_flags ("pull", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_pull_op.remote)
			cmd.append_string_general (" ")
			cmd.append_string_general (a_pull_op.remote_branch)

			Result := cmd
		end

	rebase (a_op: SCM_REBASE_OPERATION; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Rebase `a_op` and return execution result.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" rebase ")
			cmd.append_string (option_to_command_line_flags ("rebase", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_op.branch)

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			if attached output_of_command (cmd, a_op.root_location.location) as res then
				if res.exit_code = 0 then
					create Result.make_success (cmd)
					Result.set_message (res.output)
				else
					create Result.make_failure (cmd)
					Result.set_message (res.error_output)
				end
			else
				create Result.make_failure (cmd)
				Result.set_message ("Error: can not launch git [" + last_process_error.out + "]")
			end
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
		end

	rebase_command_line (a_op: SCM_REBASE_OPERATION; a_options: detachable SCM_OPTIONS): detachable STRING_32
			-- Command line for the `a_op` rebase operation.
		local
			cmd: STRING_32
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" rebase ")
			cmd.append_string (option_to_command_line_flags ("rebase", a_options))
			cmd.append_string_general (" ")
			cmd.append_string_general (a_op.branch)

			Result := cmd
		end

feature -- Git specific

	remotes (a_root_location: PATH; a_options: detachable SCM_OPTIONS): detachable STRING_TABLE [GIT_REMOTE]
			-- Remote indexed by name.
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
			l_name: READABLE_STRING_8
			i,j,k,n: INTEGER
			l_url,l_type: STRING_8
			r: GIT_REMOTE
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" remote -v")
			cmd.append_string (option_to_command_line_flags ("remote", a_options))

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := output_of_command (cmd, a_root_location)
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("GIT_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				create Result.make (s.occurrences ('%N') + 1)
				from
					i := 1
					n := s.count
				until
					i > n
				loop
					j := s.index_of ('%N', i)
					if j < i then
						j := s.count
					end
						-- Next space or tab
					from k := i until k > j or else s [k].is_space loop
						k := k + 1
					end
					if k < j then
						l_name := s.substring (i, k - 1)
						r := Result [l_name]
						if r = Void then
							create r.make (l_name)
						end
						i := k + 1
							-- Next space or tab
						from k := k + 1 until k > j or else s [k].is_space loop
							k := k + 1
						end
						if k < j then
							l_url := s.substring (i, k - 1).to_string_8 -- READABLE_STRING_8 to STRING_8
							l_url.left_adjust
							i := k + 1
							if s[i] = '(' then
								l_type := s.substring (i + 1, j - 2).to_string_8 -- READABLE_STRING_8 to STRING_8
							else
								l_type := s.substring (i, j - 1).to_string_8 -- READABLE_STRING_8 to STRING_8
							end
							l_type.left_adjust
							l_type.right_adjust
							if l_type.is_case_insensitive_equal_general ("push") then
								r.set_push_location (l_url)
							elseif l_type.is_case_insensitive_equal_general ("fetch") then
								r.set_fetch_location (l_url)
							else
								check push_or_fetch: False end
							end
							Result [r.name] := r
						end
					end
					i := j + 1
				end

				debug ("GIT_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
			end
		end

	branches (a_root_location: PATH; a_show_all: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable STRING_TABLE [GIT_BRANCH]
			-- Branches for `a_root_location'.
			-- if `a_show_all` is True, include remote branches.
		local
			res: detachable PROCESS_COMMAND_RESULT
			s: detachable READABLE_STRING_8
			cmd: STRING_32
			i,j,k,m,n: INTEGER
			l_name: READABLE_STRING_8
			l_sha1_id: READABLE_STRING_8
			l_is_active: BOOLEAN
			br: GIT_BRANCH
		do
			create cmd.make_from_string (git_executable_location.name)
			cmd.append_string_general (" branch -vv") -- "-vv": is to be verbose, and display the default upstream repository.
			if a_show_all then
				cmd.append_string_general (" -a")
			end
			cmd.append_string (option_to_command_line_flags ("branch", a_options))

			debug ("GIT_ENGINE")
				print ({STRING_32} "Command: [" + cmd + "]%N")
			end
			res := output_of_command (cmd, a_root_location)
			debug ("GIT_ENGINE")
				print ("-> terminated %N")
			end
			if res = Void then
				debug ("GIT_ENGINE")
					print ("-> terminated : None .%N")
				end
			else
				s := res.output
				create Result.make (s.occurrences ('%N') + 1)
				from
					i := 1
					n := s.count
				until
					i > n
				loop
						-- ex: "* develop 1d8e2f7 [origin/develop: ahead 1] comment ..."
					j := s.index_of ('%N', i)
					if j < i then
						j := s.count
					end
					l_is_active := s [i] = '*'
						-- Next non space
					from k := i + 1 until k > j or else not s [k].is_space loop
						k := k + 1
					end
					i := k

						-- Next space or tab
					from k := i + 1 until k > j or else s [k].is_space loop
						k := k + 1
					end
					if k > j then
						k := j -- end of line
					else
						k := k - 1
					end
					l_name := s.substring (i, k)
					br := Result [l_name]
					if br = Void then
						create br.make (l_name)
					end
					br.set_is_active (l_is_active)

						-- Next space or tab
					i := k + 1
					from k := i + 1 until k > j or else s [k].is_space loop
						k := k + 1
					end
					if k > j then
						k := j -- end of line
					else
						k := k - 1
					end
					l_sha1_id := s.substring (i, k)

						-- Next space or tab
						-- detect: [origin/develop: ahead 1]
					if i < j then
						i := k + 2
						if s [i] = '[' then
							k := s.index_of (']', i + 1)
							if k > 0 then
								m := s.index_of (':', i + 1)
								if m > 0 then
									-- Ignore after ":"
									br.set_upstream_remote (s.substring (i + 1, m - 1))
								else
									br.set_upstream_remote (s.substring (i + 1, k - 1))
								end
							end
						end
					end

					Result [br.name] := br
					i := j + 1
				end

				debug ("GIT_ENGINE")
					print ("-> terminated : count=" + s.count.out + " .%N")
					print (s)
				end
			end
		end

feature {NONE} -- Implementation

	append_escaped_string_to (a_string: READABLE_STRING_GENERAL; a_output: STRING_32)
		local
			i,n: INTEGER
			ch: CHARACTER_32
		do
			if a_string.has ('%"') then
				from
					i := 1
					n := a_string.count
				until
					i > n
				loop
					ch := a_string [i]
					inspect ch
					when '%"' then
						a_output.extend ('\')
						a_output.extend (ch)
					when '`' then
						a_output.extend ('\')
						a_output.extend (ch)
					when '%R' then
						-- Ignore
					when '%N' then
						a_output.extend ('\')
						a_output.extend ('n')
					when '\' then
						a_output.extend (ch)
						if i < n then
							ch := a_string [i]
							a_output.extend (ch)
							i := i + 1
						end
					else
						a_output.extend (ch)
					end
					i := i + 1
				end
			else
				a_output.append_string_general (a_string)
			end
		end

	status_from_porcelain_output (a_path: PATH; s: READABLE_STRING_32): SCM_STATUS_LIST
		local
			i,j,n: INTEGER
			l_line: STRING_32
			k: READABLE_STRING_GENERAL
		do
			create Result.make (0)
			from
				n := s.count
				i := 1
			until
				i > n
			loop
				j := s.index_of ('%N', i)
				if j > 0 then
					l_line := s.substring (i, j - 1)
					i := j + 1
				else
					l_line := s.substring (i, n)
					i := n + 1
				end
				l_line.left_adjust
				j := l_line.index_of (' ', 1)
				k := l_line.head (j - 1)
				l_line.remove_head (j)
				l_line.left_adjust
				if k.has ('M') then
					Result.force (create {SCM_STATUS_MODIFIED}.make (a_path.extended (l_line)))
				elseif k.has ('A') then
					Result.force (create {SCM_STATUS_ADDED}.make (a_path.extended (l_line)))
				elseif k.has ('D') then
					Result.force (create {SCM_STATUS_DELETED}.make (a_path.extended (l_line)))
				elseif k.has ('C') then
					Result.force (create {SCM_STATUS_CONFLICTED}.make (a_path.extended (l_line)))
				elseif k.has ('?') then
					Result.force (create {SCM_STATUS_UNVERSIONED}.make (a_path.extended (l_line)))
				end
			end
		end

	option_to_command_line_flags (a_command: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): STRING_32
		local
			p: READABLE_STRING_GENERAL
		do
			create Result.make_empty
			if a_options /= Void then
				if a_options.is_simulation and a_command.is_case_insensitive_equal ("commit") then
					Result.append_string_general (" --dry-run ")
				end
				if attached a_options.parameters as l_params then
					across
						l_params as ic
					loop
						p := ic.item
						if not p.is_whitespace then
							Result.append_string_general (" ")
							Result.append (p)
							Result.append_string_general (" ")
						end
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
