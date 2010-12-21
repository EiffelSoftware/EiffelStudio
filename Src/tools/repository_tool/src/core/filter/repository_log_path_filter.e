note
	description: "Summary description for {REPOSITORY_LOG_AUTHOR_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_PATH_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make

feature {NONE} -- Initialization

	make (v: like path)
		local
			m: like wild_matcher
		do
			path := v
			if v.has ('*') then
				has_wildchar := True
				create m.make_empty
				m.set_pattern (v)
				m.disable_case_sensitive
				wild_matcher := m
			end
		end

feature -- Access

	path: STRING

	has_wildchar: BOOLEAN

	wild_matcher: detachable KMP_WILD

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		local
			c: STRING
			p: like {REPOSITORY_LOG}.paths
		do
			c := a_log.common_parent_path
			if has_wildchar and attached wild_matcher as l_matcher then
				l_matcher.set_text (c)
				if l_matcher.pattern_matches then
					Result := True
				else
					p := a_log.paths
					from
						p.start
					until
						p.after or Result
					loop
						l_matcher.set_text (p.item.path)
						Result := l_matcher.pattern_matches
						p.forth
					end
				end
			elseif c.starts_with (path) then
				Result := True
			elseif path.starts_with (c) then
				p := a_log.paths
				from
					p.start
				until
					p.after or Result
				loop
					Result := p.item.path.starts_with (path)
					p.forth
				end
			end
		end

	to_string: STRING
		do
			Result := "path=" + path
		end

end
