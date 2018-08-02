note
	description: "Cache using a local file."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_FILE_CACHE [G -> ANY]

inherit
	CMS_CACHE [G]

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
				Result := utc_file_date_time (f)
			else
				create Result.make_now_utc
			end
		end

	current_date_time: DATE_TIME
			-- <Precursor>
		do
				-- UTC, since `cache_date_time' is UTC!
			create Result.make_now_utc
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
			else
				if f /= Void and then not f.is_closed then
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
			retried: BOOLEAN
		do
			if not retried then
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
			else
				if f /= Void and then not f.is_closed then
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Helpers

	utc_file_date_time (f: FILE): DATE_TIME
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

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
