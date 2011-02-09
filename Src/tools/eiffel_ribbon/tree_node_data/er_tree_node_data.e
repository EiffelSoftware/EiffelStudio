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

feature -- Settings

	set_command_name (a_command_name: detachable STRING)
			--
		do
			command_name := a_command_name
			remove_useless_symbol (command_name)
		end

	set_label_title (a_label_title: detachable STRING)
			--
		do
			label_title := a_label_title
			remove_useless_symbol (label_title)
		end

	set_small_image (a_small_image: detachable STRING)
			--
		do
			small_image := a_small_image
			remove_useless_symbol (small_image)
		end

	set_large_image (a_large_image: detachable STRING)
			--
		do
			large_image := a_large_image
			remove_useless_symbol (large_image)
		end

feature -- Query

	command_name: detachable STRING
			--

	label_title: detachable STRING
			--

	small_image: detachable STRING
			--

	large_image: detachable STRING
			--

	application_mode: INTEGER
			--

feature {NONE} -- Implementation

	remove_useless_symbol (a_string: detachable STRING)
			--
		do
			if attached a_string as l_string then
				l_string.replace_substring_all ("%N", "")
				l_string.replace_substring_all ("%T", "")
				l_string.replace_substring_all (" ", "")
			end
		end
end
