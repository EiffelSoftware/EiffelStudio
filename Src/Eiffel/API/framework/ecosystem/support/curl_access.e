indexing
	description: "[
		Access to rudamentry function of cURL.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CURL_ACCESS

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Prepare cURL environment.
		local
			l_curl: like curl
		do
				-- Do global initialization
			(create {CURL_EXTERNALS}).global_init

			l_curl := curl
			curl_hnd := l_curl.init
			if curl_hnd /= default_pointer then
				debug ("cURL")
					l_curl.set_debug_function (curl_hnd)
					l_curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_verbose, 1)
				end
				l_curl.set_write_function (curl_hnd)
				l_curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_cookiefile, "cookie.txt")
				l_curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)

				last_result := {CURL_CODES}.curle_ok
			else
				-- cURL is not available
			end
		end

feature -- Clean up

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			if is_accessible then
				curl.cleanup (curl_hnd)
				curl_hnd := default_pointer
			end
		ensure then
			not_is_accessible: not is_accessible
		end

feature {NONE} -- Access

	frozen curl_hnd: POINTER
			-- Handle to initialized cURL library

feature -- Status report

	is_accessible: BOOLEAN
			-- Indicates if access to web resources
		do
			Result := curl_hnd /= default_pointer
		ensure
			not_curl_hnd_is_null: Result implies curl_hnd /= default_pointer
		end

feature {NONE} -- Status report

	last_result: INTEGER
			-- Last result of a performed cURL action `perform'. See {CURL_CODES} for codes

feature {NONE} -- Helpers

	frozen curl: CURL_EASY_EXTERNALS is
			-- Access to easy cURL external API.
		once
			create Result
		ensure
			not_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	perform is
			-- Perform a cURL action.
		require
			is_accessible: is_accessible
		do
			last_result := curl.perform (curl_hnd)
			if last_result /= {CURL_CODES}.curle_ok then
				(create {EXCEPTIONS}).raise ("cURL Error: " + last_result.out)
			end
		end

	encoding_url (a_url: STRING): STRING
			-- Simple URL encoding.
			-- Only replace / and + for the moment.
		require
			a_url_attached: a_url /= Void
		do
			Result := a_url.twin
			Result.replace_substring_all ("/", "%%2F")
			Result.replace_substring_all ("+", "%%2B")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not a_url.is_empty implies not Result.is_empty
			forward_slash_replaced: not Result.has_substring ("/")
			plus_replaced: not Result.has_substring ("+")
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
