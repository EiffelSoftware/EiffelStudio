note
	description: "An Objective-C protocol declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_PROTOCOL_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialize Current with `a_name'.
		require
			valid_name: not a_name.is_empty
		do
			name := a_name
			create parent_protocols.make (0)
			create methods.make (0)
			create properties.make (0)
			framework := ""
		ensure
			name_set: name = a_name
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_protocol_decl (Current)
		end

feature -- Setters

	set_forward_reference (true_or_false: like is_forward_reference)
			-- Set `is_forward_reference' with 'true_or_false'.
		do
			is_forward_reference := true_or_false
		ensure
			forward_reference_set: is_forward_reference = true_or_false
		end

	set_framework (a_framework: like framework)
			-- Set `framework' with `a_framework'
		do
			framework := a_framework
		ensure
			framework_set: framework = a_framework
		end

feature -- Access

	name: STRING
			-- The name of Current.

	parent_protocols: HASH_TABLE[OBJC_PROTOCOL_DECL, STRING]
			-- Objective-C protocol declarations indexed by name.

	methods: HASH_TABLE[OBJC_PROTOCOL_METHOD_DECL, STRING]
			-- Objective-C methods declarations indexed by name.

	properties: HASH_TABLE[OBJC_PROPERTY_DECL, STRING]
			-- Objective-C properties declarations indexed by name.
			-- Not supported/parsed yet.

	is_forward_reference: BOOLEAN
			-- Is Current a protocol forward reference?
			-- Only used for parsing.

	framework: STRING assign set_framework
			-- The framework this protocol was declared in.

feature -- Queries

	instances_respond_to_selector (selector_name: STRING): BOOLEAN
			-- Do instances of this class respond to `selector_name'?
		do
			Result := attached methods.item (selector_name) as m and then not m.is_class_method
			if not Result then
				across parent_protocols as cursor loop
					if cursor.item.instances_respond_to_selector (selector_name) then
						Result := True
					end
				end
			end
		end

feature -- Debug

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			visitor: OBJC_DEBUG_VISITOR
		do
			create visitor.make
			accept (visitor)
			Result := visitor.last_result
		end

end
