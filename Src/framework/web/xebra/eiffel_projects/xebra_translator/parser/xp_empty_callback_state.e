note
	description: "[
		{XP_EMPTY_CALLBACK_STATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_EMPTY_CALLBACK_STATE

inherit
	XP_CALLBACK_STATE

create
	make

feature -- Implementation

	on_start_tag (a_namespace, a_prefix, a_local_part : STRING)
			-- <Precursor>	
		do
		end

	on_content (a_content: STRING)
			-- <Precursor>
		do
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		do
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>		
		do
		end

	on_start_tag_finish
			-- <Precursor>
		do
		end

	on_finish
			-- <Precursor>
		do
		end

end
