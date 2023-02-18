note
	description: "[
			RULE #17: Empty conditional instruction branch
	
			An empty branch of conditional instruction is useless and should be removed.
			
			The check applies to any branch that has no following parts, or the only following part is Else_part.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_IF_RULE

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

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_if_pre_action (agent process_if)
		end

feature -- Properties

	name: STRING = "empty_conditional"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.empty_if_title
		end

	id: STRING_32 = "CA017"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.empty_if_description
		end

	format_violation_description (v: CA_RULE_VIOLATION; f: TEXT_FORMATTER)
			-- Ignore the old-style output.
		do
		end

feature {NONE} -- Rule Checking

	process_if (a: IF_AS)
			-- Check if Then_part or Elseif_part of `a` has an empty compound and there is no Elseif_part chained.
		do
			if
				not attached a.compound and then
				(attached a.elsif_list as es implies across es as e all not attached e.compound end) and then
				(a.else_keyword_index > 0 implies not attached a.else_part)
			then
					-- All parts of the conditional instruction are empty, it can be removed completely.
				put_violation
					(ca_messages.locale.translation_in_context ("All parts of conditional instruction are empty.", once "code_analyzer.violation"), <<>>,
					ca_messages.empty_if_violation_if, <<>>,
					a.then_keyword_index)
			else
				if not attached a.compound and then not attached a.elsif_list then
					put_violation
						(ca_messages.locale.translation_in_context ("Empty compound after {1} part of {2}.", once "code_analyzer.violation"),
						<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_then_keyword, Void),
							agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_if_keyword, Void)>>,
						ca_messages.empty_if_violation_if_else, <<>>,
						a.then_keyword_index)
				end
				if attached a.elsif_list as e and then not attached e.last.compound then
					put_violation
						(ca_messages.locale.translation_in_context ("Empty compound after {1} part of {2}.", once "code_analyzer.violation"),
						<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_then_keyword, Void),
							agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_elseif_keyword, Void)>>,
						if attached a.else_part as else_part and then not else_part.is_empty then
							ca_messages.empty_if_violation_if_else
						else
							ca_messages.empty_if_violation_elseif
						end,
						<<>>,
						e.last.then_keyword_index)
				end
				if a.else_keyword_index > 0 and then not attached a.else_part then
					put_violation
						(ca_messages.locale.translation_in_context ("Empty compound after {1} part.", once "code_analyzer.violation"),
						<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_else_keyword, Void)>>,
						ca_messages.empty_if_violation_else,
						<<>>,
						a.else_keyword_index)
				end
			end
		end

end
