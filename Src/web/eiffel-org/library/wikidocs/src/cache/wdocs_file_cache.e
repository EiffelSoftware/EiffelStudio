note
	description: "Summary description for {WDOCS_FILE_CACHE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_FILE_CACHE [G -> ANY]

inherit
	WDOCS_CACHE [G]

feature {NONE} -- Initialization

	make (a_cache_filename: PATH)
		do
			path := a_cache_filename
		end

	path: PATH

feature -- Status report

	exists: BOOLEAN
			-- Do associated cache file exists?
		local
			ut: FILE_UTILITIES
		do
			Result := ut.file_path_exists (path)
		end

feature -- Access

	cache_date_time: DATE_TIME
			-- <Precursor>	
		local
			f: RAW_FILE
		do
			create f.make_with_path (path)
			if f.exists then
				Result := file_date_time (f)
			else
				create Result.make_now
			end
		end

	current_date_time: DATE_TIME
			-- <Precursor>
		do
			create Result.make_now
		end

	file_size: INTEGER
			-- Associated file size.
		require
			exists: exists
		local
			f: RAW_FILE
		do
			create f.make_with_path (path)
			if f.exists and then f.is_access_readable then
				Result := f.count
			end
		end

	item: detachable G
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (path)
				if f.exists and then f.is_access_readable then
					f.open_read
					Result := file_to_item (f)
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Element change

	delete
			-- <Precursor>
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (path)
					-- Create recursively parent directory if it does not exists.
				if f.exists and then f.is_access_writable then
					f.delete
				end
			end
		rescue
			retried := True
			retry
		end

	put (g: G)
			-- <Precursor>
		local
			f: RAW_FILE
			d: DIRECTORY
		do
			create f.make_with_path (path)
				-- Create recursively parent directory if it does not exists.
			create d.make_with_path (path.parent)
			if not d.exists then
				d.recursive_create_dir
			end
			if not f.exists or else f.is_access_writable then
				f.open_write
				item_to_file (g, f)
				f.close
			end
		end

feature -- Helpers

	file_date_time (f: FILE): DATE_TIME
			-- Last change date for file `f'.
		require
			f.exists
		do
			create Result.make_from_epoch (f.date.as_integer_32)
		end

feature {NONE} -- Implementation

	file_to_item (f: FILE): detachable G
		require
			is_open_write: f.is_open_read
		deferred
		end

	item_to_file (g: G; f: FILE)
		require
			is_open_write: f.is_open_write
		deferred
		end

end
