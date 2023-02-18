note
	description: "[
		RULE #67: Formal generic parameter name has more than one character
		
		Names of formal generic parameters in generic class declarations should only have one character.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_GENERIC_PARAMETER_TOO_LONG_RULE

inherit
	CA_STANDARD_RULE

create
	make_with_defaults

feature {NONE} -- Implementation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent pre_check_class)
		end

	pre_check_class (a_class: CLASS_AS)
		do
			create first_chars.make
			first_chars.compare_objects
			create fixes_for_char.make (3)
			create violations_for_char.make (3)

			if attached a_class.generics as l_generics then

					-- First iteration to get all the single character parameters.
				across l_generics as l_generic_decl loop
					if l_generic_decl.name.name_32.count = 1 then
						first_chars.extend (l_generic_decl.name.name_8.at (1))
					end
				end

					-- Second iteration to construct the violations.
				across l_generics as l_generic_decl loop
					if l_generic_decl.name.name_32.count > 1 then
						if not first_chars.has (l_generic_decl.name.name_8.at (1)) then
							create_violation (l_generic_decl.name.name_32)
						else
							create_violation_without_fix (l_generic_decl.name.name_32)
						end
					end
				end
			end

				-- Add the constructed violations.
			⟳ c: violations_for_char ¦ ⟳ v: c ¦ violations.extend (v) ⟲ ⟲
		end

	first_chars: LINKED_LIST [CHARACTER_32]

	fixes_for_char: HASH_TABLE [LINKED_LIST [CA_GENERIC_PARAMETER_TOO_LONG_FIX], CHARACTER_32]

	violations_for_char: HASH_TABLE [LINKED_LIST [CA_RULE_VIOLATION], CHARACTER_32]

	create_violation (a_name: READABLE_STRING_32)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_GENERIC_PARAMETER_TOO_LONG_FIX
			l_fixes: LINKED_LIST [CA_GENERIC_PARAMETER_TOO_LONG_FIX]
			l_violations: LINKED_LIST [CA_RULE_VIOLATION]
		do
			create l_violation.make_with_rule (Current)

			l_violation.long_description_info.extend (a_name)

			l_violation.set_location (current_context.checking_class.generics.start_location)

			create l_fix.make_with_param_name (current_context.checking_class, a_name)
			l_violation.fixes.extend (l_fix)

			if fixes_for_char.has (a_name.at (1)) then
					-- There already is at least one violation and fix with the same first character.

					-- Add all the other fixes to this violation.
				l_fixes := fixes_for_char.at (a_name.at (1))

				across l_fixes as l_another_fix loop
					l_violation.fixes.extend (l_another_fix)
				end

				l_fixes.extend (l_fix)
				fixes_for_char.replace (l_fixes, a_name [1])

					-- Add this fix to all the other violations
				l_violations := violations_for_char.at (a_name [1])

				from
					l_violations.start
				until
					l_violations.after
				loop
					l_violations.item_for_iteration.fixes.extend (l_fix)
					l_violations.forth
				end

				l_violations.extend (l_violation)

				violations_for_char.replace (l_violations, a_name [1])
			else
				create l_fixes.make
				l_fixes.extend (l_fix)
				fixes_for_char.put (l_fixes, a_name [1])

				create l_violations.make
				l_violations.extend (l_violation)
				violations_for_char.put (l_violations, a_name [1])
			end
		end

	create_violation_without_fix (a_name: READABLE_STRING_32)
		local
			l_violation: CA_RULE_VIOLATION
		do
			create l_violation.make_with_rule (Current)
			l_violation.long_description_info.extend (a_name)
			l_violation.set_location (current_context.checking_class.generics.start_location)
			violations.extend (l_violation)
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.generic_param_too_long_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_param_name then
				a_formatter.add (l_param_name)
			end
			a_formatter.add (ca_messages.generic_param_too_long_violation_2)
		end

feature -- Properties

	name: STRING = "long_formal_generic_name"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.generic_param_too_long_title
		end

	id: STRING_32 = "CA067"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.generic_param_too_long_description
		end

end
