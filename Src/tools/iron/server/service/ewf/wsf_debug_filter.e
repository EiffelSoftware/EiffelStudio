note
	description: "Summary description for {WSF_DEBUG_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEBUG_FILTER

inherit
	WSF_FILTER

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_output: FILE)
		do
			output := a_output
		end

	output: detachable FILE

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			s: STRING_8
		do
			create s.make (2048)
			if attached req.content_type as l_type then
				s.append ("[length=")
				s.append_natural_64 (req.content_length_value)
				s.append_character (']')
				s.append_character (' ')
				s.append (l_type.debug_output)
				s.append_character ('%N')
			end

			append_iterable_to ("Path parameters", req.path_parameters, s)
			append_iterable_to ("Query parameters", req.query_parameters, s)
			append_iterable_to ("Form parameters", req.form_parameters, s)

			if not s.is_empty then
				s.prepend ("**DEBUG**%N")
				if attached output as o then
					o.put_string (s)
				else
					res.put_error (s)
				end
			end
			execute_next (req, res)
		end

	append_iterable_to (a_title: READABLE_STRING_8; it: detachable ITERABLE [WSF_VALUE]; s: STRING_8)
		local
			n: INTEGER
		do
			if it /= Void then
				across it as c loop
					n := n + 1
				end
				if n > 0 then
					s.append (a_title)
					s.append_character (':')
					s.append_character ('%N')
					across
						it as c
					loop
						s.append ("  - ")
						s.append (c.item.url_encoded_name)
						s.append_character (' ')
						s.append_character ('{')
						s.append (c.item.generating_type)
						s.append_character ('}')
						s.append_character ('=')
						s.append (c.item.debug_output.as_string_8)
						s.append_character ('%N')
					end
				end
			end
		end

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
