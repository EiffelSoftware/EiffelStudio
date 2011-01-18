note
	description: "Summary description for {CTR_EXTERNAL_TOOLS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_EXTERNAL_TOOLS

inherit
	EXECUTION_ENVIRONMENT

	PLATFORM

feature -- Url

	open_url (a_url: STRING)
		local
			s: STRING
		do
			s := a_url
			if s /= Void then
				if is_windows then
					if attached get ("COMSPEC") as l_comspec then
						s := l_comspec + " /C start %"%" %"" + s + "%""
					end
				end
				launch (s)
			end
		end

feature -- Diff viewer


feature -- 2 files diff

	open_2_text_diff (t1, t2: STRING; s1, s2: STRING; a_cmd: detachable TUPLE [template: STRING; param_left, param_right: STRING])
		local
			l_tmp_f1: FILE
			l_tmp_f2: FILE
		do
			l_tmp_f1 := temporary_file_from_content (t1, s1)
			l_tmp_f2 := temporary_file_from_content (t2, s2)
			open_2_files_diff (l_tmp_f1, l_tmp_f2, a_cmd)
		end

	open_2_files_diff (f1, f2: FILE; a_cmd: detachable TUPLE [template: STRING; param_left, param_right: STRING])
		local
			s: STRING
			wt: WORKER_THREAD
		do
			if a_cmd /= Void then
				create s.make_from_string (a_cmd.template)
				s.replace_substring_all (a_cmd.param_left, f1.name)
				s.replace_substring_all (a_cmd.param_right, f2.name)

				create wt.make (agent (ia_cmd: STRING; ia_f1, ia_f2: FILE)
					local
						pf: PROCESS_FACTORY
						p: PROCESS
					do
						create pf
						p := pf.process_launcher_with_command_line (ia_cmd, Void)
						p.set_on_exit_handler (agent (ia2_f1, ia2_f2: FILE)
								do
									sleep (50 * 1_000_000_000_000)
									ia2_f1.delete
									ia2_f2.delete
								end(ia_f1, ia_f2)
							)
						p.launch
					end(s, f1, f2)
				)
				wt.launch
			end

		end

feature -- files

	precise_file_name (a_filename: STRING): STRING
		local
			fn: FILE_NAME
			f: RAW_FILE
		do
			create fn.make_from_string (current_working_directory)
			fn.extend (a_filename)
			Result := fn.string
			create f.make (Result)
			if not f.exists then
				Result := a_filename.string
			end
		end

	temporary_file_from_content (a_name: STRING; s: STRING): FILE
		local
			fn: FILE_NAME

		do
			if attached get ("TEMP") as l_temp then
				create fn.make_from_string (l_temp)
			else
				create fn.make_from_string (current_working_directory)
			end
			fn.set_file_name (".ctr.tmp-" + a_name)
			create {PLAIN_TEXT_FILE} Result.make (fn.string)
			if not Result.exists or else Result.is_writable then
				Result.open_write
				Result.put_string (s)
				Result.close
			end
		end

end
