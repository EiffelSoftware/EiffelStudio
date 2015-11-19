note
	description: "[
					The data used for filling a bug report.
					See: https://www2.eiffel.com/support/protected/problem_report_form.aspx (login required)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_BUG_REPORT

create
	make

feature {NONE} -- Initialization

	make (a_synopsis: like synopsis; a_desc: like description; a_release: like release)
			-- Initialize a bug report with the required data
		require
			a_synopsis_attached: a_synopsis /= Void
			not_a_synopsis_is_empty: not a_synopsis.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_release_attached: a_release /= Void
			not_a_release_is_empty: not a_release.is_empty
		do
			synopsis := a_synopsis
			description := a_desc
			release := a_release

			-- Default value
			severity := severtiy_serious

			-- Default values
			category := 15 -- EiffelStudio.

			priority := 1  -- High

			class_issue := 1 -- bug

			attachments := ""

		ensure
			synopsis_set: synopsis.same_string (a_synopsis)
			description_set: description.same_string (a_desc)
			release_set: release.same_string (a_release)
		end

feature -- Query

	synopsis: STRING_GENERAL assign set_synopsis
			-- Title

	description: STRING_GENERAL assign set_description
			-- Detail

	release: STRING_GENERAL assign set_release
			-- Eiffel Studio release version

	environment: STRING_GENERAL assign set_environment
			-- Environment

	to_reproduce: STRING_GENERAL assign set_to_reproduce
			-- Way to reproduce

	confidential: BOOLEAN assign set_confidential
			-- Indicates if bug report should be marked as confidential

	severity: INTEGER assign set_severity
			-- Severity
			-- One value from severity enumeration in this class

	category: INTEGER
			-- Category
			-- One value from a list of categories.

	priority: INTEGER
			-- Priority
			-- One value from a list of priorities.				

	class_issue: INTEGER
			-- class
			-- One value from a list of class of issues.

	attachments: STRING_GENERAL
			-- attachments 		

feature -- Command

	set_synopsis (a_synopsis: STRING_GENERAL)
			-- Set `synopsis' with `a_synopsis'
		require
			a_synopsis_attached: a_synopsis /= Void
			not_a_synopsis_is_empty: not a_synopsis.is_empty
		do
			synopsis := a_synopsis
		ensure
			synopsis_set: synopsis.same_string (a_synopsis)
		end

	set_description (a_description: STRING_GENERAL)
			-- Set `description' with `a_description'
		require
			a_description_attached: a_description /= Void
			not_a_description_is_empty: not a_description.is_empty
		do
			description := a_description
		ensure
			description_set: description.same_string (a_description)
		end

	set_release (a_release: STRING_GENERAL)
			-- Set `release' with `a_release'.
		require
			a_release_attached: a_release /= Void
			not_a_release_is_empty: not a_release.is_empty
		do
			release := a_release
		ensure
			release_set: release.same_string (a_release)
		end

	set_environment (a_environment: STRING_GENERAL)
			-- Set `environment' with `a_environment'
		require
			a_environment_attached: a_environment /= Void
			not_a_environment_is_empty: not a_environment.is_empty
		do
			environment := a_environment
		ensure
			environment_set: environment.same_string (a_environment)
		end

	set_to_reproduce (a_to_reproduce: STRING_GENERAL)
			-- Set `to_reproduce' with `a_to_reproduce'
		require
			a_to_reproduce_attached: a_to_reproduce /= Void
			not_a_to_reproduce_is_empty: not a_to_reproduce.is_empty
		do
			to_reproduce := a_to_reproduce
		ensure
			to_reproduce_set: to_reproduce.same_string (a_to_reproduce)
		end

	set_confidential (a_confidential: like confidential)
			-- Set `confidential' with `a_confidential'
		do
			confidential := a_confidential
		ensure
			confidential_set: confidential = a_confidential
		end

	set_severity (a_value: like severity)
			-- Set 	`severity' with `a_value'
		require
			valid: is_severity_valid (a_value)
		do
			severity := a_value
		ensure
			set: severity = a_value
		end

feature -- Enumeration

	severity_critical: INTEGER = 1
			-- Severtiy critical

	severtiy_serious: INTEGER = 2
			-- Severity serious

	severity_non_critical: INTEGER = 3
			-- Severity non-critical

feature -- Contract support

	is_severity_valid (a_value: INTEGER): BOOLEAN
			-- If `a_value' a valid severity value?
		do
			Result := a_value = severity_critical or a_value = severtiy_serious or a_value = severity_non_critical
		end

invariant
	synopsis_attached: synopsis /= Void
	not_synopsis_is_empty: not synopsis.is_empty
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	release_attached: release /= Void
	not_release_is_empty: not release.is_empty

end
