note
	description: "Summary description for {LIBRARY_INDEXER_CONF_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER_CONF_FACTORY

inherit
	CONF_PARSE_FACTORY

	CONF_ACCESS

feature

	new_class (a_file_name: STRING_32; a_group: CONF_CLUSTER; a_path: STRING_32; a_classname: detachable STRING): CONF_CLASS
			-- Create a `CONF_CLASS' object.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			a_classname_not_empty: a_classname /= Void implies not a_classname.is_whitespace
		local
			l_unix_path: STRING_32
		do
			create l_unix_path.make_from_string (a_path)
			if not {PLATFORM}.is_unix then
				l_unix_path.replace_substring_all ("\", "/")
			end
			create Result.make (a_file_name, a_group, l_unix_path, "NEW_CLASS_NAME", Current)
			Result.rebuild (a_file_name, a_group, a_path)
			if attached Result.last_class_name as cl_name then
				Result.set_name (cl_name)
			end
		ensure
			Result_not_void: Result /= Void
		end

end
