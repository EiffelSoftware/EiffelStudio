note
	description: "An Objective-C method declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_METHOD_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make(a_is_class_method: BOOLEAN; a_return_type: OBJC_TYPE_DECL; a_arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL])
			-- Initialize Current with `a_is_class_method', `a_return_type' and `a_arguments'.
		require
			valid_arguments: not a_arguments.is_empty
		local
			current_argument: OBJC_ARGUMENT_DECL
		do
			is_class_method := a_is_class_method
			return_type := a_return_type
			arguments := a_arguments

			from
				create selector_name.make_empty
				arguments.start
			until
				arguments.after
			loop
				current_argument := arguments.item
				selector_name.append (current_argument.label)
				if attached current_argument.argument_name then
					selector_name.append (":")
				end
				arguments.forth
			end
		ensure
			is_class_method_set: is_class_method = a_is_class_method
			return_type_set: return_type = a_return_type
			arguments_set: arguments = a_arguments
			selector_name_set: not selector_name.is_empty
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_method_decl (Current)
		end

feature -- Setters

	set_return_type (a_return_type: like return_type)
			-- Set `return_type' with `a_return_type'.
		do
			return_type := a_return_type
		ensure
			return_type_set: return_type = a_return_type
		end

feature -- Access

	is_class_method: BOOLEAN
			-- Does the method declaration start with "+"?

	return_type: OBJC_TYPE_DECL assign set_return_type
			-- The return type of this method.

	arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			-- The arguments of this method.

	selector_name: STRING
			-- The selector name. Example:
			-- beginSheet:modalForWindow:modalDelegate:didEndSelector:contextInfo:

	type_encoding: STRING
			-- Return the type encoding of this method.
		do
			create Result.make_empty
			check attached return_type.encoding as attached_encoding then
				Result.append (attached_encoding)
			end
			Result.append ("@:")
			across arguments as cursor loop
				if attached cursor.item.type as attached_type then
					check attached attached_type.encoding as attached_encoding then
						Result.append (attached_encoding)
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
