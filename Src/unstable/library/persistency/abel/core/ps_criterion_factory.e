note
	description: "[
	Factory class to create criteria. Three kinds of criteria are possible:
	1. Predefined criteria, using tuples of values of type [STRING, STRING, ANY], 
	the first element representing an attribute name, the second representing predefined string operators
	(see class PREDEFINED_OPERATORS), and the third representing any value to be checked on the attribute.
	2.Agents criteria, in particular predicates used for selection.
	3. A combination of the previous two criteria can be composed with loical operators and represented in a uniform tuple notation.
	Example of a combination of criteria with the overloaded [] notation: 
	[[ "first_name", equals, "Paco" ]] and [[ agent age_more_than (?, 20) ]]
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_FACTORY

inherit

	PS_PREDEFINED_OPERATORS

create
	default_create

feature -- Creating a criterion

	create_uniform alias "[]" (tuple: TUPLE [ANY]): PS_CRITERION
			-- Creates an agent, a predefined criterion or a combination of both
			-- using an uniform notation. `tuple' containes either a single agent PREDICATE
			-- or three values of type [STRING, STRING, ANY].
			-- Using this notation criteria can be combined as shown in the example in the class header.
		require
			well_formed: is_agent (tuple) or is_predefined (tuple)
		do
			if is_agent (tuple) then
				check attached {PREDICATE [ANY, TUPLE [ANY]]} tuple [1] as predicate then
					Result := create_agent (predicate)
				end
			else
					-- is_predefined = True, otherwise there would be a contract violation
					-- however, we need to do all these checks again because of void safety-.-
				check attached {STRING} tuple [1] as attr and attached {STRING} tuple [2] as operator and attached tuple [3] as value then
					Result := create_predefined (attr, operator, value)
				end
			end
		end

	create_agent (a_predicate: PREDICATE [ANY, TUPLE [ANY]]): PS_CRITERION
			-- Creates a criterion with a predicate acting as a filter.
		do
			create {PS_AGENT_CRITERION} Result.make (a_predicate)
		end

	create_predefined (object_attribute_name: STRING; operator: STRING; value: ANY): PS_CRITERION
			-- Creates a predefined selection criterion given
			-- an object attribute name,
			-- an operator (see 'PS_PREDEFINED_OPERATORS'),
			-- and a value for the attribute.
		require
			correct_operator_and_value: is_valid_combination (operator, value)
		do
			create {PS_PREDEFINED_CRITERION} Result.make (object_attribute_name, operator, value)
		end

feature -- Preconditions

	is_agent (tuple: TUPLE [ANY]): BOOLEAN
			-- Does `tuple' correspond to the format for agents?
		do
			Result := attached {TUPLE [PREDICATE [ANY, TUPLE [ANY]]]} tuple
		end

	is_predefined (tuple: TUPLE [ANY]): BOOLEAN
			-- Does `tuple' correspond to the format for predefined tuples and have a valid operator/value combination?
		do
			if attached {TUPLE [STRING, STRING, ANY]} tuple and then (attached {STRING} tuple [2] as operator and attached tuple [3] as value) then
				Result := is_valid_combination (operator, value)
			else
				Result := false
			end
		end

end
