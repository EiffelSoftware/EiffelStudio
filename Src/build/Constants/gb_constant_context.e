indexing
	description: "Objects that represent a context for a constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			object := Void
			constant := Void
		ensure
			is_destroyed: is_destroyed = True
			unreferenced: not (old constant).referers.has (Current) and
				not (old object).constants.has (property + attribute)
		end
		

invariant
	constant_not_void: not is_destroyed implies constant /= Void
	object_not_void: not is_destroyed implies object /= Void
	property_not_void: property /= Void and not property.is_empty
	attribute_not_void: attribute /= Void and not attribute.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_CONSTANT_CONTEXT
