note
	description: "Factory to create a new CACHE_INFO instance."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO_FACTORY

feature -- Factory Functions

	new_cache_info (a_path: PATH): CACHE_INFO
			-- Creates an initialize a {CACHE_INFO}.
			-- To ensure correct initialization `'a_path's directory will be created,
			-- as will the cache file `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_file: RAW_FILE
			l_dir: DIRECTORY
		do
			create l_file.make_with_path (a_path)
			create l_dir.make_with_path (a_path.parent)
			if not l_dir.exists then
				l_dir.recursive_create_dir
			end
			create Result
			if not l_file.exists then
				(create {EIFFEL_SERIALIZATION}).serialize (Current, a_path.name, False)
			end
		ensure
			a_path_exists: (create {RAW_FILE}.make_with_path (a_path)).exists
		end

end -- class {CACHE_INFO_FACTORY}
