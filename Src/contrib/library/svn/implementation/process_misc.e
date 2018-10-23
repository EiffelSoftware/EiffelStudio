note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_MISC

feature

	last_error: INTEGER

	output (a_file_name: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL]; a_working_directory: detachable READABLE_STRING_GENERAL): detachable PROCESS_COMMAND_RESULT
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
			err,res: STRING
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			if not retried then
				last_error := 0
				create res.make (0)
				create err.make (0)
				create pf
				p := pf.process_launcher (a_file_name, args, a_working_directory)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_output_to_stream
				p.redirect_error_to_stream

				create res_spec.make_filled (0, 1024)
				create err_spec.make_filled (0, 1024)

				p.launch
				if p.launched then
					from
					until
						p.has_output_stream_closed or p.has_output_stream_error
					loop
						p.read_output_to_special (res_spec)
						append_special_of_natural_8_to_string_8 (res_spec, res)
					end

					from
					until
						p.has_error_stream_closed or p.has_error_stream_error
					loop
						p.read_error_to_special (err_spec)
						append_special_of_natural_8_to_string_8 (err_spec, err)
					end

					p.wait_for_exit
					create Result.make (p.exit_code, res, err)
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	output_of_command (a_cmd: READABLE_STRING_GENERAL; a_dir: detachable PATH): detachable PROCESS_COMMAND_RESULT
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
			dn: detachable READABLE_STRING_32
			err,res: STRING
			err_spec, res_spec: SPECIAL [NATURAL_8]
		do
			if not retried then
				last_error := 0
				create res.make (0)
				create err.make (0)
				create pf
				if a_dir /= Void then
					dn := a_dir.name
				end
				p := pf.process_launcher_with_command_line (a_cmd, dn)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_output_to_stream
				p.redirect_error_to_stream

				create res_spec.make_filled (0, 1024)
				create err_spec.make_filled (0, 1024)

				p.launch
				if p.launched then
					from
					until
						p.has_output_stream_closed or p.has_output_stream_error
					loop
						p.read_output_to_special (res_spec)
						append_special_of_natural_8_to_string_8 (res_spec, res)
					end

					from
					until
						p.has_error_stream_closed or p.has_error_stream_error
					loop
						p.read_error_to_special (err_spec)
						append_special_of_natural_8_to_string_8 (err_spec, err)
					end

					p.wait_for_exit
					create Result.make (p.exit_code, res, err)
				else
					last_error := 1
				end
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	append_special_of_natural_8_to_string_8 (spec: SPECIAL [NATURAL_8]; a_output: STRING)
		local
			i,n: INTEGER
		do
			from
				i := spec.lower
				n := spec.upper
			until
				i > n
			loop
				a_output.append_code (spec[i])
				i := i + 1
			end
		end

	launch_no_wait_command (a_cmd: READABLE_STRING_GENERAL; a_dir: PATH; is_hidden: BOOLEAN)
		local
			pf: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			retried: BOOLEAN
		do
			if not retried then
				last_error := 0
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_dir.name)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.launch
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "Copyright (c) 2003-2018, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
