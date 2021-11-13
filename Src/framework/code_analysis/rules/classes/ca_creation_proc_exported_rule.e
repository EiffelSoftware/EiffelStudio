note
	description: "[
			RULE #13: Creation procedure is exported and may be called after object creation
	
			If the creation procedure is exported then
			it may still be called by clients after the object has been created.
			Ususally, this is not intended and ought to be changed. A client might,
			for example, by accident call 'x.make' instead of 'create x.make',
			causing the class invariant or postconditions of make not to hold anymore.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CREATION_PROC_EXPORTED_RULE

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

	name: STRING = "exported_creation_procedure"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.creation_proc_exported_title
		end

	id: STRING_32 = "CA013"
		-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.creation_proc_exported_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.creation_proc_exported_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.creation_proc_exported_violation_2)
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
				-- the next class does not have any create clause.
			creation_procedures := Void
		end

	process_feature_clause (a_clause: FEATURE_CLAUSE_AS)
			-- Checks `a_clause' for features that are creation procedures.
		local
			l_feature: FEATURE_AS
			l_exported: BOOLEAN
			l_viol: CA_RULE_VIOLATION
		do
			if creation_procedures /= Void then
				across creation_procedures as ic loop
					l_feature := a_clause.feature_with_name (ic.item.feature_name.name_id)
					if l_feature /= Void then
						if attached a_clause.clients as l_clients then
							across l_clients.clients as l_class_list loop
								if not l_class_list.item.name_32.is_equal ("NONE") then
										-- The feature is exported to something.
									l_exported := True
								end
							end
						else
								-- No clients are defined. It means that the feature is exported to {ANY}.
							l_exported := True
						end

						if l_exported then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (a_clause.start_location)
							l_viol.long_description_info.extend (l_feature.feature_name.name_32)
							violations.extend (l_viol)
						end
					end
				end
			end
		end

	creation_procedures: EIFFEL_LIST [FEATURE_NAME]
			-- List of creation procedures of the current class.

end
