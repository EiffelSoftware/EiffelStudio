indexing
	description: "Help topic file."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_TOPIC_FILE
	
inherit
	HELP_TOPIC
		redefine
			is_allowed
		end

create
	make_from_url,
	make_from_node
	
feature -- Query

	is_allowed: BOOLEAN is
			-- Is Current allowed to be displayed in table of
			-- contents?  If Current is a `Default_url' then retrun false
			-- since it should be a HELP_TOPIC_FOLDER
		do
			if url /= Void then
				if is_from_node then
					Result := Precursor
				else
					Result := not (short_name (url)).is_equal (Default_url) and Precursor
				end
			end
		end

end -- class HELP_TOPIC_FILE
