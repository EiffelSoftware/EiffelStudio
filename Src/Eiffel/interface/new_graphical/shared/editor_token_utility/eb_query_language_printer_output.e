indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_QUERY_LANGUAGE_PRINTER_OUTPUT

inherit
	QL_VISITOR

	SHARED_TEXT_ITEMS

feature -- Status report

	is_output_empty: BOOLEAN is
			-- Is output empty?
		deferred
		end

feature -- Basic operations

	initialize_last_output is
			-- Initialize `last_output'.
		deferred
		ensure
			output_wiped_out: is_output_empty
		end

feature{EB_QUERY_LANGUAGE_PRINTER_VISITOR} -- Implementation

	process_folder (a_name: STRING_32; a_path: STRING_32; a_group: CONF_GROUP) is
			-- Process folder.
			-- `a_name' is name of that folder, `a_path' is related path of that folder, such as "/abc/def".
			-- `a_group' is the group where that folder is located.
		require
			a_name_attached: a_name /= Void
			a_path_attached: a_path /= Void
			a_group_attached: a_group /= Void
		deferred
		end

	process_dot_separator is
			-- Process dot separator, i.e, put a dot in output.
		deferred
		end

end
