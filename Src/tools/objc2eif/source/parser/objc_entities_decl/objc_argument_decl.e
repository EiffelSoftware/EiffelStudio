note
	description: "An Objective-C argument declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_ARGUMENT_DECL

inherit
	OBJC_ENTITY_DECL

create
	make

feature {NONE} -- Initialization

	make (a_label: STRING)
			-- Initialize Current with `a_label'.
		require
			a_valid_label: not a_label.is_empty
		do
			label := a_label
		ensure
			label_set: label = a_label
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_argument_decl (Current)
		end

feature -- Setters

	set_type_and_argument_name (a_type: attached like type; an_argument_name: attached like argument_name)
			-- Set `type' and `argument_name' with `a_type' and `an_argument_name'.
		require
			a_valid_argument_name: not an_argument_name.is_empty
		do
			type := a_type
			argument_name := an_argument_name
		ensure
			type_set: type = a_type
			argument_name_set: argument_name = an_argument_name
		end

	set_dotdotdot (true_or_false: like is_dotdotdot)
			-- Set `dotdotdot' with `true_or_false'.
		do
			is_dotdotdot := true_or_false
		ensure
			is_dotdotdot_set: is_dotdotdot = true_or_false
		end

feature -- Access

	label: STRING
			-- The label string in the method declaration:
			-- - (return_type)label1:(type1)argument_name1 label2:(type2)argument_name;

	type: detachable OBJC_TYPE_DECL
			-- The type in the method declaration:
			-- - (return_type)label1:(type1)argument_name1 label2:(type2)argument_name;
			-- This attribute can be detached in case of method declarations of the following form:
			-- - (return_type)label;

	argument_name: detachable STRING
			-- The argument name string in the method declaration:
			-- - (return_type)label1:(type1)argument_name1 label2:(type2)argument_name;
			-- This attribute can be detached in case of method declarations of the following form:
			-- - (return_type)label;

	is_dotdotdot: BOOLEAN assign set_dotdotdot
			-- Whether this is a "..." argument

invariant

	valid_state: (type /= Void and argument_name /= Void) or (type = Void and argument_name = Void)

end
