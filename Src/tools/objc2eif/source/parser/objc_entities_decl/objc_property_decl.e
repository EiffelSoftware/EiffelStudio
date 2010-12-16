note
	description: "An Objective-C property declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_PROPERTY_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_type: OBJC_TYPE_DECL)
			-- Initialize Current with `a_name' and `a_type'.
		require
			a_valid_name: not a_name.is_empty
		do
			name := a_name
			type := a_type
		ensure
			name_set: name = a_name
			type_set: type = a_type
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_property_decl (Current)
		end

feature -- Setters

	set_getter (a_getter: like getter)
			-- Set `getter' with `a_getter'.
		require
			a_valid_getter: not a_getter.is_empty
		do
			internal_getter := a_getter
		end

	set_setter (a_setter: like setter)
			-- Set `setter' with `a_setter'.
		require
			a_valid_setter: not a_setter.is_empty
		do
			internal_setter := a_setter
		end

	set_readonly (true_or_false: like readonly)
			-- Set `readonly' with `true_or_false'.
		do
			readonly := true_or_false
		ensure
			readonly_set: readonly = true_or_false
		end

	set_type (a_type: OBJC_TYPE_DECL)
			-- Set `type' with `a_type'.
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- The name of Current.

	type: OBJC_TYPE_DECL assign set_type
			-- The type of Current.

	getter: STRING assign set_getter
			-- Selector name of the getter.
		do
			if attached internal_getter as attached_internal_getter then
				Result := attached_internal_getter
			else
				Result := name
			end
		end

	setter: STRING assign set_setter
			-- Selector name of the setter.
		local
			temp: STRING
		do
			if attached internal_setter as attached_internal_setter then
				Result := attached_internal_setter
			else
				create temp.make_from_string (name)
				Result := name.twin
				Result.remove_head (1)
				Result := "set" + temp.item (1).as_upper.out + Result + ":"
			end
		end

	readonly: BOOLEAN assign set_readonly
			-- Can the the property represented by Current only be read?

feature {NONE} -- Implementation

	internal_getter: detachable like getter
			-- Internal storage for the getter.

	internal_setter: detachable like setter
			-- Internal storage for the setter.

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
