note
	description : "[
				NULL version of HTTP_CLIENT_SESSION.
				It is used if no implementation is available (libcurl or net)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NULL_HTTP_CLIENT_SESSION

inherit
	HTTP_CLIENT_SESSION

create
	make

feature {NONE} -- Initialization

	initialize
		do
		end

feature -- Custom

	custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			create Result.make (base_url + a_path)
		end

	custom_with_upload_data (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom (a_method, a_path, a_ctx, data, Void)
		end

	custom_with_upload_file (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom (a_method, a_path, a_ctx, Void, fn)
		end

feature -- Helper

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
			Result := impl_custom ("POST", a_path, a_ctx, data, Void)
		end

	post_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom ("POST", a_path, a_ctx, Void, fn)
		end

	patch (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom ("PATCH", a_path, a_ctx, data, Void)
		end

	patch_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom ("PATCH", a_path, a_ctx, Void, fn)
		end

	put (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom ("PUT", a_path, a_ctx, data, Void)
		end

	put_file (a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := impl_custom ("PUT", a_path, a_ctx, Void, fn)
		end

	delete (a_path: READABLE_STRING_8; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): HTTP_CLIENT_RESPONSE
		do
			Result := custom ("DELETE", a_path, ctx)
		end

feature {NONE} -- Implementation

	impl_custom (a_method: READABLE_STRING_8; a_path: READABLE_STRING_8; a_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT; data: detachable READABLE_STRING_8; fn: detachable READABLE_STRING_8): HTTP_CLIENT_RESPONSE
		do
			Result := custom (a_method, a_path, a_ctx)
		end

feature -- Status report

	is_available: BOOLEAN = False
			-- Is interface usable?

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
