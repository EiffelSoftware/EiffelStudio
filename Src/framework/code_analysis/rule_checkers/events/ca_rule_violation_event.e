note
	description: "Event representing a rule violation detected by the Code Analyzer."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_RULE_VIOLATION_EVENT

inherit

	EVENT_LIST_ITEM_I
		redefine
			data
		end

create
	make

feature {NONE} -- Initialization

	make (a_violation: attached CA_RULE_VIOLATION)
			-- Initialize event item.
		do
			data := a_violation
			category := {ENVIRONMENT_CATEGORIES}.none
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
			Result := attached {CA_ERROR} data.rule.severity
		end

	frozen is_warning_event: BOOLEAN
			-- Does `Current' represent a warning?	
		do
			Result := attached {CA_WARNING} data.rule.severity
		end

	frozen is_suggestion_event: BOOLEAN
			-- Does `Current' represent a suggestion?	
		do
			Result := attached {CA_SUGGESTION} data.rule.severity
		end

	frozen is_hint_event: BOOLEAN
			-- Does `Current' represent a hint?	
		do
			Result := attached {CA_HINT} data.rule.severity
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

	title: STRING_32
			-- Title of the rule violation.
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
			Result := {EVENT_LIST_ITEM_TYPES}.unknown
		end

	frozen category: NATURAL_8
			-- <Precursor>

	frozen priority: INTEGER_8
			-- <Precursor>

feature -- Status report

	is_invalidated: BOOLEAN
			-- <Precursor>

	is_valid_data (a_data: ANY): BOOLEAN
			-- <Precursor>
		do
			Result := data /= Void
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

end
