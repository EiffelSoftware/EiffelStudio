note
	description: "Summary description for {ESA_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HANDLER

inherit

	ESA_SHARED_LOGGER

feature -- User

	current_user_name (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current user name or Void in case of Guest users.
		note
			EIS: "name=Authentication Filter", "src=https://svn.eiffel.com/eiffelstudio/trunk/Src/web/support/esa_api/src/service/filter/esa_authentication_filter.e", "protocol=URI"
			EIS: "src=eiffel:?class=ESA_AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {ESA_USER} current_user (req) as l_user then
				Result := l_user.name
			end
		end

	current_user (req: WSF_REQUEST): detachable ESA_USER
			-- Current user or Void in case of Guest user.
		note
			EIS: "name=Authentication Filter", "src=https://svn.eiffel.com/eiffelstudio/trunk/Src/web/support/esa_api/src/service/filter/esa_authentication_filter.e", "protocol=URI"
			EIS: "eiffel:?class=ESA_AUTHENTICATION_FILTER&feature=execute"
		do
			if attached {ESA_USER} req.execution_variable ("user") as l_user then
				Result := l_user
			end
		end

feature -- Media Type

	current_media_type (req: WSF_REQUEST): detachable READABLE_STRING_32
			-- Current media type of Void if it's not acceptable.
		do
			if attached {STRING} req.execution_variable ("media_type") as l_type then
				Result := l_type
			end
		end

	absolute_host (req: WSF_REQUEST; a_path:STRING): STRING
		do
			Result := req.absolute_script_url (a_path)
			if Result.last_index_of ('/', Result.count) = Result.count then
				Result.remove_tail (1)
			end
			log.write_debug (generator + ".absolute_host " + Result )
		end

feature -- Debug

	debug_request_header (req: WSF_REQUEST)
		local
			s: STRING
		do
			log.write_debug (generator + ".execute")
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
					log.write_debug (generator + ".execute" + s)
				end
			end

feature {NONE} -- Implementations

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


end
