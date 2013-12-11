note
	description: "A visitor to print a composite criterion."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_PRINTER

inherit
	PS_CRITERION_VISITOR [STRING]

feature
	visit_and (and_crit: PS_AND_CRITERION): STRING
		do
			Result := "(" + visit (and_crit.left) + " and " + visit (and_crit.right) + ")"
		end

	visit_or (or_crit: PS_OR_CRITERION): STRING
		local
			left, right: STRING
		do
			Result := "(" + visit (or_crit.left) + " or " + visit (or_crit.right) + ")"
		end

	visit_not (not_crit: PS_NOT_CRITERION): STRING
		do
			Result := " not " + visit (not_crit.child)
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): STRING
		local
			attribute_key: INTEGER
			value: STRING
		do
			Result := "PREDEFINED: ("+ predef_crit.attribute_name + " " + predef_crit.operator + " " + predef_crit.value.out + ")"
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): STRING
		do
			Result := " AGENT "
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): STRING
		do
			Result := " EMPTY "
		end
end
