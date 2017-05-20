note
	description: "[
				Specific implementation of HTTP_CLIENT_SESSION based on Eiffel NET library
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NET_HTTP_CLIENT_SESSION

inherit
	HTTP_CLIENT_SESSION
		redefine
			close
		end

	HTTP_SECURE_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
		do
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is interface usable?
		do
			Result := True
			if base_url.starts_with_general ("https://") then
				Result := is_secure_connection_supported
			end
		end

feature -- Access: persistent connection

	persistent_connection: detachable NET_HTTP_CLIENT_CONNECTION
			-- Socket used for persistent connection purpose.

feature -- Element change: persistent connection		

	set_persistent_connection (a_connection: like persistent_connection)
			-- Set `persistent_connection' to `a_connection'.
		do
			persistent_connection := a_connection
		end

feature -- Basic operation

	close
			-- <Precursor>
		do
			if attached persistent_connection as l_connection then
				persistent_connection := Void
				l_connection.socket.cleanup
			end
		end

feature -- Custom

	custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
			-- <Precursor>
		local
			req: HTTP_CLIENT_REQUEST
		do
			create {NET_HTTP_CLIENT_REQUEST} req.make (url (a_path, ctx), a_method, Current, ctx)
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
					check put_conflict_file_and_data: not ctx.has_upload_filename end
				end
			end

			create {NET_HTTP_CLIENT_REQUEST} req.make (url (a_path, ctx), a_method, Current, ctx)
			Result := req.response
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
