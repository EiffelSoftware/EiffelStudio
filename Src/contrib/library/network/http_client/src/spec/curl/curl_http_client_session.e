note
	description: "[
				Specific implementation of HTTP_CLIENT_SESSION based on Eiffel cURL library
				
				WARNING: Do not forget to have the dynamic libraries libcurl (.dll or .so) 
				and related accessible to the executable (i.e in same directory, or in the PATH)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_HTTP_CLIENT_SESSION

inherit
	HTTP_CLIENT_SESSION

create
	make

feature {NONE} -- Initialization

	initialize
		local
			procmisc: PROCESS_MISC
		do
			create procmisc
			if attached procmisc.command_execution (curl_command_name + " -V", Void, False) as res then
				is_available := res.exit_code = 0
			else
				is_available := False
			end
		end

feature -- Status report

	curl_command_name: STRING_32
		once
			if attached {EXECUTION_ENVIRONMENT}.item ("HTTP_CLIENT_CURL") as v then
				Result := v
			else
				Result := "curl"
			end
		end

	is_available: BOOLEAN
			-- Is interface usable?

feature -- Custom

	custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		local
			req: HTTP_CLIENT_REQUEST
		do
			create {CURL_HTTP_CLIENT_REQUEST} req.make (url (a_path, ctx), a_method, Current, ctx)
			Result := req.response
		end

	custom_with_upload_data (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Same as `custom' but including upload data `a_data'.
		do
			Result := impl_custom (a_method, a_path, a_ctx, data, Void)
		end

	custom_with_upload_file (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- Same as `custom' but including upload file `fn'.
		do
			Result := impl_custom (a_method, a_path, a_ctx, Void, fn)
		end

feature -- Helper

	get (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := custom ("GET", a_path, ctx)
		end

	head (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := custom ("HEAD", a_path, ctx)
		end

	post (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("POST", a_path, a_ctx, data, Void)
		end

	post_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("POST", a_path, a_ctx, Void, fn)
		end

	patch (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("PATCH", a_path, a_ctx, data, Void)
		end

	patch_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("PATCH", a_path, a_ctx, Void, fn)
		end

	put (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("PUT", a_path, a_ctx, data, Void)
		end

	put_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := impl_custom ("PUT", a_path, a_ctx, Void, fn)
		end

	delete (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		do
			Result := custom ("DELETE", a_path, ctx)
		end

feature {NONE} -- Implementation

	impl_custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		local
			req: HTTP_CLIENT_REQUEST
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			f: detachable RAW_FILE
			l_data: detachable READABLE_STRING_8
		do
			ctx := a_ctx
			if data /= Void then
				if ctx = Void then
					create ctx.make
				end
				ctx.set_upload_data (data)
			end
			if fn /= Void then
				if ctx = Void then
					create ctx.make
				end
				ctx.set_upload_filename (fn)
			end
			if ctx /= Void then
				l_data := ctx.upload_data
				if l_data /= Void and a_method.is_case_insensitive_equal_general ("PUT") then
					--| Quick and dirty hack using real file, for PUT uploaded data
					--| FIXME [2012-05-23]: find better solution with libcurl for that need

					if ctx.has_upload_filename then
						check put_conflict_file_and_data: False end
					end

					if attached {EXECUTION_ENVIRONMENT}.temporary_directory_path as tmp then
						create f.make_open_temporary_with_prefix (tmp.extended ("tmp-libcurl-").name)
					else
						create f.make_open_temporary_with_prefix ("tmp-libcurl-")
					end
					f.put_string (l_data)
					f.close
					check ctx /= Void then
						ctx.set_upload_data (Void)
						ctx.set_upload_filename (f.path.name)
					end
				end
			end

			create {CURL_HTTP_CLIENT_REQUEST} req.make (url (a_path, ctx), a_method, Current, ctx)
			Result := req.response

			if f /= Void then
				f.delete
			end
			if l_data /= Void and a_ctx /= Void then
				a_ctx.set_upload_filename (Void)
				a_ctx.set_upload_data (l_data)
			end
		end

;note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
