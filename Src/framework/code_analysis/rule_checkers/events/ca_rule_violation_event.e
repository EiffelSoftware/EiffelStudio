note
	description: "Event representing a rule violation detected by the Code Analyzer."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_RULE_VIOLATION_EVENT

inherit

	EVENT_LIST_ITEM_I

create
	make

feature {NONE} -- Initialization

	make (a_violation: attached CA_RULE_VIOLATION)
			-- Initialize event item.
		do
			data := a_violation
			category := {ENVIRONMENT_CATEGORIES}.static_analysis
			priority := {PRIORITY_LEVELS}.normal
		ensure
			data_set: data = a_violation
		end

feature -- Access

	data: CA_RULE_VIOLATION
			-- <Precursor>

	description: STRING_32 = "Rule violation event."
			-- <Precursor>

	frozen is_error_event: BOOLEAN
			-- Does `Current' represent an error?
		do
			Result := attached {CA_ERROR} data.severity
		end

	frozen is_warning_event: BOOLEAN
			-- Does `Current' represent a warning?	
		do
			Result := attached {CA_WARNING} data.severity
		end

	frozen is_hint_event: BOOLEAN
			-- Does `Current' represent a hint?
		do
			Result := attached {CA_HINT} data.severity
		end

	affected_class: detachable CLASS_C
			-- Class the rule violation refers to.
		do
			Result := data.affected_class
		end

	format_description (a_formatter: attached TEXT_FORMATTER)
			-- Formats a description of the associated rule violation
			-- using `a_formatter'.
		do
			data.format_violation_description (a_formatter)
		end

	location: detachable LOCATION_AS
			-- Location of the rule violation.
		do
			Result := data.location
		end

	rule_title: STRING_32
			-- Title of the rule.
		do
			Result := data.rule.title
		ensure
			valid_result: Result /= Void
		end

	rule_id: STRING_32
			-- Rule ID of the rule violation.
		do
			Result := data.rule.id
		ensure
			valid_result: Result /= Void
		end

	severity_score: INTEGER
			-- Severity score of the rule violation.
		do
			Result := data.rule.severity_score.value
		end

	violation_description: STRING_32
			-- General description of the associated rule.
		do
			Result := data.rule.description
		ensure
			valid_result: Result /= Void
		end

	frozen type: NATURAL_8
			-- <Precursor>
		once
			Result := {EVENT_LIST_ITEM_TYPES}.error
		end

	frozen category: NATURAL_8
			-- <Precursor>

	frozen priority: INTEGER_8
			-- <Precursor>

feature -- Output

	add_title (t: TEXT_FORMATTER)
			-- Add a formatted title of the violation to `t`.
		do
			data.add_title (t)
		end

feature -- Status report

	is_invalidated: BOOLEAN
			-- <Precursor>

	is_valid_data (a_data: ANY): BOOLEAN
			-- <Precursor>
		do
			Result := data /= Void
		end

	has_text (s: READABLE_STRING_32): BOOLEAN
			-- Does this violation have a text `s`?
		local
			t: READABLE_STRING_32
		do
			if s.is_empty then
				Result := True
			else
				t := s.as_lower
				Result :=
					data.rule.title.as_lower.has_substring (t) or else
					rule_id.as_lower.has_substring (t) or else
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (affected_class.name).as_lower.has_substring (t) or else
					violation_description.as_lower.has_substring (t)
			end
		end

feature -- Element change

	set_category (a_category: like category)
			-- <Precursor>
		do
			category := a_category
		end

	set_priority (a_priority: like priority)
			-- <Precursor>
		do
			priority := a_priority
		end

feature -- Basic operations

	invalidate
			-- <Precursor>
		do
			is_invalidated := True
		end

;note
	copyright:	"Copyright (c) 2014-2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
