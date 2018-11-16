note
	description: "Summary description for {VERIFY_CREDENTIALS_PARAMS}."
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_VERIFY_CREDENTIALS_PARAMS

inherit

	STRING_TABLE [STRING]
		export {TWITTER_VERIFY_CREDENTIALS_PARAMS} all
		end
create
	make, make_equal, make_caseless, make_equal_caseless


feature -- Element Change

	add_include_entities (a_val: BOOLEAN)
			-- Add 'include_entities' parameter.
		do
			force (a_val.out, include_entities)
		end

	add_skip_status (a_val: BOOLEAN)
			-- Add 'skip_status' parameter.
		do
			force (a_val.out, skip_status)
		end

	add_include_email (a_val: BOOLEAN )
			-- Add 'skip_status' parameter.
		do
			force (a_val.out, include_email)
		end

feature {NONE}-- Implementation Param

	include_entities: STRING = "include_entities"
		-- The entities node will not be included when set to false .	 	
		-- it's optional

	skip_status: STRING = "skip_status"
		-- When set to either true , t or 1 statuses will not be included in the returned user object.
		-- convetion we will use true, it's optional.

	include_email: STRING = "include_email"
		-- When set to true email will be returned in the user objects as a string.
		-- If the user does not have an email address on their account, or if the email address is not verified, null will be returned.	

end
