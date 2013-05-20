note
	description: "Logging filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_LOGGING_FILTER

inherit
	WSF_FILTER
		redefine
			default_create
		end

create
	default_create,
	make_with_output

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			output := io.output
		end

	make_with_output (a_output: like output)
			-- Create Current with `a_output' as `output'
		require
			a_output_opened: a_output.is_open_read
		do
			default_create
			output := a_output
		end

	output: FILE
			-- Output file
			--| Could be stdout, or a file...

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_date: DATE_TIME
			s: STRING
		do
			create s.make (64)
			s.append (req.remote_addr)
			s.append (" - - [")
			create l_date.make_now_utc
			s.append (l_date.formatted_out (Date_time_format))
			s.append (" GMT] %"")
			s.append (req.request_method)
			s.append_character (' ')
			s.append (req.request_uri)
			s.append_character (' ')
			s.append ({HTTP_CONSTANTS}.http_version_1_1)
			s.append_character ('%"')
			s.append_character (' ')
			s.append_integer (res.status_code)
			s.append_character (' ')
			s.append_natural_64 (res.transfered_content_length)
			s.append_character (' ')
			if attached req.http_referer as r then
				s.append_character ('%"')
				s.append_character ('%"')
				s.append (r)
				s.append_character (' ')
			end

			if attached req.http_user_agent as ua then
				s.append_character ('%"')
				s.append (ua)
				s.append_character ('%"')
			else
				s.append_character ('-')
			end

			output.put_string (s)
			output.put_new_line
			execute_next (req, res)
		end

feature -- Constants

	Date_time_format: STRING = "[0]dd/[0]mm/yyyy [0]hh:[0]mi:[0]ss"

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
