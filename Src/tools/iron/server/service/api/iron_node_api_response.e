note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_API_RESPONSE

inherit
	IRON_NODE_CONSTANTS

	WSF_RESPONSE_MESSAGE

create
	make, make_with_body, make_not_permitted, make_not_found

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_iron: like iron)
		do
			iron := a_iron
			request := req
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
		end

	make_with_body (b: READABLE_STRING_8; req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			set_body (b)
		end

	make_not_permitted (req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			status_code := {HTTP_STATUS_CODE}.unauthorized
			set_body ("Operation not permitted.")
		end

	make_not_found (req: WSF_REQUEST; a_iron: like iron)
		do
			make (req, a_iron)
			status_code := {HTTP_STATUS_CODE}.not_found
			set_body ("Resource not found.")
		end

	iron: IRON_NODE

	request: WSF_REQUEST

	iron_version: detachable IRON_NODE_VERSION

feature -- Access

	header: HTTP_HEADER

	location: detachable READABLE_STRING_8
			-- Redirected location if any.

	status_code: INTEGER

	body: detachable READABLE_STRING_8

	title: detachable READABLE_STRING_8

feature -- Change

	set_iron_version (v: like iron_version)
		do
			iron_version := v
		end

	set_location (v: like location)
		do
			if v = Void then
				set_status_code ({HTTP_STATUS_CODE}.ok)
				header.remove_location
			else
				set_status_code ({HTTP_STATUS_CODE}.found)
				header.put_location (v)
			end
		end

	set_status_code (st: like status_code)
		do
			status_code := st
		end

	set_body (s: like body)
		do
			body := s
		end

	set_title (t: like title)
		do
			title := t
		end

feature -- Messages

	has_error: BOOLEAN

	message_type_normal: INTEGER = 0

	message_type_warning: INTEGER = 1

	message_type_error: INTEGER = 2

	add_normal_message (m: READABLE_STRING_8)
		do
			add_message (m, 0)
		end

	add_warning_message (m: READABLE_STRING_8)
		do
			add_message (m, 1)
		end

	add_error_message (m: READABLE_STRING_8)
		do
			has_error := True
			add_message (m, 2)
		end

	add_message (m: READABLE_STRING_8; k: INTEGER)
		require
			valid_k: k = message_type_normal or k = message_type_warning or k = message_type_error
		local
			lst: like messages
		do
			lst := messages
			if lst = Void then
				create lst.make (1)
				messages := lst
			end
			lst.force ([m, k])
		end

	messages: detachable ARRAYED_LIST [TUPLE [message: READABLE_STRING_8; kind: INTEGER]]

	messages_of_kind (a_kind: INTEGER): detachable ARRAYED_LIST [READABLE_STRING_8]
		do
			if attached messages as msg then
				create Result.make (msg.count)
				across
					msg as ic
				loop
					if ic.kind = a_kind then
						Result.force (ic.message)
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	get_has_error: BOOLEAN
		do
			has_error := attached messages as lst and then across lst as ic some ic.kind = message_type_error end
		end

	encoded_string (s: READABLE_STRING_32): READABLE_STRING_8
		do
			Result := json_encoder.encoded_string (s)
		end

	json_encoder: JSON_ENCODER
		once
			create Result
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
			-- Send Current message to `res'
			--
			-- This feature should be called via `{WSF_RESPONSE}.send (obj)'
			-- where `obj' is the current object
		local
			s: STRING
			b: BOOLEAN
			l_data: ARRAY [TUPLE [title: READABLE_STRING_8; kind: INTEGER]]
			h: like header
		do
			h := header
			res.set_status_code (status_code)
			create s.make_empty
			if
				request.is_content_type_accepted ({HTTP_MIME_TYPES}.application_json)
				or True -- Always return JSON for now.
			then
				l_data := <<["errors", message_type_error],
							["warnings", message_type_warning],
							["messages", message_type_normal]
							>>
				across l_data as ic_kinds loop
					if attached messages_of_kind (ic_kinds.kind) as lst and then not lst.is_empty then
						if not s.is_empty then
							s.append_character (',')
						end
						s.append ("%""+ ic_kinds.title +"%": [")
						b := True
						across lst as ic loop
							if b then
								b := False
							else
								s.append_character (',')
							end
							s.append ("%"" + ic + "%"")
						end
					end
				end
			end
			if attached body as l_body and then not l_body.is_empty then
				if not s.is_empty then
					s.append_character (',')
				end
				s.append (l_body)
			end
			if attached title as l_title and then not l_title.is_empty then
				if not s.is_empty then
					s.prepend_character (',')
				end
				s.prepend (l_title)
			end
			if s.is_empty or else s[1] /= '{' then
				s.prepend_character ('{')
				s.append_character ('}')
			end
			h.put_content_type_application_json
			h.put_content_length (s.count)
			res.put_header_lines (h)
			res.put_string (s)
			res.flush
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
