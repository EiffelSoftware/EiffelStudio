indexing
	description: "Objects that represent a context for a constant"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONSTANT_CONTEXT
	
inherit
	ANY
		redefine
			is_equal
		end
	
create
	make_with_context
	
feature {NONE} -- Initialization

	make_with_context (a_constant: GB_CONSTANT; an_object: GB_OBJECT; a_property, an_attribute: STRING) is
			-- Build `Current; to reflect the arguments.
		require
			constant_not_void: a_constant /= Void
			an_object_not_void: an_object /= Void
			property_valid: a_property /= Void and then not a_property.is_empty
			attribute_valid: an_attribute /= Void and then not an_attribute.is_empty
		do
			modify (a_constant, an_object, a_property, an_attribute)
		end
		
feature -- Status_setting

	modify (a_constant: GB_CONSTANT; an_object: GB_OBJECT; a_property, an_attribute: STRING) is
			-- Modify `Current' to reflect arguments.
		require
			not_destroyed: not is_destroyed
			constant_not_void: a_constant /= Void
			an_object_not_void: an_object /= Void
			property_valid: a_property /= Void and then not a_property.is_empty
			attribute_valid: an_attribute /= Void and then not an_attribute.is_empty
		do
			constant := a_constant
			object := an_object
			property := a_property.twin
			attribute := an_attribute.twin
		end

feature -- Access

	constant: GB_CONSTANT
		-- Constant represented by `Current'

	object: GB_OBJECT
		-- Object in which `constant' is used.
		
	property: STRING
		-- Name of property class referencing `constant'.
		
	attribute: STRING
		-- Name of attribute class referencing `constant'.
		
feature -- Measurement

	is_equal (other: GB_CONSTANT_CONTEXT): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		require else
			not_destroyed: not is_destroyed
			other_not_void: other /= Void
		do
			if constant = other.constant and
				object = other.object and
				property.is_equal (other.property) and
				attribute.is_equal (other.property) then
				Result := True
			end
		end
		
	is_destroyed: BOOLEAN
		-- Has `Current' been destroyed?
		
feature -- Destruction

	destroy is
			-- Destroy `Current' and unreference.
		require
			not_destroyed: not is_destroyed
			constant_not_void: constant /= Void
			object_not_void: object /= Void
			property_not_void: property /= Void
			attribute_not_void: attribute /= Void
			valid_context: object.constants.item (property + attribute) = Current
		do
			is_destroyed := True
			constant.remove_referer (Current)
			object.constants.remove (property + attribute)
		ensure
			is_destroyed: is_destroyed = True
			unreferenced: not constant.referers.has (Current) and
				not object.constants.has (property + attribute)
		end
		

invariant
	constant_not_void: constant /= Void
	object_not_void: object /= Void
	property_not_void: property /= Void and not property.is_empty
	attribute_not_void: attribute /= Void and not attribute.is_empty

end -- class GB_CONSTANT_CONTEXT
