note
	description: "Objects that represent a report form"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_VIEW

create
	make

feature -- Initialization

	make (a_categories: like categories; a_severities: like severities; a_classes: like classes; a_priorities: like priorities)
		do
			categories := a_categories
			severities := a_severities
			classes := a_classes
			priorities := a_priorities
		ensure
			categories_set: categories = a_categories
			severities_set: severities = a_severities
			classes_set: classes = a_classes
			priorities_set: priorities = a_priorities
		end

feature -- Access

	id: INTEGER

 	categories: LIST[ESA_REPORT_CATEGORY]

 	severities: LIST[ESA_REPORT_SEVERITY]

  	classes: LIST[ESA_REPORT_CLASS]

  	priorities: LIST[ESA_REPORT_PRIORITY]

	release: detachable STRING_32

	confidential: BOOLEAN

	environment: detachable STRING_32

	synopsis: detachable STRING_32

	description: detachable STRING_32

	to_reproduce: detachable STRING_32

feature -- Element Change

	set_id (a_id: INTEGER)
			-- Set `id' with `a_id'
		do
			id := a_id
		end

	set_release (a_release: READABLE_STRING_32)
			-- Set `release' with `a_release'
		do
			release := a_release
		ensure
			release_set: attached release as l_release and then l_release.same_string (a_release)
		end

	set_confidential (a_confidential: BOOLEAN)
			-- Set `confidential' with `a_confidentail'
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
		ensure
			description_set:  attached description as l_description and then l_description.same_string (a_description)
		end


	set_synopsis (a_synopsis: READABLE_STRING_32)
			-- Set `synopsis' with `a_synopsis'
		do
			synopsis := a_synopsis
		ensure
			synopsis_set:  attached synopsis as l_synopsis and then l_synopsis.same_string (a_synopsis)
		end

	set_to_reproduce (a_to_reproduce: READABLE_STRING_32)
			-- Set `to_reproduce' with `a_to_reproduce'
		do
			to_reproduce := a_to_reproduce
		ensure
			to_reproduce_set:  attached to_reproduce as l_to_reproduce and then l_to_reproduce.same_string (a_to_reproduce)
		end



end
