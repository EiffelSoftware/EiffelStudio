indexing
	description: "[
		Communication base for accessing the Eiffel support system using cURL.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	COMM_SUPPORT_ACCESS

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Prepare cURL environment.
		local
			l_curl: like curl
			l_curls: CURL_EXTERNALS
		do
				-- Do global initialization
			create l_curls
			if l_curls.is_dynamic_library_exists then
				l_curls.global_init

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
				end
			end
		end

feature -- Clean up

	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			if is_support_accessible then
				curl.cleanup (curl_hnd)
				curl_hnd := default_pointer
			end
		ensure then
			not_is_support_accessible: not is_support_accessible
		end

feature {NONE} -- Access

	frozen curl_hnd: POINTER
			-- Handle to initialized cURL library

feature -- Status report

	is_support_accessible: BOOLEAN
			-- Indicates if access to the support site is available
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

feature -- Query

	support_url (a_relative_url: STRING_GENERAL; a_secure: BOOLEAN): STRING_8
			-- Retrieve full URL for login site
			--
			-- `a_relative_url': Relative url to the login site
			-- `a_secure': Indicates if a suecure connection should be used.
			-- `Result': An absolute URL to the requested page
		require
			not_a_relative_url_is_empty: a_relative_url /= Void implies not a_relative_url.is_empty
		local
			l_result: STRING_8
		do
			create l_result.make (256)
			if a_secure then
				l_result.append (support_url_root_s)
			else
				l_result.append (support_url_root)
			end
			l_result.append_character ('/')
			if a_relative_url /= Void then
				l_result.append (a_relative_url.as_string_8)
			end

			Result := l_result
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- HTML query

	find_view_state (a_source: STRING_GENERAL): STRING_GENERAL is
			-- Find __VIEWSTATE value in `a_source'.
		require
			a_source_attached: a_source /= Void
		do
			Result := find_expression ("<input\s+type=%"hidden%"\s+name=%"__VIEWSTATE%"\s+id=%"__VIEWSTATE%"\s+value=%"(.*?)%"\s/>", a_source)
		end

	find_location (a_source: STRING_GENERAL): STRING_8
			-- Find href in `a_source'.
		require
			a_source_attached: a_source /= Void
		do
			Result := find_expression ("<a\shref=%"(.*?)%">here", a_source).as_string_8
		end

	find_event_validation (a_source: STRING_GENERAL): STRING_GENERAL is
			-- Find EVENT_VALIDATION value in `a_source'.
		require
			a_source_attached: a_source /= Void
		do
			Result := find_expression ("<input\s+type=%"hidden%"\s+name=%"__EVENTVALIDATION%"\s+id=%"__EVENTVALIDATION%"\s+value=%"(.*?)%"\s/>", a_source)
		end

feature {NONE} -- HTML query

	find_expression (a_pattern: STRING_GENERAL; a_source: STRING_GENERAL): STRING_GENERAL
		require
			a_pattern_attached: a_pattern /= Void
			not_a_pattern_is_empty: not a_pattern.is_empty
			a_source_attached: a_source /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.compile (a_pattern.as_string_8)
			l_matcher.match (a_source.as_string_8)

			if l_matcher.has_matched then
				Result := l_matcher.captured_substring (1)

				check
					single_match: (agent (a_matcher: RX_PCRE_MATCHER): BOOLEAN
						do
							a_matcher.next_match
							Result := not a_matcher.has_matched
						end).item ([l_matcher])
				end
			end
		end

feature {NONE} -- Basic operations

	perform is
			-- Perform a cURL action.
		require
			is_support_accessible: is_support_accessible
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

feature {NONE} -- Constants

	support_url_root_s: STRING = "https://www2.eiffel.com"
			-- Support site secure base URL

	support_url_root: STRING = "http://www2.eiffel.com"
			-- Support site unsecure base URL

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
