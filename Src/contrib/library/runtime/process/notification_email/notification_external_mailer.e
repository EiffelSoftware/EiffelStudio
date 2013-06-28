note
	description: "[
			Component responsible to send email using an external mailer
			i.e: an external tool such as sendmail or a script, ...
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_EXTERNAL_MAILER

inherit
	NOTIFICATION_MAILER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_exe: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Initialize `Current'.
		do
			set_parameters (a_exe, args)
		end

	executable_path: PATH

	arguments: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	stdin_mode_set: BOOLEAN
			-- Use `stdin' to pass email message, rather than using local file?

	stdin_termination_sequence: detachable READABLE_STRING_8
			-- Termination sequence for the stdin mode
			--| If any, this tells the executable all the data has been provided
			--| For instance, using sendmail, you should have "%N.%N%N"

feature -- Status

	is_available: BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_path (executable_path)
			Result := f.exists
		end

feature -- Change

	set_parameters (cmd: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Set parameters `executable_path' and associated `arguments'
		local
			l_args: like arguments
		do
			create executable_path.make_from_string (cmd)
			if args = Void then
				arguments := Void
			else
				create l_args.make (5)
				across
					args as c
				loop
					l_args.force (c.item)
				end
				arguments := l_args
			end
		end

	set_stdin_mode (b: BOOLEAN; v: like stdin_termination_sequence)
			-- Set the `stdin_mode_set' value
			-- and provide optional termination sequence when stdin mode is selected.
		do
			stdin_mode_set := b
			stdin_termination_sequence := v
		end

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
		local
			l_factory: PROCESS_FACTORY
			args: like arguments
			p: detachable PROCESS
			retried: INTEGER
		do
			if retried = 0 then
				create l_factory
				if stdin_mode_set then
					p := l_factory.process_launcher (executable_path.name, arguments, Void)
					p.set_hidden (True)
					p.set_separate_console (False)

					p.redirect_input_to_stream
					p.launch
					if p.launched then
						p.put_string (a_email.message)
						if attached stdin_termination_sequence as v then
							p.put_string (v)
						end
					end
				else
					if attached arguments as l_args then
						args := l_args.twin
					else
						if attached {RAW_FILE} new_temporary_file (generator) as f then
							f.create_read_write
							f.put_string (a_email.message)
							f.close
							create args.make (1)
							args.force (f.path.name)
						end
					end
					p := l_factory.process_launcher (executable_path.name, args, Void)
					p.set_hidden (True)
					p.set_separate_console (False)

					p.launch
				end
				if p.launched and not p.has_exited then
					p.wait_for_exit_with_timeout (1_000_000)
					if not p.has_exited then
						p.terminate
						if not p.has_exited then
							p.wait_for_exit_with_timeout (1_000_000)
						end
					end
				end
			elseif retried = 1 then
				if p /= Void and then p.launched and then not p.has_exited then
					p.terminate
					if not p.has_exited then
						p.wait_for_exit_with_timeout (1_000_000)
					end
				end
			end
		rescue
			retried := retried + 1
			retry
		end

feature {NONE} -- Implementation

	new_temporary_file (a_extension: detachable READABLE_STRING_8): RAW_FILE
			-- Create file with temporary name.
			-- With concurrent execution, noting ensures that {FILE_NAME}.make_temporary_name is unique
			-- So using `a_extension' may help
		local
			bn: STRING_32
			fn: PATH
			s: STRING_32
			f: detachable like new_temporary_file
			i: INTEGER
		do
				-- With concurrent execution, nothing ensures that {FILE_NAME}.make_temporary_name is unique
				-- So let's try to find
			from
				create bn.make_from_string_general ((create {FILE_NAME}.make_temporary_name).string)
				create s.make_empty
			until
				f /= Void or i > 1000
			loop
				create fn.make_from_string (bn)
				s.make_empty
				if i > 0 then
					s.append_character ('-')
					s.append_integer (i)
					fn := fn.appended (s)
				end
				if a_extension /= Void then
					fn := fn.appended_with_extension (a_extension)
				end
				create f.make_with_path (fn)
				if f.exists then
					i := i + 1
					f := Void
				end
			end
			if f = Void then
				Result := new_temporary_file (Void)
			else
				Result := f
				check not_temporary_file_exists: not Result.exists end
				check temporary_creatable: Result.is_creatable end
			end
		ensure
			not_result_exists: not Result.exists
			result_creatable: Result.is_creatable
		end

invariant

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
