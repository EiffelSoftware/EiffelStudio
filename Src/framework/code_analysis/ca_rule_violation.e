note
	description: "Represents a rule violation."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_RULE_VIOLATION

inherit
	COMPARABLE
		rename
			out as csv_line
		redefine csv_line end

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

feature -- Inherited from {COMPARABLE}

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- Shall `Current' be "before" `a_other'. (For sorting, for example.)
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
			-- Sets the class that this violations refers to to 'a_class'. This is only
			-- needed when 'a_class' differs from '{CA_RULE}.checking_class' of the rule at
			-- the time this violation is created. (See 'make_with_rule'.)
		do
			affected_class := a_class
		end

	set_location (a_location: attached LOCATION_AS)
			-- Sets the location in code to `a_location'.
		do
			location := a_location
		end

feature -- String representation

	csv_line: STRING
			-- String representation of `Current' as a CSV line.
		local
			l_yankee: YANK_STRING_WINDOW
		do
			create Result.make_from_string (rule.severity.name)
			Result.append_character (';')
			Result.append (affected_class.name)
			Result.append_character (';')
			if location /= Void then
				Result.append (location.line.out)
				Result.append (", ")
				Result.append (location.column.out)
			end
			Result.append_character (';')
			Result.append (rule.title)
			Result.append (";%"")

			create l_yankee.make
			format_violation_description (l_yankee)
				-- Replace new lines by blanks for CSV compatibility.
			l_yankee.stored_output.replace_substring_all ("%N", " ")
				-- Replace double quotes by two double quotes in a row
				-- for CSV compatibility.
			l_yankee.stored_output.replace_substring_all ("%"", "%"%"")

			Result.append (l_yankee.stored_output)
			Result.append ("%";")
			Result.append (rule.id)
			Result.append_character (';')
			Result.append (rule.severity_score.value.out)
		end

end
