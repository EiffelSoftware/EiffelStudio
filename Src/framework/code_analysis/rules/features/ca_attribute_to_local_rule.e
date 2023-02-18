note
	description: "[
			RULE #54: Attribute is only used inside a single routine
	
			An attribute that is only used inside a
			single routine of the class where it is defined (and that is not read
			by any other class) can be transformed into a local variable.
		]"
	author: "Stefan Zurfluh, Eiffel Software"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ATTRIBUTE_TO_LOCAL_RULE

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
			a_checker.add_class_pre_action (agent process_class)
		end

feature {NONE} -- Rule checking

	process_class (a_class: CLASS_AS)
			-- Iterates through all the attributes of `a_class' and looks at its
			-- callers.
		local
			l_clients: ARRAYED_LIST [CLASS_C]
			l_has_clients: BOOLEAN
		do
			l_clients := current_context.checking_class.clients

			across
				current_context.checking_class.written_in_features as l_feat
			loop

					-- Only look at attributes.
				if l_feat.is_attribute then
					from
						l_has_clients := False
						l_clients.start
					until
						l_has_clients or l_clients.after
					loop
							-- Only look at external clients.
						if
							l_clients.item.name.is_equal (current_context.checking_class.name)
								-- `callers_32' retrieves not only callers but also assigners and creators.
							and then l_feat.callers_32 (l_clients.item, 0) /= Void
						then
							l_has_clients := True
						end

						l_clients.forth
					end

					if
						not l_has_clients
						and then l_clients.has (current_context.checking_class)
						and then attached l_feat.callers_32 (current_context.checking_class, 0) as l_c
						and then l_c.count = 1
					then
						create_violation (l_feat, l_c.first)
					end
				end
			end
		end

	create_violation (a_attribute: attached E_FEATURE; a_used_in: attached STRING_32)
		local
			l_violation: CA_RULE_VIOLATION
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_attribute.ast.start_location)
			l_violation.long_description_info.extend (a_attribute.name_32)
			l_violation.long_description_info.extend (a_used_in)
			violations.extend (l_violation)
		end

feature -- Properties

	name: STRING = "attribute_in_single_feature"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.attribute_to_local_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.attribute_to_local_description
		end

	id: STRING_32 = "CA054"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		local
			l_info: LINKED_LIST [ANY]
		do
			l_info := a_violation.long_description_info

			a_formatter.add (ca_messages.attribute_to_local_violation_1)
			if attached {READABLE_STRING_GENERAL} l_info.first as l_attribute then
				a_formatter.add_feature_name (l_attribute, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.attribute_to_local_violation_2)
			if attached {READABLE_STRING_GENERAL} l_info.at (2) as l_used_in then
				a_formatter.add_feature_name (l_used_in, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.attribute_to_local_violation_3)
		end

end
