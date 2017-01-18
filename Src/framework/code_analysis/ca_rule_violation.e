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
	make_with_rule

feature {NONE} -- Initialization

	make_with_rule (a_rule: attached CA_RULE)
			-- Initializes a violation of rule `a_rule'.
		do
			rule := a_rule
				-- This is just the default. The rule may set the affected class otherwise
				-- if needed.
			affected_class := a_rule.current_context.checking_class
			create long_description_info.make
			create fixes.make
		end

feature -- Properties

	rule: CA_RULE
			-- The rule that is violated.

	long_description_info: LINKED_LIST [ANY]
			-- Objects associated with this violation (often used for
			-- specific information (e. g. affected variable name, etc.).

	format_violation_description (a_formatter: TEXT_FORMATTER)
			-- Formats a description of `Current'.
		do
				-- Just delegate to rule. The rule knows about its violations.
			rule.format_violation_description (Current, a_formatter)
		end

	affected_class: detachable CLASS_C
			-- Affected class.

	location: detachable LOCATION_AS
			-- Location of rule violation, if available.

	fixes: LINKED_LIST [CA_FIX]
			-- Fix "strategies". Empty if there is no fix available for this rule
			-- violation.

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

feature {CA_RULE} -- Setting violation properties

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

feature -- String representation

	add_csv_line (csv: CA_CSV_WRITER)
			-- Add violation data to `csv`.
		local
			l_yankee: YANK_STRING_WINDOW
		do
			csv.put_string (rule.severity.name)
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
			create Result.make_from_string (rule.severity.name)
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
			Result.append (rule.title)
			Result.append_character (';')
			Result.append (rule.id)
			Result.append_character (';')
			Result.append_integer (rule.severity_score.value)
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
