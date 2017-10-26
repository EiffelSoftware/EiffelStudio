note
	description: "Summary description for {WSF_FILE_SYSTEM_HANDLER_WITH_COMPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FILE_SYSTEM_HANDLER_WITH_COMPRESSION

inherit
	WSF_FILE_SYSTEM_HANDLER
		redefine
			initialize,
			process_transfert
		end

create
	make_with_path,
	make_hidden_with_path,
	make,
	make_hidden

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			create compression.make
		end

feature -- Access: compression

	compression: WSF_COMPRESSION

feature -- Execution

	process_transfert (f: FILE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ext: READABLE_STRING_32
			ct: detachable READABLE_STRING_8
			fres: WSF_FILE_RESPONSE_WITH_COMPRESSION
			dt: DATE_TIME
		do
			ext := extension (f.path.name)
			ct := extension_mime_mapping.mime_type (ext)
			if ct = Void then
				ct := {HTTP_MIME_TYPES}.application_force_download
			end

			create fres.make_with_content_type_and_path (ct, f.path)
				-- Apply compression based on request `req` header.
			fres.apply_compression (compression, req)

				-- Prepare response
			fres.set_status_code ({HTTP_STATUS_CODE}.ok)

				-- cache control
			create dt.make_now_utc
			fres.header.put_utc_date (dt)
			if max_age >= 0 then
				fres.set_max_age (max_age)
				if max_age > 0 then
					dt := dt.twin
					dt.second_add (max_age)
				end
				fres.set_expires_date (dt)
			end

				-- send
			fres.set_answer_head_request_method (req.request_method.same_string ({HTTP_REQUEST_METHODS}.method_head))
			res.send (fres)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
