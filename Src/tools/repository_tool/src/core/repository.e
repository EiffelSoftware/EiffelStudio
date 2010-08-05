note
	description: "Summary description for {REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY

feature {NONE} -- Initialization

	make
		do
			create uuid
		end

feature -- Access

	kind: STRING
			-- short string to set the nature of the repository
			--| svn, git, cvs, ..
		deferred
		end

	uuid: UUID

	has_uuid: BOOLEAN
		do
			Result := uuid /~ create {UUID}
		end

	location: STRING
		deferred
		end

	review_enabled: BOOLEAN

	review_variables: detachable HASH_TABLE [STRING, STRING]

	review_username: detachable STRING
		do
			if attached review_variables as vars then
				Result := vars.item ("user")
			end
		end

	review_password: detachable STRING
		do
			if attached review_variables as vars then
				Result := vars.item ("password")
			end
		end

	filters: detachable HASH_TABLE [like new_filter, STRING]


	new_filter (a_name: STRING): TUPLE [name: STRING; filter: detachable REPOSITORY_LOG_FILTER]
		do
			Result := [a_name, Void]
		end

--	default_filters: like filters
--		local
----			f: REPOSITORY_LOG_FILTER
--			fauthor: REPOSITORY_LOG_AUTHOR_FILTER
--			fpath: REPOSITORY_LOG_PATH_FILTER
----			fmessage: REPOSITORY_LOG_MESSAGE_FILTER
--			fgroup: REPOSITORY_LOG_GROUP_FILTER
--		do
--			if location.same_string ("https://svn.eiffel.com/eiffelstudio/trunk") then
--				create Result.make (3)
--				create fauthor.make ("jfiat")
--				Result.force (["By jfiat", fauthor], "jfiat")

--				create fpath.make ("/trunk/Src/C")
--				Result.force (["Run-time", fpath], "runtime")

--				create fgroup.make (2)
--				fgroup.add_filter (fauthor)
--				fgroup.add_filter (fpath)
--				Result.force (["Run-time by jfiat", fgroup], "runtime.jfiat")
--			end
--		end

	add_filter (a_key: STRING; a_name: STRING)
		local
			l_filters: like filters
		do
			l_filters := filters
			if l_filters = Void then
				create l_filters.make (1)
				filters := l_filters
			end
			l_filters.force (new_filter (a_name), a_key)
		end

	add_filter_to (a_key: STRING; a_filter: detachable REPOSITORY_LOG_FILTER)
		local
			d: like filter
			f: detachable REPOSITORY_LOG_FILTER
			g: REPOSITORY_LOG_GROUP_FILTER
		do
			d := filter (a_key)
			if d /= Void then
				if a_filter = Void then
					d.filter := Void
				else
					f := d.filter
					if f = Void then
						d.filter := a_filter
					elseif attached {REPOSITORY_LOG_GROUP_FILTER} f as l_group then
						l_group.add_filter (a_filter)
					else
						create g.make (2)
						g.add_filter (f)
						g.add_filter (a_filter)
						d.filter := g
					end
				end
			end
		end

	filter (a_key: STRING): detachable like new_filter
		do
			if
				attached filters as flst and then
				flst.has_key (a_key)
			then
				Result := flst.found_item
			end
		end

	tokens: detachable HASH_TABLE [TUPLE [url_pattern: STRING; key: STRING], STRING] --| {url_pattern, key}, name

	tokens_names: detachable ARRAY [STRING]
		local
			i: INTEGER
		do
			if attached tokens as l_tokens and then l_tokens.count > 0 then
				create Result.make_filled ("", 1, l_tokens.count)
				i := 1
				across
					l_tokens as c
				loop
					Result.put (c.key, i)
					i := i + 1
				end
			end
		end

	tokens_keys: detachable ARRAY [STRING]
		local
			i: INTEGER
		do
			if attached tokens as l_tokens and then l_tokens.count > 0 then
				create Result.make_filled ("", 1, l_tokens.count)
				i := 1
				across
					l_tokens as c
				loop
					Result.put (c.item.key, i)
					i := i + 1
				end
			end
		end

	token_name (s: STRING): STRING
		do
			Result := s.as_lower
		end

	add_token (a_name: STRING; a_key: detachable STRING; a_url_pattern: detachable STRING)
		local
			l_tokens: like tokens
			n: like token_name
			k,u: STRING
		do
			l_tokens := tokens
			if l_tokens = Void then
				create l_tokens.make (2)
				tokens := l_tokens
			end
			n := token_name (a_name)
			if a_key /= Void then
				k := a_key
			else
				k := ""
			end
			if a_url_pattern /= Void then
				u := a_url_pattern
			else
				u := ""
			end

			if l_tokens.has_key (n) then
				if attached l_tokens.found_item as f then
					if a_key /= Void then
						f.key := a_key
					end
					if a_url_pattern /= Void then
						f.url_pattern := a_url_pattern
					end
				end
			else
				l_tokens.force ([u, k], n)
			end
		end

	token_url_pattern (a_name: STRING): detachable STRING
		do
			if attached tokens as l_tokens and then l_tokens.has_key (a_name) then
				if attached l_tokens.found_item as t then
					Result := t.url_pattern
				end
			end
		end

	token_key (a_name: STRING): detachable STRING
		do
			if attached tokens as l_tokens and then l_tokens.has_key (a_name) then
				if attached l_tokens.found_item as t then
					Result := t.key
				end
			end
		end

	token_url (a_name: STRING; a_value: STRING): detachable STRING
		do
			if attached token_url_pattern (a_name) as p then
				create Result.make_from_string (p)
				Result.replace_substring_all ("$$", a_value)
			end
		end

--	issue_url_pattern: detachable STRING
--		do
--			Result := token_url_pattern ("issue")
--		end

--	issue_url (s: STRING): detachable STRING
--		do
--			Result := token_url ("issue", s)
--		end

--	test_url_pattern: detachable STRING
--		do
--			Result := token_url_pattern ("test")
--		end

--	test_url (s: STRING): detachable STRING
--		do
--			Result := token_url ("test", s)
--		end

feature -- Element change

	set_location (v: like location)
		require
			v_attached: v /= Void
		deferred
		ensure
			location_set: v ~ location
		end

	set_uuid (u: like uuid)
		do
			uuid := u
		end

	add_review_variable (v: STRING; k: STRING)
		require
			k_attached: k /= Void
			k_lowered: k.same_string (k.as_lower)
		local
			l_vars: like review_variables
		do
			l_vars := review_variables
			if l_vars = Void then
				create l_vars.make (6)
				review_variables := l_vars
			end
			l_vars.force (v, k)
		end

	set_review_variables (v: like review_variables)
		require
			v_attached: v /= Void
		do
			review_variables := v
		end

	set_review_enabled (v: like review_enabled)
		do
			review_enabled := v
		ensure
			commit_then_review_enabled_set: review_enabled = v
		end

	set_review_username (v: like review_username)
		require
			v_attached: v /= Void
		do
			add_review_variable (v, "username")
		ensure
			username_set: v ~ review_username
		end

	set_review_password (v: like review_password)
		require
			v_attached: v /= Void
		do
			add_review_variable (v, "password")
		ensure
			password_set: v ~ review_password
		end

end
