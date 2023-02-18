note
	description: "[
			RULE #82: Missing is_equal redefinition
	
			The class defines '{HASHABLE}.hash_code',
			but does not redefine 'is_equal'. 'is_equal' may need to be redefined.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MISSING_IS_EQUAL_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent process_class)
		end

feature -- Properties

	name: STRING = "inconsistent_hash_code_redeclaration"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.missing_is_equal_title
		end

	id: STRING_32 = "CA082"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.missing_is_equal_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.missing_is_equal_violation_1)
		end

feature {NONE} -- Checking the rule

	process_class (a_class: CLASS_AS)
			-- Checks `a_class' for rule violations.
		do
			if is_current_hashable and then (not redefines_is_equal) then
					-- {HASHABLE}.hash_code is implemented ("modulo" renaming) but
					-- is_equal is not redefined.
					-- Add {HASHABLE} to info for formatted output:
				violations.extend (create {CA_RULE_VIOLATION}.make_with_rule (Current))
			end
		end

	is_current_hashable: BOOLEAN
			-- Is currently checked class a descendant of {HASHABLE}?
		do
			across current_context.checking_class.parents as l_parents loop
				if l_parents.name.is_equal ("HASHABLE") then
					Result := True
				end
			end
		end

	redefines_is_equal: BOOLEAN
			-- Does current class redefine `is_equal'?
		do
			across current_context.checking_class.written_in_features as l_feat loop
				if l_feat.name_32.is_equal ("is_equal") then
					Result := True
				end
			end
		end

end
