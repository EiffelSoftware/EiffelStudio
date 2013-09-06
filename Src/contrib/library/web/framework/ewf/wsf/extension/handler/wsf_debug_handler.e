note
	description: "Summary description for {WSF_DEBUG_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEBUG_HANDLER

inherit
	WSF_STARTS_WITH_HANDLER
		rename
			execute as execute_starts_with
		end

	WSF_SELF_DOCUMENTED_HANDLER

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		export
			{NONE} all
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make
		do
		end

	make_hidden
		do
			make
			is_hidden := True
		end

	is_hidden: BOOLEAN
			-- Current mapped handler should be hidden from self documentation		

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- <Precursor>
		do
			create Result.make (m)
			Result.set_is_hidden (is_hidden)
			Result.add_description ("Debug handler (mainly to return request information)")
		end

feature -- Access	

	execute_starts_with (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING_8
			p: WSF_PAGE_RESPONSE
			v: STRING_8
		do
			if (create {RT_DEBUGGER}).rt_workbench_wait_for_debugger (1050) then
			end
			create s.make (2048)
			s.append ("**DEBUG**%N")
			req.set_raw_input_data_recorded (True)

			append_iterable_to ("Meta variables:", req.meta_variables, s)
			s.append_character ('%N')

			append_iterable_to ("Path parameters", req.path_parameters, s)
			s.append_character ('%N')

			append_iterable_to ("Query parameters", req.query_parameters, s)
			s.append_character ('%N')

			append_iterable_to ("Form parameters", req.form_parameters, s)
			s.append_character ('%N')

			if attached req.content_type as l_type then
				s.append ("Content: type=" + l_type.debug_output)
				s.append (" length=")
				s.append_natural_64 (req.content_length_value)
				s.append_character ('%N')
				create v.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (v)
				across
					v.split ('%N') as v_cursor
				loop
					s.append ("     |")
					s.append (v_cursor.item)
					s.append_character ('%N')
				end
			end

			create p.make_with_body (s)
			p.header.put_content_type_text_plain
			res.send (p)

		end

feature {NONE} -- Implementation

	append_iterable_to (a_title: READABLE_STRING_8; it: detachable ITERABLE [WSF_VALUE]; s: STRING_8)
		local
			n: INTEGER
			t: READABLE_STRING_8
			v: READABLE_STRING_8
		do
			s.append (a_title)
			s.append_character (':')
			if it /= Void then
				across it as c loop
					n := n + 1
				end
				if n = 0 then
					s.append (" empty")
					s.append_character ('%N')
				else
					s.append_character ('%N')
					across
						it as c
					loop
						s.append ("  - ")
						s.append (c.item.url_encoded_name)
						t := c.item.generating_type
						if t.same_string ("WSF_STRING") then
						else
							s.append_character (' ')
							s.append_character ('{')
							s.append (t)
							s.append_character ('}')
						end
						s.append_character ('=')
						v := c.item.string_representation.as_string_8
						if v.has ('%N') then
							s.append_character ('%N')
							across
								v.split ('%N') as v_cursor
							loop
								s.append ("     |")
								s.append (v_cursor.item)
								s.append_character ('%N')
							end
						else
							s.append (v)
							s.append_character ('%N')
						end
					end
				end
			else
				s.append (" none")
				s.append_character ('%N')
			end
		end

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
