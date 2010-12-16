note
	description: "A visitor that returns the debug string for the Objective-C entity declaration it visits."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_DEBUG_VISITOR

inherit
	OBJC_ENTITY_DECL_VISITOR
		redefine
			visit_category_decl,
			visit_class_decl,
			visit_method_decl,
			visit_property_decl,
			visit_protocol_decl,
			visit_protocol_method_decl
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current
		do
			last_result := ""
		end

feature -- Access

	last_result: STRING
			-- The result of the last visit by Current.

feature -- Operations

	visit_category_decl (c: OBJC_CATEGORY_DECL)
			-- Visit a category declaration.
		local
			protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
		do
			last_result := "@interface " + c.base_class.name + " (" + c.name + ")"
				-- Output protocols defined in this category.
			protocols := c.protocols
			if protocols.count > 0 then
				last_result.append (" <")
				from
					protocols.start
				until
					protocols.after
				loop
					last_result.append (protocols.item_for_iteration.name + ", ")
					protocols.forth
				end
				last_result.remove_tail (2)
				last_result.append (">")
			end
			last_result.append ("%N%T/* Framework: " + c.framework)
			last_result.append ("%N%T * Header File: " + c.header + " */%N%N")
				-- Output methods.
			methods := c.methods
			from
				methods.start
			until
				methods.after
			loop
				last_result.append (methods.item_for_iteration.debug_output + "%N")
				methods.forth
			end
				-- Output properties.
			properties := c.properties
			if not properties.is_empty then
				last_result.append ("%N")
			end
			from
				properties.start
			until
				properties.after
			loop
				last_result.append (properties.item_for_iteration.debug_output + "%N")
				properties.forth
			end
			last_result.append ("@end%N")
		ensure then
			last_result_not_empty: not last_result.is_empty
		end

	visit_class_decl (c: OBJC_CLASS_DECL)
			-- Visit a class declaration.
		local
			protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
			categories: HASH_TABLE [OBJC_CATEGORY_DECL, STRING]
		do
			last_result := "@interface " + c.name
			if attached c.parent_class as attached_parent_class then
				last_result.append (" : " + attached_parent_class.name)
			end
			protocols := c.protocols
			if protocols.count > 0 then
				last_result.append (" <")
				from
					protocols.start
				until
					protocols.after
				loop
					last_result.append (protocols.item_for_iteration.name + ", ")
					protocols.forth
				end
					-- Remove the last separator string.
				last_result.remove_tail (2)
				last_result.append (">")
			end
			last_result.append ("%N%T/* Framework: " + c.framework)
			last_result.append ("%N%T * Header File: " + c.header + " */%N%N")
				-- Output methods.
			methods := c.methods
			from
				methods.start
			until
				methods.after
			loop
				last_result.append (methods.item_for_iteration.debug_output + "%N")
				methods.forth
			end
				-- Output properties.
			properties := c.properties
			if not properties.is_empty then
				last_result.append ("%N")
			end
			from
				properties.start
			until
				properties.after
			loop
				last_result.append (properties.item_for_iteration.debug_output + "%N")
				properties.forth
			end
			last_result.append ("@end%N")
				-- Output categories.
			categories := c.categories
			from
				categories.start
			until
				categories.after
			loop
				last_result.append (categories.item_for_iteration.debug_output)
				categories.forth
			end
		ensure then
			last_result_not_empty: not last_result.is_empty
		end

	visit_method_decl (m: OBJC_METHOD_DECL)
			-- Visit a method declaration.
		local
			arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			current_argument: OBJC_ARGUMENT_DECL
		do
			create last_result.make_empty
				-- Output type encodings.
			if attached m.return_type.encoding as encoding then
				last_result := "%T// Type encodings: (" + encoding + ")("
			else
				check return_type_encoding_attached: False end
			end
			arguments := m.arguments
			from
				arguments.start
			until
				arguments.after
			loop
				current_argument := arguments.item
				if attached current_argument.type as type and then attached type.encoding as encoding then
					last_result.append (encoding + ",")
				end
				arguments.forth
			end
			if attached arguments.i_th (1).type then
				last_result.remove_tail (1)
			end
			last_result.append (")%N")
				-- Output method declaration.
			last_result.append ("%T")
			if m.is_class_method then
				last_result.append ("+")
			else
				last_result.append ("-")
			end
			last_result.append (" (" + m.return_type.name + ")")
			from
				arguments.start
			until
				arguments.after
			loop
				current_argument := arguments.item
				last_result.append (current_argument.label)
				if attached current_argument.type as type and attached current_argument.argument_name as argument_name then
					last_result.append (":(" + type.name + ")" + argument_name)
				end
				arguments.forth
				if not arguments.after then
					last_result.append (" ")
				end
			end
			last_result.append (";")
		ensure then
			last_result_not_empty: not last_result.is_empty
		end

	visit_property_decl (p: OBJC_PROPERTY_DECL)
			-- Visit a property declaration.
		do
			last_result := "%T@property (getter=" + p.getter + ", setter=" + p.setter
			if p.readonly then
				last_result.append (", readonly")
			else
				last_result.append (", readwrite")
			end
			last_result.append (") " + p.type.name + " " + p.name + ";")
		ensure then
			last_result_not_empty: not last_result.is_empty
		end

	visit_protocol_decl (p: OBJC_PROTOCOL_DECL)
			-- Visit a protocol declaration.
		local
			parent_protocols: HASH_TABLE[OBJC_PROTOCOL_DECL, STRING]
			methods: HASH_TABLE[OBJC_PROTOCOL_METHOD_DECL, STRING]
			properties: HASH_TABLE[OBJC_PROPERTY_DECL, STRING]
		do
			create last_result.make_empty
			last_result.append ("@protocol " + p.name)
			parent_protocols := p.parent_protocols
			if parent_protocols.count > 0 then
				last_result.append (" <")
				from
					parent_protocols.start
				until
					parent_protocols.after
				loop
					last_result.append (parent_protocols.item_for_iteration.name + ", ")
					parent_protocols.forth
				end
					-- Remove the last separator string.
				last_result.remove_tail (2)
				last_result.append (">")
			end
			last_result.append ("%N")
				-- Output methods.
			methods := p.methods
			from
				methods.start
			until
				methods.after
			loop
				last_result.append (methods.item_for_iteration.debug_output + "%N")
				methods.forth
			end
				-- Output properties.
			properties := p.properties
			if not properties.is_empty then
				last_result.append ("%N")
			end
			from
				properties.start
			until
				properties.after
			loop
				last_result.append (properties.item_for_iteration.debug_output + "%N")
				properties.forth
			end
			last_result.append ("@end" + "%N")

		end

	visit_protocol_method_decl (m: OBJC_PROTOCOL_METHOD_DECL)
			-- Visit a protocol method declaration.
		local
			visitor: OBJC_DEBUG_VISITOR
		do
			create visitor.make
			visitor.visit_method_decl (m)
			last_result := visitor.last_result
		ensure then
			last_result_not_empty: not last_result.is_empty
		end

end
