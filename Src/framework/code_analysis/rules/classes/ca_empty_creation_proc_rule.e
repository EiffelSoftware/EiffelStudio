note
	description: "[
			RULE #38: Empty argumentless creation procedure can be removed
	
			If there exists only one creation procedure in a class and this procedure
			takes no arguments and has an empty body then the creation procedure should
			be considered to be removed. Note that in this case all the clients of the
			class need to call 'create c' instead of 'create c.make', where 'c' is an
			object of the relevant class and 'make' is its creation procedure.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_CREATION_PROC_RULE

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

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_create_pre_action (agent process_create)
			a_checker.add_feature_clause_pre_action (agent process_feature_clause)
			a_checker.add_class_post_action (agent do_post_class_cleanup)
		end

feature -- Properties

	name: STRING = "empty_creation_procedure"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.empty_creation_procedure_title
		end

	id: STRING_32 = "CA038"
		-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.empty_creation_procedure_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.empty_creation_procedure_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.at(2) as l_class_name then
				a_formatter.add (l_class_name)
			end
			a_formatter.add (ca_messages.empty_creation_procedure_violation_2)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add (l_feature_name)
			end
			a_formatter.add (ca_messages.empty_creation_procedure_violation_3)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.at(2) as l_class_name then
				a_formatter.add (l_class_name)
			end
			a_formatter.add (ca_messages.empty_creation_procedure_violation_4)
		end

feature {NONE} -- AST Visitor

	process_create (a_create: CREATE_AS)
			-- Stores the creation procedures of `a_create'.
		do
			creation_procedures := a_create.feature_list
		end

	do_post_class_cleanup (a_class: CLASS_AS)
		do
			-- Set the creation procedures to Void. Prevents errors when
			-- the next class does not have any creation procedures.
			creation_procedures := Void
		end

	process_feature_clause (a_clause: FEATURE_CLAUSE_AS)
			-- Checks `a_clause' for features that are creation procedures.
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_EMPTY_CREATION_PROC_FIX
		do
			if attached creation_procedures as ps then
				across ps as p loop
					if
						attached a_clause.feature_with_name(p.feature_name.name_id) as l_feature and then
						l_feature.body.is_empty
					then
						create l_violation.make_with_rule (Current)
						l_violation.long_description_info.extend (p.visual_name_32)
						l_violation.set_location (l_feature.start_location)

						l_violation.long_description_info.extend (current_context.checking_class.original_class.name)


						create l_fix.make_with_create_proc (current_context.checking_class, l_feature)
						l_violation.fixes.extend (l_fix)

						violations.extend (l_violation)
					end
				end
			end
		end

feature {NONE} -- Attributes

	creation_procedures: EIFFEL_LIST [FEATURE_NAME]
			-- List of creation procedures of the current class.

end
