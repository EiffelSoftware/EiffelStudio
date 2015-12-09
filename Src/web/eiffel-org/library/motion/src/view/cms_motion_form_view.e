note
	description: "Object view that represent a form for a wish item"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_FORM_VIEW

create
	make

feature {NONE} -- Initialization

	make (a_categories: like categories;)
			-- Create an object instance.
		do
			categories := a_categories
		ensure
			categories_set: categories = a_categories
		end

feature -- Access

	id: INTEGER_64
		-- Unique id.

 	categories: LIST[CMS_MOTION_LIST_CATEGORY]
 		-- Possible list of categories.

  	category: INTEGER
		-- Current selected severity, 0 by defaukt.

	status: INTEGER
		-- Current status.	

	synopsis: detachable STRING_32
		-- Problem summary.

	description: detachable STRING_32
		-- Description of the problem.

	uploaded_files: detachable LIST [CMS_MOTION_FILE]
		-- Uploaded files

	temporary_files: detachable LIST [CMS_MOTION_FILE]
		-- Temporary Uploaded files	

	temporary_files_names: detachable LIST [STRING]
		-- Temporary files names.

feature -- Status Report

	is_valid_form: BOOLEAN
			-- Are the current values valid?
			-- all fields except are required
			-- category /= 0
		local
			l_errors: STRING_TABLE [READABLE_STRING_32]
		do
			create l_errors.make (0)
			if category = 0 then
				l_errors.put ("Not selected category", "category")
			end
			if not attached synopsis then
				l_errors.put ("Synopsis is required", "Synopsis")
			end
			if not attached description then
				l_errors.put ("Description is required", "Description")
			end
			if attached description as l_description and then
				l_description.count > 32768 then
				l_errors.put ("Description is too long, max value 32 KB", "Description")
			end
			if l_errors.is_empty then
				Result := True
			else
				errors := l_errors
			end

		end

feature -- Errors

	errors: detachable STRING_TABLE[READABLE_STRING_32]
		-- Hash table with errors and descriptions.				

feature -- Element Change

	set_id (a_id: INTEGER_64)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_status (a_status: INTEGER)
			-- Set `status' with `a_status'.
		do
			status := a_status
		ensure
			status_set: status = a_status
		end


	set_description (a_description: READABLE_STRING_32)
			-- Set `description' with `a_description'
		do
			description := a_description
		ensure
			description_set:  attached description as l_description and then l_description.same_string (a_description)
		end


	set_synopsis (a_synopsis: READABLE_STRING_32)
			-- Set `synopsis' with `a_synopsis'.
		do
			synopsis := a_synopsis
		ensure
			synopsis_set:  attached synopsis as l_synopsis and then l_synopsis.same_string (a_synopsis)
		end

	set_category (a_category: INTEGER)
			-- Set `category' with `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_files (a_files: like uploaded_files)
			-- Set `uploaded_files' with `a_files'.
		do
			uploaded_files := a_files
		ensure
			uploaded_files_set: uploaded_files = a_files
		end

	set_temporary_files (a_files: like temporary_files)
			-- Set `temporary_files' with `a_files'.
		do
			temporary_files := a_files
		ensure
			temporary_files_set: temporary_files = a_files
		end

	add_temporary_file_name (a_name: STRING)
		local
			l_files: like temporary_files_names
		do
			l_files := temporary_files_names
			if l_files = Void then
				create {ARRAYED_LIST[STRING]}l_files.make (1)
				temporary_files_names := l_files
			end
			l_files.force (a_name)
		end

end
