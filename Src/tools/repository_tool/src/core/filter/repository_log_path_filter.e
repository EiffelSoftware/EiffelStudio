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
		do
			path := v
		end

feature -- Access

	path: STRING

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		local
			c: STRING
			p: like {REPOSITORY_LOG}.paths
		do
			c := a_log.common_parent_path
			if c.starts_with (path) then
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
