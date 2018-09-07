note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			prepare

			if argument_count > 0 then
				across
					argument_array as c
				loop
					if c.item.same_string ("github") then
						test_github
					elseif c.item.same_string ("google") then
						test_google
					elseif c.item.same_string ("twitter") then
						test_twitter
					end
				end
			else
				test_github
				test_google
	--			test_twitter -- NOT WORKING
			end
		end

	prepare
		local
			e: EXECUTION_ENVIRONMENT
			d: DIRECTORY
		do
			create d.make ("data")
			if not d.exists then
				d.recursive_create_dir
			end
			create e
			e.change_working_path (d.path)
		end

	test_github
		local
--			p: TEST_GITHUB_PARAMETERS
			t: TEST_GITHUB_CONSUMER
		do
			create t
			t.prepare_data
			t.test_github
		end

	test_twitter
		local
			t: TEST_TWITTER_CONSUMER
			p: TEST_TWITTER_PARAMETERS
		do
			create p
			create t.make (p.username, p.password, p.consumer_key, p.consumer_secret)
			t.execute
		end

	test_google
		local
			t: TEST_GOOGLE_CONSUMER
			p: TEST_GOOGLE_PARAMETERS
		do
			create p
			create t.make (p)
			t.execute
		end

note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
