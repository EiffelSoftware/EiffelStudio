note
	description: "Represents a rule violation."
	author: "Stefan Zurfluh", "Eiffel Software"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_RULE_VIOLATION

inherit
	COMPARABLE
		redefine out end

create
	make_with_rule,
	make_formatted

feature {NONE} -- Initialization

	make_with_rule (r: CA_RULE)
			-- Initializes a violation of rule `r`.
		do
			rule := r
				-- This is just the default. The rule may set the affected class otherwise
				-- if needed.
			affected_class := r.current_context.checking_class
			create long_description_info.make
			create fixes.make
				-- Use a plain rule title by default.
			title_generator := agent  (t: TEXT_FORMATTER) do t.add (rule.title) end
				-- Just delegate to the rule by default. The rule knows about its violations.
			description_generator := agent rule.format_violation_description(Current, ?)
		ensure
			rule_set: rule = r
		end

	make_formatted (title, description: PROCEDURE [TEXT_FORMATTER]; r: CA_RULE)
			-- Associate a rule violation with rule `r` and violation description `description`.
		do
			make_with_rule (r)
			title_generator := title
			description_generator := description
		ensure
			title_generator_set: title_generator = title
			description_generator_set: description_generator = description
			rule_set: rule = r
		end

feature -- Access

	rule: CA_RULE
			-- The rule that is violated.

	severity: like {CA_RULE}.severity
			-- Severity of the violation.
		do
			Result := severity_value
			if not attached Result then
				Result := rule.severity
			end
		end

	long_description_info: LINKED_LIST [ANY]
			-- Objects associated with this violation (often used for
			-- specific information (e. g. affected variable name, etc.).

	title_generator: PROCEDURE [TEXT_FORMATTER]
			-- A generator of a title.

	description_generator: PROCEDURE [TEXT_FORMATTER]
			-- A generator of a description.

	affected_class: detachable CLASS_C
			-- Affected class.

	location: detachable LOCATION_AS
			-- Location of rule violation, if available.

	fixes: LINKED_LIST [FIX_CLASS]
			-- Fix "strategies". Empty if there is no fix available for this rule
			-- violation.

feature -- Output

	add_title (t: TEXT_FORMATTER)
			-- Add a formatted title of the violation to `t`.
		do
			title_generator (t)
		end

	format_violation_description (a_formatter: TEXT_FORMATTER)
			-- Formats a description of `Current'.
		do
			description_generator (a_formatter)
		end

feature -- Comparison

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			if attached location as l_location and then attached a_other.location as l_other_location then
				if l_location.line = l_other_location.line then
					Result := l_location.column < l_other_location.column
				else
					Result := l_location.line < l_other_location.line
				end
			end
		end

feature {NONE} -- Access

	severity_value: detachable like severity
			-- Custom severity that may be different from `rule.severity`.

feature {CA_RULE} -- Modification

	set_affected_class (a_class: attached CLASS_C)
			-- Sets the class that this violations refers to to `a_class`.
			-- This is only needed when `a_class` differs from `{CA_RULE}.checking_class`
			-- of the rule at the time this violation is created. (See `make_with_rule`.)
		do
			affected_class := a_class
		end

	set_location (a_location: attached LOCATION_AS)
			-- Sets the location in code to `a_location'.
		do
			location := a_location
		end

	set_severity (s: like severity)
			-- Set `severity` to `s`.
		do
			severity_value := s
		ensure
			severity_set: severity = s
		end

feature -- String representation

	add_csv_line (csv: CA_CSV_WRITER)
			-- Add violation data to `csv`.
		local
			l_yankee: YANK_STRING_WINDOW
		do
			csv.put_string (severity.name)
			csv.put_string (affected_class.name)
			if attached location as l then
				csv.put_integer_32 (l.line)
				csv.put_integer_32 (l.position)
			else
				csv.put_empty
				csv.put_empty
			end
			csv.put_string (rule.title)
				-- Format description.
			create l_yankee.make
			format_violation_description (l_yankee)
			csv.put_string (l_yankee.stored_output)
			csv.put_string (rule.id)
			csv.put_integer_32 (rule.severity_score.value)
			csv.put_new_line
		end

	out: like {ANY}.out
			-- <Precursor>
		do
			create Result.make_from_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (severity.name))
			Result.append_character (';')
			Result.append (affected_class.name)
			Result.append_character (';')
			if attached location as l then
				Result.append_integer (l.line)
				Result.append_character (';')
				Result.append_integer (l.column)
			else
				Result.append_character (';')
			end
			Result.append_character (';')
			Result.append ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (rule.title))
			Result.append_character (';')
			Result.append ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (rule.id))
			Result.append_character (';')
			Result.append_integer (rule.severity_score.value)
		end

;note
	copyright: "Copyright (c) 2014-2020, Eiffel Software"
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
