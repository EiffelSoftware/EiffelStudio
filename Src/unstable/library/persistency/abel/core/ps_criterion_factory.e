note
	description: "[
		Factory class to create criteria. 
		
		Example usage:
			
			criterion_1 := factory.new_predefined ("first_name", factory.equals, "John")
			criterion_2 := factory.new_agent (agent last_name_equal (?, "Doe"))
		
		Combining criteria using logical operators:
		
			criterion_3 := criterion_1 and criterion_2
		
		Alternative parenthesis syntax:
		
			criterion_3 := factory ("first_name", factory.equals, "John")
							and factory (agent last_name_equal (?, "Doe"))
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

	new_uniform alias "[]" (tuple: TUPLE [ANY]): PS_CRITERION
			-- Creates an agent, a predefined criterion or a combination of both
			-- using an uniform notation. `tuple' contains either a single agent PREDICATE
			-- or three values of type [STRING, STRING, ANY], where the tuple values correspond
			-- to the arguments of the `new_predefined' routine.
		obsolete
			"Use new_criterion with parenthesis alias [2017-05-31]."
		require
			well_formed: is_agent (tuple) or is_predefined (tuple)
		do
			Result := new_criterion (tuple)
		end

	new_criterion alias "()" (tuple: TUPLE [ANY]): PS_CRITERION
			-- Creates an agent, a predefined criterion or a combination of both
			-- using an uniform notation. `tuple' contains either a single agent PREDICATE
			-- or three values of type [STRING, STRING, ANY], where the tuple values correspond
			-- to the arguments of the `new_predefined' routine.
			-- Using this notation criteria can be combined as shown in the example in the class header.
		require
			well_formed: is_agent (tuple) or is_predefined (tuple)
		do
			if attached {TUPLE [predicate: PREDICATE [detachable TUPLE]]} tuple as agent_tuple then
				Result := new_agent (agent_tuple.predicate)
			else
				check from_precondition: attached {TUPLE [attr: STRING; operator: STRING; value: ANY]} tuple as predefined_tuple then
					Result := new_predefined (predefined_tuple.attr, predefined_tuple.operator, predefined_tuple.value)
				end
			end
		end

	new_agent (a_predicate: PREDICATE [detachable TUPLE]): PS_CRITERION
			-- Creates a criterion with a predicate acting as a filter.
		do
			create {PS_AGENT_CRITERION} Result.make (a_predicate)
		end

	new_predefined (object_attribute_name: STRING; operator: STRING; value: ANY): PS_CRITERION
			-- Creates a predefined selection criterion given
			-- an `object_attribute_name' denoting the attribute name,
			-- an `operator' (see 'PS_PREDEFINED_OPERATORS'),
			-- and a `value' against which the attribute should be checked.
		require
			correct_operator_and_value: is_valid_combination (operator, value)
		do
			create {PS_PREDEFINED_CRITERION} Result.make (object_attribute_name, operator, value)
		end

feature -- Preconditions

	is_agent (tuple: TUPLE [ANY]): BOOLEAN
			-- Does `tuple' correspond to the format for agents?
		do
			Result := attached {TUPLE [PREDICATE [detachable TUPLE]]} tuple
		end

	is_predefined (tuple: TUPLE [ANY]): BOOLEAN
			-- Does `tuple' correspond to the format for predefined tuples and have a valid operator/value combination?
		do
			Result :=
				attached {TUPLE [attr: STRING; operator: STRING;  value: ANY]} tuple as tup
				and then is_valid_combination (tup.operator, tup.value)
		end

end
