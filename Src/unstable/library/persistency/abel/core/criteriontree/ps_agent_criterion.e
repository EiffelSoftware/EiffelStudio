note
	description: "A criterion that will filter the objects based on a PREDICATE agent."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AGENT_CRITERION

inherit

	PS_CRITERION

create
	make

feature -- Access

	agent_criterion: PREDICATE [detachable TUPLE]
			-- The agent representing the current criterion.

feature -- Check

	is_satisfied_by (retrieved_obj: ANY): BOOLEAN
			-- Does `retrieved_obj' satisfy the criteria in Current?
		local
			reflection: INTERNAL
			a_tuple: TUPLE [ANY]
			temp: ANY
			s: STRING
		do
			create reflection
			create a_tuple.default_create
			create s.make_from_string ("detachable TUPLE [!" + retrieved_obj.generator + "]")
			-- Dynamic creation of a TUPLE containing objects of the type of retrieved_obj
			temp := reflection.new_instance_of (reflection.dynamic_type_from_string (s))
			if attached {TUPLE [ANY]} temp as l then
				-- Set retrieved_object in the newly created TUPLE
				l.put_reference (retrieved_obj, 1)
				a_tuple := l
			end
			-- I had to use the code above to be able to obtain a TUPLE [X], where X is the type of retrieved_obj.
			-- Otherwise the execution of Result := agent_criterion.item ([retrieved_obj]) fails because of the argument with
			-- the message: "expected TUPLE [!X] but got TUPLE [!ANY]"
			Result := agent_criterion.item (a_tuple)
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		do
			Result := agent_criterion.valid_operands ([an_object])
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN = True
			-- Is there an agent criterion in the criterion tree?

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- Call visit_agent on `a_visitor'
		do
			Result := a_visitor.visit_agent (Current)
		end

feature {NONE} -- Initialization

	make (a_predicate: PREDICATE [detachable TUPLE])
			-- Initialize `Current' with `a_predicate'
		do
			agent_criterion := a_predicate
		ensure
			agent_criterion_set: agent_criterion = a_predicate
		end

end
