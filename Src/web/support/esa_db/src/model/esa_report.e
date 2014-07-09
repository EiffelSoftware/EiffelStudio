note
	description: "Objects that represent a problem report"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT

inherit

	STRING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_number: INTEGER; a_synopsis: READABLE_STRING_32; a_confidential: BOOLEAN)
		do
			number := a_number
			synopsis := a_synopsis
			confidential := a_confidential
		end

feature -- Access

	id: INTEGER
			-- Unique id.

	number: INTEGER
			-- Report number.

	synopsis: READABLE_STRING_32
			-- Report synopsis.

	confidential: BOOLEAN
			-- Is the report confidential?

	status: detachable ESA_REPORT_STATUS
			-- Report status.

	contact: detachable ESA_USER
			-- User who submit the problem report.

	submission_date: detachable DATE_TIME
			-- Submission date.

feature -- Optional

	release: detachable READABLE_STRING_32
			-- Release associated.

	priority: detachable ESA_REPORT_PRIORITY
			-- Assigned priority.

	severity: detachable ESA_REPORT_SEVERITY
			-- Assigned severity.

	category: detachable ESA_REPORT_CATEGORY
			-- Assigned category.

	report_class: detachable ESA_REPORT_CLASS
			-- Assigned class.

	environment: detachable READABLE_STRING_32
			-- Environment associated.

	description: detachable READABLE_STRING_32
			-- Problem description.

	to_reproduce: detachable READABLE_STRING_32
			-- How to reproduce the problem.

	description_encode: detachable READABLE_STRING_32
			-- workaround to support json encode.

	to_reproduce_encode: detachable READABLE_STRING_32
			-- workaround to support json encode.

	assigned: detachable ESA_USER
			-- Reponsible assigned to work on the problem.

	submission_date_output: detachable STRING
			-- formatted date as dd mmm yyyy.

feature -- Element change

	set_number (v: like number)
			-- Set `number' to `v'.
		do
			number := v
		ensure
			number_set: number = v
		end

	set_synopsis (v: like synopsis)
			-- Set `synopsis' to `v'.
		do
			synopsis := v
		ensure
			synopsis_set: synopsis = v
		end

	set_status (v: like status)
			-- Set `status' to `v'.
		do
			status := v
		ensure
			status_set: status = v
		end

	set_contact (v: like contact)
			-- Set `contact' to `v'.
		do
			contact := v
		ensure
			contact_set: contact = v
		end

	set_release (v: like release)
			-- Set `release' to `v'.
		do
			release := v
		ensure
			release_set: release = v
		end

	set_priority (v: like priority)
			-- Set `priority' to `v'.
		do
			priority := v
		ensure
			priority_set: priority = v
		end

	set_severity (v: like severity)
			-- Set `severity' to `v'.
		do
			severity := v
		ensure
			severity_set: severity = v
		end

	set_report_class (v: like report_class)
			-- Set `report_class' to `v'
		do
			report_class := v
		ensure
			report_class_set: report_class = v
		end

	set_environment (v: like environment)
			-- Set `environment' to `v'
		do
			if is_blank (v) then
				environment := Void
			else
				environment := v
			end
		end

	set_description (v: like description)
			-- Set `description' to `v'
		do
			if is_blank (v) then
				description := Void
			else
				description := v
				if attached v as l_v then
					description_encode := json_encode (l_v)
				end
			end
		end

	set_to_reproduce (v: like to_reproduce)
			-- Set `to_reproduce' to `v'
		do
			if is_blank (v) then
				to_reproduce := Void
			else
				to_reproduce := v
				if attached v as l_v then
					to_reproduce_encode := json_encode (l_v)
				end
			end
		end

	set_submission_date (a_date: like submission_date)
			-- Set `submission_date' to `a_date'.
		do
			submission_date := a_date
			if a_date /= void then
				submission_date_output := a_date.formatted_out ("[0]dd/mm/yyyy")
			end
		ensure
			submission_date_set: submission_date = a_date
		end

	set_report_category (a_category: ESA_REPORT_CATEGORY)
			-- Set `report_category' to `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_assigned (v: like assigned)
			-- Set `assigned' to `v'.
		do
			assigned := v
		ensure
			assigned_set: assigned = v
		end

	set_confidential (a_value: like confidential)
			-- Set `confidential' with `a_value'.
		do
			confidential := a_value
		ensure
			confidential_set: confidential = a_value
		end

feature -- Filled data

	interactions: detachable LIST [ESA_REPORT_INTERACTION]
			-- Report interactions

feature -- Fill

	set_interactions (v: like interactions)
			-- Set `interactions' to `v'.
		do
			interactions := v
		ensure
			interactions_set: interactions = v
		end

feature --JSON encode

feature -- Output

	string_8: STRING_8
			-- String representation.
		do
			create Result.make_from_string ("%N(" + id.out + ")")
			Result.append (" #" + number.out + ":")
			Result.append (synopsis.as_string_8)
			Result.append_character ('%N')
			if attached status as st then
				Result.append ("  " + st.string)
			end
			if attached priority as p then
				Result.append (" " + p.string)
			end
			if attached severity as s then
				Result.append (" " + s.string)
			end
			if attached report_class as c then
				Result.append (" " + c.string)
			end
			if confidential then
				Result.append (" Confidential")
			else
				Result.append (" Public")
			end
			if attached contact as u then
				Result.append ("%N  Reported by " + u.name)
			end
			if attached release as rel then
				Result.append ("%N  Release: " + rel)
			end
			if attached environment as env then
				Result.append ("%N  Environment: " + env)
			end
			if attached description as d then
				Result.append ("%N  Description:%N" + indented_text ("%T", d) + "%N")
			end
			if attached to_reproduce as t then
				Result.append ("%N  To-Reproduce:%N" + indented_text ("%T", t) + "%N")
			end
			if attached submission_date as l_date then
				Result.append ("%N Submission date:" + l_date.out)
			end
			if attached status as l_status then
				Result.append ("%N Status: " + l_status.string)
			end
		end

end
