note
	description: "[
			RULE #85: Unneeded helper variable
	
			A variable that is assigned a value only
			once and is then used only once can be replaced with the expression
			that computes this value. This applies as long as the line where the
			expression is inserted will not have too many characters.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_HELPER_VARIABLE_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_access_id_as
		end

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 40
			severity := severity_hint
			initialize_preferences (a_pref_manager)

			create locals_usage.make (0)
			create suspected_variables.make
			create location.make (0)
		end

	initialize_preferences (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes preferences for this rule.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			max_line_length := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_line_length_threshold, default_max_line_length)
			max_line_length.set_default_value (default_max_line_length.out)
			max_line_length.set_validation_agent (agent is_integer_string_within_bounds (?, 30, 1000))
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)
			a_checker.add_eiffel_list_pre_action (agent pre_process_list)
			a_checker.add_access_id_pre_action (agent process_access_id)
		end

feature {NONE} -- Rule checking

	pre_process_feature (a_feature: FEATURE_AS)
			-- Resets the data structures.
		do
			locals_usage.wipe_out
			suspected_variables.wipe_out
			location.wipe_out
		end

	post_process_feature (a_feature: FEATURE_AS)
			-- Adds violations.
		local
			l_viol: CA_RULE_VIOLATION
		do
			across suspected_variables as l_suspects loop
				if locals_usage [l_suspects] = 2 then
						-- 2 usages: 1 assignment and 1 read.
					create l_viol.make_with_rule (Current)
					l_viol.set_location (location [l_suspects])
					l_viol.long_description_info.extend (l_suspects.name_32)
					violations.extend (l_viol)
				end
			end
		end

	pre_process_list (a_list: EIFFEL_LIST [AST_EIFFEL])
			-- Checks `a_list' for patterns that may be rule violations.
		local
			l_previous, l_current: INSTRUCTION_AS
		do
				-- Check if it is an instruction compound and not another kind
				-- of list such as a type declaration.
			if attached {EIFFEL_LIST [INSTRUCTION_AS]} a_list as l_instr and then l_instr.count >= 2 then
				from
					a_list.start
					l_current := l_instr.item
					a_list.forth
				until
					a_list.after
				loop
					l_previous := l_current
					l_current := l_instr.item
					if attached {ASSIGN_AS} l_previous as l_assign and then attached {ACCESS_ID_AS} l_assign.target as l_aid then
						if not attached {REVERSE_AS} l_assign  and then l_aid.is_local then
							analyze_reads (l_aid.feature_name, l_current)
							if is_read and then
									instruction_length (l_current) - l_aid.access_name_32.count + expression_length (l_assign) <= max_line_length.value then

									-- The line with the replaced variable is not too long.
								suspected_variables.extend (l_aid.feature_name)
								location.force (l_aid.start_location, l_aid.feature_name)
							end
						end
					elseif attached {CREATION_AS} l_previous as l_creation and then attached {ACCESS_ID_AS} l_creation.target as l_aid then
						if l_aid.is_local then
							analyze_reads (l_aid.feature_name, l_current)
							if is_read and then
									instruction_length (l_current) - l_aid.access_name_32.count + create_expression_length (l_creation) <= max_line_length.value then

									-- The line with the replaced variable is not too long.
								suspected_variables.extend (l_aid.feature_name)
								location.force (l_aid.start_location, l_aid.feature_name)
							end
						end
					end
					a_list.forth
				end
			end
		end

	is_read: BOOLEAN
			-- Is variable analyzed in `analyze_reads' read?

	analyze_reads (a_var: attached ID_AS; a_instr: attached INSTRUCTION_AS)
			-- Checks if variable `a_var' is used in instruction `a_instr'.
		do
			is_read := False
			var_found := False
			var_to_look_for := a_var
			a_instr.process (Current)
			is_read := var_found
		end

	var_to_look_for: detachable ID_AS
			-- Variable to look for in AST child nodes.

	var_found: BOOLEAN
			-- Has `var_to_look_for' been found in AST child nodes?

	process_access_id_as (a_access_id: ACCESS_ID_AS)
			-- Is used only by the feature `is_read' in order to determine if
			-- the variable from `a_access_id' is used in a certain instruction.
		do
			if a_access_id.feature_name.is_equal (var_to_look_for) then
				var_found := True
			end

				-- Very important! Other ACCESS_ID_AS may be reachable from this
				-- ACCESS_ID_AS in the AST.
			Precursor (a_access_id)
		end

	process_access_id (a_access_id: ACCESS_ID_AS)
			-- Updates usage information if `a_access_id' represents a local.
		local
			l_id: ID_AS
		do
			if a_access_id.is_local then
				l_id := a_access_id.feature_name
				if locals_usage.has_key (l_id) then
					locals_usage.force (locals_usage [l_id] + 1, l_id)
				else
					locals_usage.extend (1, l_id)
				end
			end
		end

	locals_usage: HASH_TABLE [INTEGER, ID_AS]
			-- Stores how many times a local variable is used.

	expression_length (a_assign: attached ASSIGN_AS): INTEGER
			-- How many characters long is the source expression of the
			-- assignment `a_assign'?
		local
			leaf_list: LEAF_AS_LIST
		do
			leaf_list := System.match_list_server.item (current_context.checking_class.class_id)
			Result := a_assign.source.last_token (leaf_list).final_position - a_assign.source.first_token (leaf_list).position + 1
		end

	create_expression_length (a_create: attached CREATION_AS): INTEGER
		local
			leaf_list: LEAF_AS_LIST
		do
			leaf_list := System.match_list_server.item (current_context.checking_class.class_id)
			Result := a_create.last_token (leaf_list).final_position - a_create.first_token (leaf_list).position + 1
		end

	instruction_length (a_instr: attached INSTRUCTION_AS): INTEGER
			-- How many characters long is `a_instr'?
		local
			leaf_list: LEAF_AS_LIST
		do
			leaf_list := System.match_list_server.item (current_context.checking_class.class_id)
			Result := a_instr.last_token (leaf_list).final_position - a_instr.first_token (leaf_list).position + 1
		end

	suspected_variables: LINKED_LIST [ID_AS]
			-- Variables that might violate this rule.

	location: HASH_TABLE [LOCATION_AS, ID_AS]
			-- Stores the location of a certain suspected variable.

feature {NONE} -- Preferences

	preference_option_name_line_length_threshold: STRING
			-- A name of a line length threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_line_length_threshold)
		end

	option_name_line_length_threshold: STRING = "maximum_line_length"
			-- A name of a line length threshold option.

	default_max_line_length: INTEGER = 80
			-- Default maximum number of characters a line may have.

	max_line_length: INTEGER_PREFERENCE
			-- Maximum number of characters a line may have.

feature -- Properties

	name: STRING = "single_use_variable"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.unneeded_helper_variable_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.unneeded_helper_variable_description
		end

	id: STRING_32 = "CA085"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.unneeded_helper_variable_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add (ca_messages.unneeded_helper_variable_violation_2)
		end

end
