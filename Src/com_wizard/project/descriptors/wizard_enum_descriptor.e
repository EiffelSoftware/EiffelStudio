indexing
	description: "Enumeration descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR

	EXCEPTIONS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ENUM_DESCRIPTOR_CREATOR) is
			-- Initialize `elements'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_elements: elements /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

feature -- Access

	elements: LINKED_LIST[WIZARD_ENUM_ELEMENT_DESCRIPTOR]
			-- list of element descriptors

	creation_message: STRING is
			-- Creation message for wizard output
		do
			Result := clone (Added)
			Result.append (Space)
			Result.append (Enumerator)
			Result.append (Space)
			Result.append (name)
			Result.append (New_line_tab)
			Result.append (Elements_string)
			from
				elements.start
			until
				elements.after
			loop
				Result.append (New_line_tab)
				Result.append (elements.item.name)
				Result.append (Colon)
				Result.append (Space)
				Result.append (elements.item.value.out)
				Result.append (New_line_tab_tab)
				Result.append (elements.item.description)
				elements.forth
			end
		end

	is_added: BOOLEAN
			-- Is descriptor added to list of enumerators?

feature -- Basic Operations

	set_added is
			-- Set `added' to `True'.
		do
			is_added := True
		ensure
			added: is_added
		end

	set_elements (some_elements: LINKED_LIST[WIZARD_ENUM_ELEMENT_DESCRIPTOR]) is
			--
		require
			valid_elements: some_elements /= Void
		do
			elements := some_elements
		ensure
			valid_elements: elements /= Void and elements = some_elements
		end
 

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_enum (Current)
		end

end -- WIZARD_ENUM_DESCRIPTOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

