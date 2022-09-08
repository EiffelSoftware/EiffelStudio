note
	description: "Summary description for {DOTNET_HOST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_HOST

feature -- Access

	available_sdks: detachable ANY
		local
			fac: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			buffer: SPECIAL [NATURAL_8]
			s: STRING_8
		do
			create fac
			p := fac.process_launcher_with_command_line ("dotnet --list-sdks", Void)
			p.launch
			if p.launched then
				create s.make_empty
				from
				until
					p.has_exited
				loop
					from
						if buffer = Void then
							create buffer.make_filled (0, 1024)
						end
					until
						p.has_exited or p.has_output_stream_closed
					loop
						p.read_output_to_special (buffer)
						append_special_of_natural_8_to_string_8 (buffer, s)
					end
					p.wait_for_exit_with_timeout (50)
				end
			end
			p.close
		end

	available_runtimes: ARRAYED_LIST [TUPLE [version: READABLE_STRING_8; path: PATH]]
		local
			fac: BASE_PROCESS_FACTORY
			p: BASE_PROCESS
			buffer: SPECIAL [NATURAL_8]
			s, line, v, d: STRING_8
			i,j: INTEGER
		do
			create fac
			if {PLATFORM}.is_windows then
				p := fac.process_launcher_with_command_line ("dotnet --list-runtimes", Void)
			else
				p := fac.process_launcher_with_command_line ("/usr/bin/dotnet --list-runtimes", Void)
			end
			p.redirect_output_to_stream

			p.launch
			if p.launched then
				create s.make_empty
				from
				until
					p.has_exited
				loop
					from
						if buffer = Void then
							create buffer.make_filled (0, 1024)
						end
					until
						p.has_exited or p.has_output_stream_closed
					loop
						p.read_output_to_special (buffer)
						append_special_of_natural_8_to_string_8 (buffer, s)
					end
					p.wait_for_exit_with_timeout (50)
				end
			end
			p.close
			create Result.make (0)
			if s /= Void then
				across
					s.split ('%N') as ic
				loop
					line := ic.item
					i := line.index_of (' ', 1)
					if i > 0 then
						s := line.substring (1, i - 1)
						if s.same_string ("Microsoft.NETCore.App") then
							j := line.index_of (' ', i + 1)
							if j > 0 then
								v := line.substring (i + 1, j - 1)
								d := line.substring (j + 1, line.count)
								if d.count > 1 and d [1] = '[' and d [d.count] = ']' then
									d := d.substring (2, d.count - 1)
									Result.force ([v, create {PATH}.make_from_string (d)])
								end
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

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


end
