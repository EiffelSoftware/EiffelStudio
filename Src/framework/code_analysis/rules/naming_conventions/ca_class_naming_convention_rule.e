note
	description: "[
		RULE #63: Class naming convention violated
		
		Class names should respect the Eiffel naming convention for classes
		(all uppercase, no trailing or two consecutive underscores).
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CLASS_NAMING_CONVENTION_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_class_pre_action (agent process_class)
		end

feature {NONE} -- Rule checking

	process_class (a_class_as: CLASS_AS)
			-- Process `a_class_as'.
		local
			l_viol: CA_RULE_VIOLATION
		do
				-- Retrieving the original text is the only way for checking the case (otherwise it's always lowercased).
			if not is_valid_class_name (a_class_as.class_name.text_32 (current_context.matchlist)) then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_class_as.class_name.start_location)
				violations.extend (l_viol)
			end
		end

	is_valid_class_name (a_name: READABLE_STRING_32): BOOLEAN
			-- Does `a_name' respect the naming conventions for classes?
		do
				-- Sample violations:
				-- MY_CLASS_, MY__CLASS, _MY_CLASS, my_class, my_CLASS

			Result := not a_name.ends_with ("_") and not a_name.has_substring ("__") and (a_name.as_upper ~ a_name)
		end

feature -- Properties

	name: STRING = "class_name"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.class_naming_convention_title
		end

	id: STRING_32 = "CA063"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.class_naming_convention_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.class_naming_convention_violation_1)
			check
				attached a_violation.affected_class
			end
			if attached a_violation.affected_class as l_affected_class then
				a_formatter.add_class (l_affected_class.original_class)
			end
			a_formatter.add (ca_messages.class_naming_convention_violation_2)
		end

end
