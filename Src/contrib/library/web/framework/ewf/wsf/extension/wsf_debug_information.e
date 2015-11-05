note
	description: "[
			Object used to output information from WSF_REQUEST objects
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEBUG_INFORMATION

inherit
	ANY

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

	WSF_REQUEST_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
		do
			is_verbose := True
		end

feature -- Settings

	is_verbose: BOOLEAN
			-- Has verbose output (default: True)?

	unicode_output_enabled: BOOLEAN
			-- Display names and values as unicode.

feature -- Settings change

	set_is_verbose (b: BOOLEAN)
			-- Set `is_verbose' to `b'.
		do
			is_verbose := b
		end

	set_unicode_output_enabled (b: BOOLEAN)
			-- if `b' then enable unicode output, otherwise disable.
		do
			unicode_output_enabled := b
		end

feature -- Execution

	append_connector_informations_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			a_output.append ("Eiffel Web Server Gateway Interface (WGI):")
			a_output.append (" implementation=%"")
			a_output.append (req.wgi_implementation)
			a_output.append ("%"")
			a_output.append (" version=")
			a_output.append (req.wgi_version)
			a_output.append (" connector=%"")
			if attached req.wgi_connector as conn then
				append_connector_name_to (conn, a_output)
				a_output.append ("%" connector-version=")
				append_connector_version_to (conn, a_output)
			else
				a_output.append ("none")
			end
			a_output.append (eol)
		end

	append_connector_name_to (conn: separate WGI_CONNECTOR; a_output: STRING)
		local
			s: STRING
		do
			create s.make_from_separate (conn.name)
			a_output.append (s)
		end

	append_connector_version_to (conn: separate WGI_CONNECTOR; a_output: STRING)
		local
			s: STRING
		do
			create s.make_from_separate (conn.version)
			a_output.append (s)
		end

	append_cgi_variables_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			a_output.append ("CGI variables:")
			a_output.append (eol)
			a_output.append (req.cgi_variables.debug_output)
			a_output.append (eol)
			a_output.append (eol)
		end

	append_meta_variables_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			append_iterable_to ("Meta variables", req.meta_variables, a_output)
			a_output.append (eol)
		end

	append_path_parameters_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			append_iterable_to ("Path parameters", req.path_parameters, a_output)
			a_output.append (eol)
		end

	append_query_parameters_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			append_iterable_to ("Query parameters", req.query_parameters, a_output)
			a_output.append (eol)
		end

	append_form_parameters_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			req.set_raw_input_data_recorded (True)
			append_iterable_to ("Form parameters", req.form_parameters, a_output)
			a_output.append (eol)
		end

	append_execution_variables_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			append_iterable_any_to ("Execution variables", req.execution_variables, a_output)
			a_output.append (eol)
		end

	append_environment_variables_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			a_output.append ("Environment vars:")
			a_output.append (eol)
			across
				(create {EXECUTION_ENVIRONMENT}).starting_environment as ic
			loop
				a_output.append_character (' ')
				a_output.append_character ('-')
				a_output.append_string (html_encoder.general_encoded_string (ic.key))
				a_output.append_character ('=')
				a_output.append_string (html_encoder.general_encoded_string (ic.item))
				a_output.append (eol)
			end
			a_output.append (eol)
			a_output.append (eol)
		end

	append_all_variables_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			req.set_raw_input_data_recorded (True)

			append_path_parameters_to (req, res, a_output)
			append_query_parameters_to (req, res, a_output)
			append_form_parameters_to (req, res, a_output)
			append_meta_variables_to (req, res, a_output)
			if is_verbose then
				append_execution_variables_to (req, res, a_output)
--				append_environment_variables_to (req, res, a_output)
			end
		end

	append_content_information_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		local
			v: STRING_8
		do
			if attached req.content_type as l_type then
				a_output.append ("Content: type=" + l_type.debug_output)
				a_output.append (" length=")
				a_output.append_natural_64 (req.content_length_value)
				a_output.append (eol)
				if is_verbose then
					create v.make (req.content_length_value.to_integer_32)
					req.set_raw_input_data_recorded (True)
					req.read_input_data_into (v)
					across
						v.split ('%N') as v_cursor
					loop
						a_output.append ("     |")
						a_output.append (v_cursor.item)
						a_output.append (eol)
					end
					a_output.append (eol)
				end
			end
		end

	append_information_to (req: WSF_REQUEST; res: WSF_RESPONSE; a_output: STRING)
		do
			append_connector_informations_to (req, res, a_output)
			a_output.append (eol)

			append_all_variables_to (req, res, a_output)
			a_output.append (eol)

			append_content_information_to (req, res, a_output)
			a_output.append (eol)
		end

feature {NONE} -- Implementation

	iterable_count (a_iterable: ITERABLE [detachable ANY]): INTEGER
		do
			if attached {FINITE [detachable ANY]} a_iterable as a_finite then
				Result := a_finite.count
			else
				across a_iterable as ic loop
					Result := Result + 1
				end
			end
		end

	append_iterable_any_to (a_title: READABLE_STRING_8; it: detachable TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]; s: STRING_8)
		local
			n: INTEGER
			v: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			if is_verbose then
				s.append (a_title)
				s.append_character (':')
			end
			if it /= Void then
				n := iterable_count (it)
				if n = 0 then
					if is_verbose then
						s.append (" empty")
						s.append (eol)
					end
				else
					s.append (eol)
					across
						it as c
					loop
						s.append ("  - ")
						append_unicode (c.key, s)
						s.append_character (' ')
						if attached c.item as l_item then
							s.append_character ('{')
							s.append (l_item.generating_type)
							s.append_character ('}')

							s.append_character (' ')
							s.append_character ('=')
							s.append_character (' ')
							if attached {READABLE_STRING_GENERAL} c.item as l_string then
								v := "%"" + utf.escaped_utf_32_string_to_utf_8_string_8 (l_string) + "%""
							elseif attached {DEBUG_OUTPUT} c.item as l_dbg_output then
								v := utf.escaped_utf_32_string_to_utf_8_string_8 (l_dbg_output.debug_output)
							else
								v := "..."
							end
							if v.has ('%N') then
								s.append (eol)
								across
									v.split ('%N') as v_cursor
								loop
									s.append ("     |")
									s.append (v_cursor.item)
									s.append (eol)
								end
							else
								s.append (v)
								s.append (eol)
							end
						else
							s.append_character ('=')
							s.append ("Void")
							s.append (eol)
						end
					end
				end
			else
				if is_verbose then
					s.append (" none")
					s.append (eol)
				end
			end
		end

	append_iterable_to (a_title: READABLE_STRING_8; it: detachable ITERABLE [WSF_VALUE]; a_output: STRING_8)
		local
			n: INTEGER
			t: READABLE_STRING_8
			v: READABLE_STRING_8
			s: READABLE_STRING_GENERAL
			utf: UTF_CONVERTER
		do
			if is_verbose then
				a_output.append (a_title)
				a_output.append_character (':')
			end
			if it /= Void then
				n := iterable_count (it)
				if n = 0 then
					if is_verbose then
						a_output.append (" empty")
						a_output.append (eol)
					end
				else
					a_output.append (eol)
					across
						it as c
					loop
						a_output.append ("  - ")
						if unicode_output_enabled then
							append_unicode (c.item.name, a_output)
						else
							a_output.append (c.item.url_encoded_name)
						end
						t := c.item.generating_type
						if t.same_string ("WSF_STRING") then
						else
							a_output.append_character (' ')
							a_output.append_character ('{')
							a_output.append (t)
							a_output.append_character ('}')
						end
						a_output.append_character ('=')
						if attached {WSF_STRING} c.item as l_str then
							if unicode_output_enabled then
								s := l_str.value
							else
								s := l_str.url_encoded_value
							end
						else
							s := c.item.string_representation
						end
						v := utf.utf_32_string_to_utf_8_string_8 (s)
						if v.has ('%N') then
							a_output.append (eol)
							across
								v.split ('%N') as v_cursor
							loop
								a_output.append ("     |")
								a_output.append (v_cursor.item)
								a_output.append (eol)
							end
						else
							a_output.append (v)
							a_output.append (eol)
						end
					end
				end
			else
				if is_verbose then
					a_output.append (" none")
					a_output.append (eol)
				end
			end
		end

	append_iterable_string_to (a_title: READABLE_STRING_8; it: detachable TABLE_ITERABLE [READABLE_STRING_8, READABLE_STRING_GENERAL]; a_output: STRING_8)
		local
			n: INTEGER
			v: READABLE_STRING_8
		do
			if is_verbose then
				a_output.append (a_title)
				a_output.append_character (':')
			end
			if it /= Void then
				n := iterable_count (it)
				if n = 0 then
					if is_verbose then
						a_output.append (" empty")
						a_output.append (eol)
					end
				else
					a_output.append (eol)
					across
						it as c
					loop
						a_output.append ("  - ")
						append_unicode (c.key, a_output)
						a_output.append_character ('=')
						v := c.item
						if v.has ('%N') then
							a_output.append (eol)
							across
								v.split ('%N') as v_cursor
							loop
								a_output.append ("     |")
								a_output.append (v_cursor.item)
								a_output.append (eol)
							end
						else
							a_output.append (v)
							a_output.append (eol)
						end
					end
				end
			else
				if is_verbose then
					a_output.append (" none")
					a_output.append (eol)
				end
			end
		end

	append_unicode (s: READABLE_STRING_GENERAL; a_output: STRING)
		local
			utf: UTF_CONVERTER
		do
			a_output.append (utf.utf_32_string_to_utf_8_string_8 (s))
		end

feature -- Constants

	eol: STRING = "%N"

invariant

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
