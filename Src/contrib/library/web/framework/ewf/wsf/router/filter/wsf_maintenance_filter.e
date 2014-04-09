note
	description: "Maintenance filter."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_MAINTENANCE_FILTER

inherit
	WSF_FILTER
		redefine
			default_create
		end

create
	default_create,
	make_with_name

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			make_with_name (".maintenance")
		end

	make_with_name (fn: like maintenance_fn)
		do
			maintenance_fn := fn
		end

	maintenance_fn: READABLE_STRING_GENERAL

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			s: STRING
			h: HTTP_HEADER
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name (maintenance_fn)
			if f.exists then
				create s.make (64)
				if f.is_access_readable then
					f.open_read
					from
					until
						f.exhausted
					loop
						f.read_line
						s.append (f.last_string)
						s.append_character ('%N')
					end
					f.close
				end
				if s.is_empty then
					s.append ("In maintenance, please come back later ...")
				end
				create h.make_with_count (1)
				h.put_content_length (s.count)
				h.put_content_type_text_plain
				res.set_status_code ({HTTP_STATUS_CODE}.service_unavailable)
				res.put_header_lines (h)
				res.put_string (s)
			else
				execute_next (req, res)
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
