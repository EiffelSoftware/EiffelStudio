note
	description: "[
			RULE #12: Missing creation procedure with no arguments
	
			In most of the cases a class that has at least one creation
			procedure with arguments should also have a creation procedure
			with no arguments. Arguments of creation procedures most often
			are some initializing data or options. Normally, one should be
			able to create class with empty initializing data, where the
			client can set or add the data later. For options, an argumentless
			creation procedure may assume default values.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MISSING_CREATION_PROC_WITHOUT_ARGS_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_create_pre_action (agent process_create)
			a_checker.add_feature_clause_pre_action (agent process_feature_clause)
			a_checker.add_class_post_action (agent do_post_class_cleanup)
		end

feature -- Properties

	name: STRING = "no_default_creation_procedure"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.missing_creation_proc_without_args_title
		end

	id: STRING_32 = "CA012"
		-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.missing_creation_proc_without_args_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.missing_creation_proc_without_args_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_class_name then
				a_formatter.add (l_class_name)
			end
			a_formatter.add (ca_messages.missing_creation_proc_without_args_violation_2)
		end

feature {NONE} -- AST Visitor

	process_create (a_create: CREATE_AS)
			-- Stores the creation procedures of `a_create'.
		do
			has_creation_procedure_with_no_args := False
			creation_procedures := a_create.feature_list
		end

	do_post_class_cleanup (a_class: CLASS_AS)
		local
			l_viol: CA_RULE_VIOLATION
		do

			if attached creation_procedures and then not (creation_procedures.is_empty or has_creation_procedure_with_no_args) then
				create l_viol.make_with_rule (Current)
				if attached a_class.creators as l_list and then not l_list.is_empty then
					l_viol.set_location (l_list.first.start_location)
				else
					l_viol.set_location (a_class.start_location)
				end
				l_viol.long_description_info.extend (a_class.class_name.name_32)
				violations.extend (l_viol)

			end

			-- Set the creation procedures to Void. Prevents errors when
			-- the next class does not have any creation procedures.
			creation_procedures := Void
		end

	process_feature_clause (a_clause: FEATURE_CLAUSE_AS)
			-- Checks `a_clause' for features that are creation procedures.
		do
			if attached creation_procedures as ps then
				across ps as ic loop
					if
						attached a_clause.feature_with_name (ic.item.feature_name.name_id) as l_feature and then
						not attached l_feature.body.arguments
					then
						has_creation_procedure_with_no_args := True
					end
				end
			end
		end

feature {NONE} -- Attributes

	creation_procedures: EIFFEL_LIST [FEATURE_NAME]
			-- List of creation procedures of the current class.

	has_creation_procedure_with_no_args: BOOLEAN
			-- Does the current class have a creation procedure with no arguments?
end
