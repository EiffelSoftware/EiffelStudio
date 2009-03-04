note
	description: "Summary description for {XB_PARSE_TAG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XB_PARSE_TAG


feature -- Access

	start_tag: STRING
			-- The starting tag
		deferred
		ensure
			start_tag_not_empty: not Result.is_empty
		end


	end_tag: STRING
			-- The ending tag
		deferred
			ensure
			start_tag_not_empty: not Result.is_empty
		end

feature -- Processing

	parse_string (a_root: ROOT_SERVLET_ELEMENT; a_string: STRING): STRING
			-- Extracts the specified tags from a string and returns
			-- the remaining string.
		deferred
		end



invariant
	tags_not_equal: not start_tag.is_equal(end_tag)


end
