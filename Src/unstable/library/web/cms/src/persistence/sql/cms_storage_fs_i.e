note
	description: "Interface used to implement CMS Storage based on File system."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_FS_I

inherit
	SHARED_LOGGER

feature {NONE} -- Initialization

	make (a_location: PATH; a_api: CMS_API)
		do
			location := a_location
			api := a_api
			create error_handler.make
		end

feature -- Access

	api: CMS_API
			-- Associated CMS api.

	location: PATH
			-- File system location.

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.

	has_error: BOOLEAN
			-- Last operation reported error.
		do
			Result := error_handler.has_error
		end

	reset_error
			-- Reset errors.
		do
			error_handler.reset
		end

feature -- Helpers

	save_to_file (a_text: STRING; opt_name: detachable READABLE_STRING_GENERAL)
		local
			s: READABLE_STRING_GENERAL
			now: DATE_TIME
			fut: WSF_FILE_UTILITIES [RAW_FILE]
		do
			create fut
			if opt_name /= Void then
				s := opt_name
			else
				create now.make_now_utc
				s := date_to_yyyymmdd_hhmmss_string (now)
			end
			if attached fut.new_file (location.extended (s)) as f then
				f.put_string (a_text)
				f.close
			else
				error_handler.add_custom_error (0, "saving failure", Void)
			end
		end

	date_to_yyyymmdd_hhmmss_string (d: DATE_TIME): STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			Result.append_integer (d.year)
			Result.append_character ('-')
			i := d.month
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := d.day
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('_')
			i := d.hour
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := d.minute
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := d.second
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
		end

end
