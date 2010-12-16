note
	description: "An Objective-C class declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_CLASS_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_framework: STRING; a_header: STRING)
			-- Initialize Current with `a_name', `a_framework' and `a_header'.
		require
			a_valid_name: not a_name.is_empty
			a_valid_framework: not a_framework.is_empty
			a_valid_header: not a_header.is_empty
		do
			name := a_name
			framework := a_framework
			header := a_header
			create protocols.make (0)
			create methods.make (0)
			create categories.make (0)
			create properties.make (0)
		ensure
			name_set: name = a_name
			framework_set: framework = a_framework
			header_set: header = a_header
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_class_decl (Current)
		end

feature -- Setters

	set_parent_class (a_parent_class: like parent_class)
			-- Set `parent_class' with `a_parent_class'.
		require
			a_valid_parent_class: a_parent_class /= Current
		do
			parent_class := a_parent_class
		ensure
			parent_class_set: parent_class = a_parent_class
		end

feature -- Access

	name: STRING
			-- The name of Current.

	parent_class: detachable OBJC_CLASS_DECL
			-- Void for root classes (e.g. NSObject).

	protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			-- Table of protocol declarations indexed by the name.

	methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			-- Table of method declarations indexed by the name
			-- Note that these are not all the methods declared by this class.
			-- There might be additional ones in `categories', superclass or protocols.

	categories: HASH_TABLE [OBJC_CATEGORY_DECL, STRING]
			-- Table of category declarations indexed by the name.

	properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
			-- Table of property declarations indexed by the name.

	framework: STRING
			-- The framework this class declaration belongs to.

	header: STRING
			-- The name of the header file this class was declared in.

feature -- Queries

	instances_respond_to_selector (selector_name: STRING): BOOLEAN
			-- Do instances of this class respond to `selector_name'?
		do
			Result := attached methods.item (selector_name) as m and then not m.is_class_method
			if not Result then
				across categories as cursor loop
					if attached cursor.item.methods.item (selector_name) as m and then not m.is_class_method then
						Result := True
					end
				end
					-- Check Protocols
				if not Result then
					across protocols as cursor loop
						if cursor.item.instances_respond_to_selector (selector_name) then
							Result := True
						end
					end
				end
				if not Result and attached parent_class as attached_parent_class then
					Result := attached_parent_class.instances_respond_to_selector (selector_name)
				end
			end
		end

	responds_to_selector (selector_name: STRING): BOOLEAN
			-- Does this class respond to `selector_name'?
		do
			Result := attached methods.item (selector_name) as m and then m.is_class_method
			if not Result then
				across categories as cursor loop
					if attached cursor.item.methods.item (selector_name) as m and then m.is_class_method then
						Result := True
					end
				end
				if not Result then
					if attached parent_class as attached_parent_class then
						Result := attached_parent_class.responds_to_selector (selector_name)
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
