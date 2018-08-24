note
	description: "Input for Boogie verifier."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_VERIFIER_INPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty input.
		do
			create boogie_files.make
			boogie_files.compare_objects
			create custom_content.make
		end

feature -- Access

	boogie_files: attached LINKED_LIST [attached STRING]
			-- List of files to include when running Boogie.
			-- These files will be added before `custom_content' in the order
			-- they appear in the list.

	custom_content: attached LINKED_LIST [attached STRING]
			-- Custom content which will be included when running Boogie.

	context: detachable STRING
			-- Optional context.

feature -- Status report

	is_empty: BOOLEAN
			-- Is input empty?
		do
			Result := boogie_files.is_empty and custom_content.is_empty
		end

feature -- Element change

	add_boogie_file (a_file_name: attached STRING)
			-- Add `a_file_name' to `boogie_files'.
		require
			file_exists: (create {PLAIN_TEXT_FILE}.make (a_file_name)).exists
			file_readable: (create {PLAIN_TEXT_FILE}.make (a_file_name)).is_readable
		do
			if not boogie_files.has (a_file_name) then
				boogie_files.extend (a_file_name)
			end
		ensure
			file_added: boogie_files.has (a_file_name)
		end

	add_custom_content (a_string: attached STRING)
			-- Add `a_string' to `custom_content'.
		do
			custom_content.extend (a_string.twin)
		ensure
			custom_content.last.is_equal (a_string)
		end

	set_context (a_string: STRING)
			-- Set `context' to `a_context'.
		do
			context := a_string
		end

feature -- Removal

	wipe_out
			-- Remove all input.
		do
			boogie_files.wipe_out
			custom_content.wipe_out
		end

end
