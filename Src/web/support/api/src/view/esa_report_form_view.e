note
	description: "Objects that represent a report form"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_VIEW

inherit

	SHARED_HTML_ENCODER

create
	make

feature {NONE} -- Initialization

	make (a_categories: like categories; a_severities: like severities; a_classes: like classes; a_priorities: like priorities)
			-- Create an object instance.
		do
			categories := a_categories
			severities := a_severities
			classes := a_classes
			priorities := a_priorities
			set_confidential (True)
		ensure
			categories_set: categories = a_categories
			severities_set: severities = a_severities
			classes_set: classes = a_classes
			priorities_set: priorities = a_priorities
			confidential_set_true: confidential
		end

feature -- Access

	id: INTEGER
		-- Unique id.

 	categories: LIST [REPORT_CATEGORY]
 		-- Possible list of categories.

 	severities: LIST [REPORT_SEVERITY]
 		-- Possible list of severities.

  	classes: LIST [REPORT_CLASS]
  		-- Possible list of classes.

  	priorities: LIST [REPORT_PRIORITY]
  		-- Possible list of priorities.

  	category: INTEGER
		-- Current selected severity, 0 by default.

  	severity: INTEGER
		-- Current selected severity, 0 by default.

  	selected_class: INTEGER
  		-- Current selected class, 0 by default.

  	priority: INTEGER
  		-- Current selected priority, 0 by default.

	release: detachable STRING_32
		-- Release.

	confidential: BOOLEAN
		-- Is the report confidential?

	environment: detachable STRING_32
		-- Environment descritpion.

	synopsis: detachable STRING_32
		-- Problem summary.

	html_synopsis: detachable STRING_32
		-- Html encoded value for synopsis.

	description: detachable STRING_32
		-- Description of the problem.

	html_description: detachable STRING_32
		-- Html encoded value for description.

	description_json: detachable STRING_32
		--JSON description encoded.

	to_reproduce: detachable STRING_32
		-- How to reproduce the problem.

	html_to_reproduce: detachable STRING_32
		-- HTML encoded value for to_reproduce.

	to_reproduce_json: detachable STRING_32
		-- How to reproduce the problem.

	uploaded_files: detachable LIST [ESA_FILE_VIEW]
		-- Uploaded files

	temporary_files: detachable LIST [ESA_FILE_VIEW]
		-- Temporary files.

	temporary_files_names: detachable LIST [STRING]
		-- Temporary files names.		


feature -- Status Report

	is_valid_form: BOOLEAN
			-- Are the current values valid?
			-- all fields except to_reproduce are required
			-- category /= 0
			-- severity /= 0
			-- selected_class /= 0
			-- priority /= 0

		local
			l_errors: STRING_TABLE [READABLE_STRING_32]
		do
			create l_errors.make (0)
			if category = 0 then
				l_errors.put ("Not selected category", "category")
			end
			if severity = 0 then
				l_errors.put ("Not selected severity", "severity")
			end
			if selected_class = 0 then
				l_errors.put ("Not selected class", "selected_class")
			end
			if priority = 0 then
				l_errors.put ("Not selected priority", "priority")
			end
			if not attached release then
				l_errors.put ("Release is required", "release")
			end
			if not attached environment then
				l_errors.put ("Environment is required", "Environment")
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
			if attached to_reproduce as l_reproduce and then
				l_reproduce.count > 32768 then
				l_errors.put ("To Reproduce is too long, max value 32 KB", "Description")
			end
			if l_errors.is_empty then
				Result := True
			else
				errors := l_errors
			end

		end

feature -- Errors

	errors: detachable STRING_TABLE [READABLE_STRING_32]
		-- Hash table with errors and descriptions.				

feature -- Element Change

	set_id (a_id: INTEGER)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_release (a_release: READABLE_STRING_32)
			-- Set `release' with `a_release'.
		do
			release := a_release
		ensure
			release_set: attached release as l_release and then l_release.same_string (a_release)
		end

	set_confidential (a_confidential: BOOLEAN)
			-- Set `confidential' with `a_confidentail'.
		do
			confidential := a_confidential
		ensure
			confidential_set: confidential = a_confidential
		end

	set_environment (a_environment: READABLE_STRING_32)
			-- Set `environment' with `a_environment'
		do
			environment := a_environment
		ensure
			environment_set:  attached environment as l_environment and then l_environment.same_string (a_environment)
		end

	set_description (a_description: READABLE_STRING_32)
			-- Set `description' with `a_description'
		do
			description := a_description
			description_json := (create {JSON_ENCODER}).encoded_string (a_description)
			html_description := html_encoder.encoded_string (a_description)
		ensure
			description_set:  attached description as l_description and then l_description.same_string (a_description)
		end


	set_synopsis (a_synopsis: READABLE_STRING_32)
			-- Set `synopsis' with `a_synopsis'.
		do
			synopsis := a_synopsis
			html_synopsis := html_encoder.encoded_string (a_synopsis)
		ensure
			synopsis_set:  attached synopsis as l_synopsis and then l_synopsis.same_string (a_synopsis)
		end

	set_to_reproduce (a_to_reproduce: READABLE_STRING_32)
			-- Set `to_reproduce' with `a_to_reproduce'.
		do
			to_reproduce := a_to_reproduce
			to_reproduce_json := (create {JSON_ENCODER}).encoded_string (a_to_reproduce)
			html_to_reproduce := html_encoder.encoded_string (a_to_reproduce)
		ensure
			to_reproduce_set:  attached to_reproduce as l_to_reproduce and then l_to_reproduce.same_string (a_to_reproduce)
		end

	set_category (a_category: INTEGER)
			-- Set `category' with `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_severity (a_severity: INTEGER)
			-- Set `severity' with `a_severity'.
		do
			severity := a_severity
		ensure
			severity_set: severity = a_severity
		end

	set_selected_class (a_class: INTEGER)
			-- Set `selected_class' with `a_class'.
		do
			selected_class := a_class
		ensure
			selected_class_set: selected_class = a_class
		end

	set_priority (a_priority: INTEGER)
			-- Set `priority' with `a_priority'.
		do
			priority := a_priority
		ensure
			priority_set: priority = a_priority
		end

	set_files (a_files: like uploaded_files)
			-- Set `uploaded_files' with `a_files'.
		do
			uploaded_files := a_files
		ensure
			uploaded_files_set: uploaded_files = a_files
		end

	set_temporary_files (a_files: like temporary_files )
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
				create {ARRAYED_LIST [STRING]}l_files.make (1)
				temporary_files_names := l_files
			end
			l_files.force (a_name)
		end

end
