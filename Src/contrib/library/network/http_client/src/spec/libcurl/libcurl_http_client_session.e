note
	description: "[
				Specific implementation of HTTP_CLIENT_SESSION based on Eiffel cURL library
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LIBCURL_HTTP_CLIENT_SESSION

inherit
	HTTP_CLIENT_SESSION

create
	make

feature {NONE} -- Initialization

	initialize
		do
			create curl -- cURL externals
			create curl_easy -- cURL easy externals
			curl_easy.set_curl_function (create {LIBCURL_DEFAULT_FUNCTION}.make)
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is interface usable?
		do
			Result := curl.is_dynamic_library_exists
		end

feature -- Basic operation

	custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		local
			req: HTTP_CLIENT_REQUEST
		do
			create {LIBCURL_HTTP_CLIENT_REQUEST} req.make (base_url + a_path, a_method, Current, ctx)
			Result := req.execute
		end

	get (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			Result := custom ("GET", a_path, ctx)
		end

	head (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			Result := custom ("HEAD", a_path, ctx)
		end

	post (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_post (a_path, a_ctx, data, Void)
		end

	post_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_post (a_path, a_ctx, Void, fn)
		end

	put (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		local
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			f: detachable RAW_FILE
			l_data: detachable READABLE_STRING_8
		do
			--| Quick and dirty hack using real file, for PUT uploaded data
			--| FIXME [2012-05-23]: better use libcurl for that purpose
			ctx := a_ctx
			if data /= Void then
				if ctx = Void then
					create ctx.make
				end
				ctx.set_upload_data (data)
			end
			if ctx /= Void then
				l_data := ctx.upload_data
			end
			if l_data /= Void then
				create f.make_open_write (create {FILE_NAME}.make_temporary_name)
				f.put_string (l_data)
				f.close
				check ctx /= Void then
					ctx.set_upload_data (Void)
					ctx.set_upload_filename (f.path.name)
				end
			end
			Result := custom ("PUT", a_path, ctx)
			if f /= Void then
				f.delete
			end
			if l_data /= Void and a_ctx /= Void then
				a_ctx.set_upload_filename (Void)
				a_ctx.set_upload_data (l_data)
			end
		end

	put_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		local
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
		do
			ctx := a_ctx
			if fn /= Void then
				if ctx = Void then
					create ctx.make
				end
				ctx.set_upload_filename (fn)
			end
			Result := custom ("PUT", a_path, ctx)
		end

	delete (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			Result := custom ("DELETE", a_path, ctx)
		end

feature {NONE} -- Implementation

	impl_post (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		local
			req: HTTP_CLIENT_REQUEST
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
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
			create {LIBCURL_HTTP_CLIENT_REQUEST} req.make (base_url + a_path, "POST", Current, ctx)
			Result := req.execute
		end

feature {LIBCURL_HTTP_CLIENT_REQUEST} -- Curl implementation

	curl: CURL_EXTERNALS
			-- cURL externals

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals


;note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
