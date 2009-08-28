note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_BEAN

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make
		do
			release := ""
			to_reproduce_text := "default_to_reproduce"
			description_text := "default_description_text"
			environment_text:= "default_environment_text"
			synopsis := "default_synopsis"
			severity := "severity_critical"
			e_class := "default_class"
			priority := "priority_low"
			confidential := "default_confidential"
			category := "default_category"
			number := "default_number"
			submitter := "default_submitter"
			date := "default_date"
			status := "status_suspended"
			responsible := "god"
		end

feature -- Access	

	status: STRING assign set_status

	set_status (a_status: STRING)
		do
			status := a_status
		end

	date: STRING assign set_date

	set_date (a_date: STRING)
		do
			date := a_date
		end

	number: STRING assign set_number

	set_number (a_string: STRING)
		do
			number := a_string
		end

	submitter: STRING assign set_submitter

	set_submitter (a_submitter: STRING)
		do
			submitter := a_submitter
		end

	responsible: STRING assign set_responsible

	set_responsible (a_responsible: STRING)
		do
			responsible := a_responsible
		end

	release: STRING assign set_release

	set_release (a_release: STRING)
		do
			release := a_release
		end

	to_reproduce_text: STRING assign set_to_reproduce_text

	set_to_reproduce_text (a_to_reproduce_text: STRING)
		do
			to_reproduce_text := a_to_reproduce_text
		end

	description_text: STRING assign set_description_text

	set_description_text (a_description_text: STRING)
		do
			description_text := a_description_text
		end

	environment_text: STRING assign set_environment_text

	set_environment_text (a_environment_text: STRING)
		do
			environment_text := a_environment_text
		end

	synopsis: STRING assign set_synopsis

	set_synopsis (a_synopsis: STRING)
		do
			synopsis := a_synopsis
		end

	severity: STRING assign set_severity

	set_severity (a_severity: STRING)
		do
			severity := a_severity
		end

	e_class: STRING assign set_e_class

	set_e_class (a_class: STRING)
		do
			e_class := a_class
		end

	priority: STRING assign set_priority

	set_priority (a_priority: STRING)
	do
		priority := a_priority
	end

	category: STRING assign set_category

	set_category (a_category: STRING)
	do
		category := a_category
	end

	confidential: STRING assign set_confidential

	set_confidential (a_confidential: STRING)
		do
			confidential := a_confidential
		end

	out: STRING
		do
			Result := "PROBLEM_REPORT (" + release + ", " + to_reproduce_text + ", " + description_text + ", " + environment_text + ", " + synopsis + ", " + severity + ", " + e_class + ", " + priority + ", " + confidential  + ", " + category + ")"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
