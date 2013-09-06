note

	description: "[
						Policies for determing caching of responses.
						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_CACHING_POLICY

feature -- Access

	Never_expires: NATURAL = 525600
		-- 525600 = 365 * 24 * 60 * 60 = (almost) 1 year;
		-- See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21 for an explanation of why this means never expire

	max_age (req: WSF_REQUEST): NATURAL
			-- Maximum age in seconds before response to `req` is considered stale;
			-- This is used to generate a Cache-Control: max-age header.
			-- Return 0 to indicate already expired.
			-- Return `Never_expires' to indicate never expires.
		require
			req_attached: req /= Void
		deferred
		ensure
			not_more_than_1_year: Result <= Never_expires
		end

	shared_age (req: WSF_REQUEST): NATURAL
			-- Maximum age in seconds before response to `req` is considered stale in a shared cache;
			-- This is used to generate a Cache-Control: s-maxage header.
			-- If you wish to have different expiry ages for shared and provate caches, redefine this routine.
			-- Return 0 to indicate already expired.
			-- Return `Never_expires' to indicate never expires.
		require
			req_attached: req /= Void
		do
			Result := max_age (req)
		ensure
			not_more_than_1_year: Result <= Never_expires
		end

	http_1_0_age (req: WSF_REQUEST): NATURAL
			-- Maximum age in seconds before response to `req` is considered stale;
			-- This is used to generate an Expires header, which HTTP/1.0 caches understand.
			-- If you wish to generate a different age for HTTP/1.0 caches, then redefine this routine.
			-- Return 0 to indicate already expired.
			-- Return `Never_expires' to indicate never expires. Note this will
			--  make a result cachecable that would not normally be cacheable (such as as response
			--  to a POST), unless overriden by cache-control headers, so be sure to check `req.request_method'.
		require
			req_attached: req /= Void
		do
			Result := max_age (req)
		ensure
			not_more_than_1_year: Result <= Never_expires
		end

	is_freely_cacheable (req: WSF_REQUEST): BOOLEAN
			-- Should the response to `req' be freely cachable in shared caches?
			-- If `True', then a Cache-Control: public header will be generated.
		require
			req_attached: req /= Void
		deferred
		end

	is_transformable (req: WSF_REQUEST): BOOLEAN
			-- Should a non-transparent proxy be allowed to modify headers of response to `req`?
			-- The headers concerned are listed in http://www.w3.org/Protocols/rfc2616-sec14.html#sec14,9.
			-- If `False' then a Cache-Control: no-transorm header will be generated.
		require
			req_attached: req /= Void
		do
			-- We choose a conservative default. But most applications can
			--  redefine to return `True'.
		end

	must_revalidate (req: WSF_REQUEST): BOOLEAN
			-- If a client has requested, or a cache is configured, to ignore server's expiration time,
			--  should we force revalidation anyway?
			-- If `True' then a Cache-Control: must-revalidate header will be generated.
		require
			req_attached: req /= Void
		do
			--  Redefine to force revalidation.
		end

	must_proxy_revalidate (req: WSF_REQUEST): BOOLEAN
			-- If a shared cache is configured to ignore server's expiration time,
			--  should we force revalidation anyway?
			-- If `True' then a Cache-Control: proxy-revalidate header will be generated.
		require
			req_attached: req /= Void
		do
			--  Redefine to force revalidation.
		end

	private_headers (req: WSF_REQUEST): detachable LIST [READABLE_STRING_8]
			-- Header names intended for a single user.
			-- If non-Void, then a Cache-Control: private header will be generated.
			-- Returning an empty list prevents the entire response from being served from a shared cache.
		require
			req_attached: req /= Void
		deferred
		ensure
			not_freely_cacheable: Result /= Void implies not is_freely_cacheable (req)
		end

	non_cacheable_headers (req: WSF_REQUEST): detachable LIST [READABLE_STRING_8]
			-- Header names that will not be sent from a cache without revalidation;
			-- If non-Void, then a Cache-Control: no-cache header will be generated.
			-- Returning an empty list prevents the response being served from a cache
			--  without revalidation.
		require
			req_attached: req /= Void
		deferred
		end

	is_sensitive (req: WSF_REQUEST): BOOLEAN
			-- Is the response to `req' of a sensitive nature?
			-- If `True' then a Cache-Control: no-store header will be generated.
		require
			req_attached: req /= Void
		deferred
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
