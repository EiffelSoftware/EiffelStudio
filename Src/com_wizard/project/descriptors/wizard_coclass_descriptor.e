indexing
	description: "Coclass descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_DESCRIPTOR

inherit
	WIZARD_COMPONENT_DESCRIPTOR
		redefine
			creation_message
		end

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_COCLASS_DESCRIPTOR_CREATOR) is
			-- Initialize descriptor
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			create feature_c_names.make
			feature_c_names.compare_objects
		ensure then
			non_void_interface_descriptors: interface_descriptors /= Void 
			non_void_feature_c_names: feature_c_names /= Void
		end

feature -- Access

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	lcid: INTEGER
			-- Locale of member names and doc strings.

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	creation_message: STRING is
			-- Creation message for wizard output
		do
			Result := clone (Added)
			Result.append (Space)
			Result.append (Coclass)
			Result.append (Space)
			Result.append (Name)
		end
	
	feature_c_names: LINKED_LIST [STRING]
			-- List of feature C names
		
feature -- Element Change

	set_interface_descriptors (some_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]) is
			-- Set `interface_descriptors' with `some_descriptors'.
		require
			valid_descriptors: some_descriptors /= Void
		do
			interface_descriptors := some_descriptors
		ensure
			valid_descriptors: interface_descriptors /= Void and 
				interface_descriptors = some_descriptors
		end

	set_lcid (a_lcid: INTEGER) is
			-- Set `lcid' with `a_lcid'.
		do
			lcid := a_lcid
		ensure
			valid_lcid: lcid = a_lcid
		end

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

feature -- Basic operations

	disambiguate_feature_names is
			-- Disambiguate name clashes.
		do
			from
				interface_descriptors.start
			until
				interface_descriptors.after
			loop
				interface_descriptors.item.disambiguate_c_names (Current)
				feature_c_names.append (interface_descriptors.item.feature_c_names)
				interface_descriptors.forth
			end
		end

feature {WIZARD_TYPE_INFO_VISITOR} -- Visitor

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_coclass (Current)
		end

end -- class WIZARD_DESCRIPTOR

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

