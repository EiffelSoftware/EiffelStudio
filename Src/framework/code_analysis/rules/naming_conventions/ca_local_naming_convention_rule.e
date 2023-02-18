note
	description: "[
			RULE #65: Local variable naming convention violated
		
			Local variable names should respect the Eiffel naming convention for local variables
			(all lowercase, begin with 'l_', no trailing or two consecutive underscores).
		]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LOCAL_NAMING_CONVENTION_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: PREFERENCE_MANAGER)
			-- Initializes rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			enforce_prefix := l_factory.new_boolean_preference_value (a_pref_manager,
				preference_option_name_enforce_prefix, default_enforce_prefix)
			enforce_prefix.set_default_value (default_enforce_prefix.out)
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_routine_pre_action (agent process_routine)
		end

feature -- Properties

	name: STRING = "local_name"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.variable_naming_convention_title
		end

	id: STRING_32 = "CA065"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.variable_naming_convention_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.local_naming_convention_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_variable_name then
				a_formatter.add (l_variable_name)
			end
			a_formatter.add (ca_messages.local_naming_convention_violation_2)
		end

feature {NONE} -- Preferences

	preference_option_name_enforce_prefix: STRING
			-- A name of an option to enforce variable prefix within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_enforce_prefix)
		end

	option_name_enforce_prefix: STRING = "enforce_prefix"
			-- A name of an option indicating whether a variable prefix should be enforced.

	enforce_prefix: BOOLEAN_PREFERENCE
			-- Should the convention of starting variable names with a prefix be enforced?

	default_enforce_prefix: BOOLEAN = False
			-- Default value of `enforce_prefix'.

feature {NONE} -- Rule checking

	process_routine (a_routine_as: attached ROUTINE_AS)
			-- Process `a_routine_as'.
		local
			l_viol: CA_RULE_VIOLATION
			l_construct_list: CONSTRUCT_LIST [INTEGER_32]
			l_leaf: LEAF_AS
			l_variable_name: STRING_32
		do
				-- It's a bit more complicated that one would expect, because retrieving the original
				-- text is the only way for checking the case (otherwise it's always lowercased).
				-- This code is basically copy-pasted in this class and in CA_ARGUMENT_NAMING_CONVENTION.
				-- Copy-pasting is bad, but creating a common ancestor just for these two rules is also bad.
				-- Edits here should be also made there.
				-- Whoever copy-pastes this a third time should consider refactoring the code.
			if a_routine_as.locals /= Void then
				across
					a_routine_as.locals as locals
				loop
					l_construct_list := locals.id_list.id_list
					across
						l_construct_list as l_id
					loop
						l_leaf := current_context.matchlist.at (l_id)
						l_variable_name := l_leaf.text_32 (current_context.matchlist)
						if not is_valid_local_variable_name (l_variable_name) then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (l_leaf.start_location)
							l_viol.long_description_info.extend (l_variable_name)
							violations.extend (l_viol)
						end
					end
				end
			end
		end

	allowed_names: ARRAY [READABLE_STRING_32]
			-- List of names that are allowed despite breaking the conventions.
		once
			Result := {ARRAY [READABLE_STRING_32]} <<"i", "j", "k", "m", "n">>
			Result.compare_objects
		end

	is_valid_local_variable_name (a_name: attached STRING_32): BOOLEAN
			-- Does `a_name' respect the naming conventions for local variables?
		do
				-- Sample violations:
				-- l_my__var, l_variable_, l_VARIABLE
				-- argument -- this is fine if the l_-convention is not enforced
			Result :=
				not a_name.ends_with ({STRING_32} "_") and
				not a_name.has_substring ({STRING_32} "__") and
				a_name.as_lower ~ a_name and
				(enforce_prefix.value implies a_name.starts_with ({STRING_32} "l_")) or else
				allowed_names.has (a_name)
		end

end
