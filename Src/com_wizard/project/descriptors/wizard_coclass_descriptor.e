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

	WIZARD_COCLASS_GENERATOR_HELPER
		export
			{NONE} all
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

			create feature_eiffel_names.make
			feature_eiffel_names.compare_objects

		ensure then
			non_void_interface_descriptors: interface_descriptors /= Void 
			non_void_feature_c_names: feature_c_names /= Void
		end

feature -- Access

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	source_interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Interfaces to call back on client implementations,
			-- not empty implies that coclass supports IConnectionPointConteiner.

	lcid: INTEGER
			-- Locale of member names and doc strings.

	default_dispinterface_name: STRING
			-- Name of default interface.

	default_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Descriptor of default interface.

	default_source_dispinterface_name: STRING
			-- Name of default source interface.

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values.

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

	feature_eiffel_names: LINKED_LIST [STRING]
			-- List of feature Eiffel names.

feature -- Element Change

	set_source_interface_descriptors (some_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]) is
			-- Set `source_interface_descriptors' with `some_descriptors'.
		require
			valid_descriptors: some_descriptors /= Void
		do
			source_interface_descriptors := some_descriptors
		ensure
			valid_descriptors: source_interface_descriptors /= Void and 
				source_interface_descriptors = some_descriptors
		end

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

	set_default_dispinterface (a_name: STRING) is
			-- Set `default_dispinterface_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			default_dispinterface_name := a_name
		ensure
			non_void_default_dispinterface: default_dispinterface_name /= Void
			valid_default_dispinterface: not default_dispinterface_name.empty and default_dispinterface_name.is_equal (a_name)
		end

	set_default_source_dispinterface_name (a_name: STRING) is
			-- Set `default_source_dispinterface_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			default_source_dispinterface_name := a_name
		ensure
			non_void_default_source_dispinterface: default_source_dispinterface_name /= Void
			valid_default_source_dispinterface: not default_source_dispinterface_name.empty and default_source_dispinterface_name.is_equal (a_name)
		end

	set_default_interface (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Set `default_interface_descriptor' with `a_interface'.
		require
			non_void_interface: a_interface /= Void
		do
			default_interface_descriptor := a_interface
		ensure
			non_void_default_interface: default_interface_descriptor /= Void
		end

	set_flags (some_flags: INTEGER) is
			-- Set `flags' with `some_flags'
		do
			flags := some_flags
		ensure
			valid_flags: flags = some_flags
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
				if not has_descendants_in_coclass (Current, interface_descriptors.item) then
					interface_descriptors.item.disambiguate_c_names (Current)
					feature_c_names.append (interface_descriptors.item.feature_c_names)
				end
				interface_descriptors.forth
			end

			from
				interface_descriptors.start
			until
				interface_descriptors.after
			loop
				if not has_descendants_in_coclass (Current, interface_descriptors.item) then
					from
						interface_descriptors.item.functions_start
					until
						interface_descriptors.item.functions_after
					loop

						if interface_descriptors.item.functions_item.argument_count > 0 then
							from
								interface_descriptors.item.functions_item.arguments.start
							until
								interface_descriptors.item.functions_item.arguments.after
							loop
								if feature_eiffel_names.has (interface_descriptors.item.functions_item.arguments.item.name) then
									interface_descriptors.item.functions_item.arguments.item.name.prepend ("a_")
								end
								interface_descriptors.item.functions_item.arguments.forth
							end
						end
						interface_descriptors.item.functions_forth
					end
				end
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

