note
	description: "Summary description for {ESA_LOG_ROLLING_WRITER_FILE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOG_ROLLING_WRITER_FILE

inherit

	LOG_ROLLING_WRITER_FILE

create
	make_at_location,
	make_at_location_and_count

feature {NONE} -- Initialization

	make_at_location_and_count (a_path: PATH; a_count: NATURAL)
			-- Create a new roller loger instance with path `path`
			-- and existing number of files.
		do
			make_at_location (a_path)
				-- Default index.
			backup_count := a_count
		ensure then
			backup_count_set: backup_count = a_count
		end


end
