note
	description: "[
					RULE #66: Argument naming convention violated
		
					Argument names should respect the Eiffel naming convention for arguments
					(all lowercase, begin with 'a_', no trailing or two consecutive underscores).
	]"
	author: "Paolo Antonucci"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ARGUMENT_NAMING_CONVENTION_RULE

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
			enforce_argument_prefix := l_factory.new_boolean_preference_value (a_pref_manager, preference_namespace + ca_names.enforce_argument_prefix, default_enforce_argument_prefix)
			enforce_argument_prefix.set_default_value (default_enforce_argument_prefix.out)
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_body_pre_action (agent process_body)
		end

feature {NONE} -- Rule checking

	process_body (a_body_as: BODY_AS)
			-- Process `a_body_as'.
		local
			l_viol: CA_RULE_VIOLATION
			l_construct_list: CONSTRUCT_LIST [INTEGER_32]
			l_leaf: LEAF_AS
			l_argument_name: STRING
		do
				-- It's a bit more complicated that one would expect, because retrieving the original
				-- text is the only way for checking the case (otherwise it's always lowercased).
				-- This code is basically copy-pasted in this class and in CA_LOCAL_NAMING_CONVENTION.
				-- Copy-pasting is bad, but creating a common ancestor just for these two rules is also bad.
				-- Edits here should be also made there.
				-- Whoever copy-pastes this a third time should consider refactoring the code.
			if a_body_as.arguments /= Void then
				across
					a_body_as.arguments as arguments
				loop
					l_construct_list := arguments.item.id_list.id_list
					across
						l_construct_list as l_id
					loop
						l_leaf := current_context.matchlist.at (l_id.item)
						l_argument_name := l_leaf.text_32 (current_context.matchlist)
						if not is_valid_argument_name (l_argument_name) then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (l_leaf.start_location)
							l_viol.long_description_info.extend (l_argument_name)
							violations.extend (l_viol)
						end
					end
				end
			end
		end

	allowed_names: ARRAY [STRING]
			-- List of names that are allowed despite breaking the conventions.
		once
			Result := << "i", "j", "k", "n" >>
			Result.compare_objects
		end

	is_valid_argument_name (a_name: STRING): BOOLEAN
			-- Does `a_name' respect the naming conventions for arguments?
		do
				-- Sample violations:
				-- a_my__arg, a_argument_, a_ARGUMENT
				-- argument -- this is fine if the a_-convention is not enforced

			Result := (not a_name.ends_with ("_") and not a_name.has_substring ("__") and (a_name.as_lower ~ a_name) and (not enforce_argument_prefix.value or else a_name.starts_with ("a_"))) or else allowed_names.has (a_name)
		end

feature -- Options

	enforce_argument_prefix: BOOLEAN_PREFERENCE
		-- Should the convention of starting argument names with "a_" be enforced?

	default_enforce_argument_prefix: BOOLEAN = True
		-- Default value of `enforce_argument_prefix'.

feature -- Properties

	name: STRING = "argument_name"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.argument_naming_convention_title
		end

	id: STRING_32 = "CA066"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.argument_naming_convention_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.argument_naming_convention_violation_1)
			check
				attached {STRING} a_violation.long_description_info.first
			end
			if attached {STRING} a_violation.long_description_info.first as l_arg_name then
				a_formatter.add (l_arg_name)
			end
			a_formatter.add (ca_messages.argument_naming_convention_violation_2)
		end

end
