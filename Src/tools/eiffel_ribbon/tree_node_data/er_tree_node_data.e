note
	description: "Summary description for {ER_TREE_NODE_DATA}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_TREE_NODE_DATA

feature -- Command

	update_for_xml_attribute (a_name, a_value: STRING)
			--
		require
			not_void: a_name /= Void
			not_void: a_value /= Void
		deferred
		end

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			--
		do
		end

	on_content (a_content: STRING)
			--
		do
		end
		
end
