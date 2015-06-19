note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_GITHUB_CONSUMER

inherit
	TEST_OAUTH_CONSUMER_I

feature -- Execution

	test_github
		local
			params: TEST_GITHUB_PARAMETERS
			github: GITHUB
			tok: detachable READABLE_STRING_8
		do
			create params

			create github.make (params.username, params.password)

			github.get_authorizations
			across
				github.authorizations as c
			loop
				print (c.item.debug_output)
				print ("%N")
			end
			tok := params.token
			if tok = Void then
				if attached github.new_authorization_token (<<"user", "repo", "public_repo">>) as auth then
					tok := auth.token
				end
			end
			if tok /= Void then
				if tok /= params.token then
					params.set_token (tok)
					params.save
				end

				github.set_active_authorization (create {GITHUB_AUTHORIZATION}.make (tok))
				if attached github.repositories as repos then
					across
						repos as c
					loop
						print (c.item.debug_output)
						print ("%N")
					end
				end
			end

		end


--feature -- Execution

--	test
--		do
--			get_url ("/authorizations")
----			get_url ("/user")
----			get_url ("/user/repos")
----			get_url ("/user/repos?page=1&per_page=3")

----			get_url ("/")
----			get_url ("/gists")
--			post_url ("/gists", "{%"description%": %"Testing Eiffel, OAuth and Gist.github.com%", %"public%": true, %"files%": {%"test.txt%": {%"content%": %"This is a test%"}}}")
----			get_url ("/gists/59504")
--		end



note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
