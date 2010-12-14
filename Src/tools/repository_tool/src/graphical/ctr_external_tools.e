note
	description: "Summary description for {CTR_EXTERNAL_TOOLS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_EXTERNAL_TOOLS

inherit
	EXECUTION_ENVIRONMENT

	PLATFORM

feature -- Url

	open_url (a_url: STRING)
		local
			s: STRING
		do
			s := a_url
			if s /= Void then
				if is_windows then
					if attached get ("COMSPEC") as l_comspec then
						s := l_comspec + " /C start %"%" %"" + s + "%""
					end
				end
				launch (s)
			end
		end

feature -- Diff viewer

feature -- 2 files diff

end
