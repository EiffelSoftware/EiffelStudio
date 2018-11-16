note
	description: "Summary description for {TWITTER_RATE_LIMIT_PARAMS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_RATE_LIMIT_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_RATE_LIMIT_PARAMS} all
		end
create
	make, make_equal, make_caseless, make_equal_caseless


feature -- Element Change

	add_resoures (a_val: LIST [STRING])
			-- Add 'include_entities' parameter.
		local
			l_str: STRING
		do
			create l_str.make_empty
			across a_val as ic loop
				l_str.append (ic.item)
				l_str.append_character (',')
			end
			l_str.remove_tail (1)
			force (l_str, resources)
		end

feature {NONE} -- Implementation

	resources: STRING = "resources"
			-- A comma-separated list of resource families you want to know the current rate limit disposition for.
			-- For best performance, only specify the resource families pertinent to your application. See API Rate Limiting for more information.	 	
			-- Examples statuses,friends,trends,help

end
