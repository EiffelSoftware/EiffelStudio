note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO_FACTORY

feature -- Factory Functions

	new_cache_info (a_path: STRING): CACHE_INFO
			-- Creates an initialize a {CACHE_INFO}.
			-- To ensure correct initialization `'a_path's directory will be created,
			-- as will the cache file `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_file: FILE_INFO
			l_dir: DIRECTORY_INFO
			info_path: STRING
			retried: BOOLEAN
		do
			create l_file.make (a_path)
			l_dir := l_file.directory
			if not l_dir.exists then
				l_dir.create_
			end
			create Result
			if not l_file.exists then
				(create {EIFFEL_SERIALIZER}).serialize (Current, a_path, False)
			end
		ensure
			a_path_exists: (create {DIRECTORY_INFO}.make (a_path)).exists
		end

end -- class {CACHE_INFO_FACTORY}
