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
			is_equal,
			creation_message
		end

	WIZARD_UNIQUE_IDENTIFIER_FACTORY
		export
			{NONE} all
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_COCLASS_DESCRIPTOR_CREATOR) is
			-- Initialize descriptor
		require
			valid_creator: a_creator /= Void
		do
			create feature_c_names.make (20)
			feature_c_names.compare_objects
			create feature_eiffel_names.make (20)
			a_creator.initialize_descriptor (Current)
		ensure then
			non_void_interface_descriptors: interface_descriptors /= Void
			non_void_feature_c_names: feature_c_names /= Void
			valid_feature_c_names: feature_c_names.object_comparison
			non_void_feature_eiffel_names: feature_eiffel_names /= Void
		end

feature -- Access

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	source_interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Interfaces to call back on client implementations,
			-- not is_empty implies that coclass supports IConnectionPointConteiner.

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
			create Result.make (14 + name.count)
			Result.append ("Added coclass ")
			Result.append (name)
		end
	
	feature_c_names: ARRAYED_LIST [STRING]
			-- List of feature C names

	feature_eiffel_names: HASH_TABLE [WIZARD_INTERFACE_DESCRIPTOR, STRING]
			-- Table of feature Eiffel names indexed by interface

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

	set_interface_descriptors (a_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]) is
			-- Set `interface_descriptors' with `some_descriptors'.
		require
			valid_descriptors: a_descriptors /= Void
		do
			interface_descriptors := a_descriptors
			from
				a_descriptors.start
			until
				a_descriptors.after
			loop
				a_descriptors.item.add_implementing_coclass (Current)
				a_descriptors.forth
			end
		ensure
			valid_descriptors: interface_descriptors /= Void and interface_descriptors = a_descriptors
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
			valid_name: not a_name.is_empty
		do
			default_dispinterface_name := a_name
		ensure
			non_void_default_dispinterface: default_dispinterface_name /= Void
			valid_default_dispinterface: not default_dispinterface_name.is_empty and default_dispinterface_name.is_equal (a_name)
		end

	set_default_source_dispinterface_name (a_name: STRING) is
			-- Set `default_source_dispinterface_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			default_source_dispinterface_name := a_name
		ensure
			non_void_default_source_dispinterface: default_source_dispinterface_name /= Void
			valid_default_source_dispinterface: not default_source_dispinterface_name.is_empty and default_source_dispinterface_name.is_equal (a_name)
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
		local
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			from
				interface_descriptors.start
			until
				interface_descriptors.after
			loop
				l_interface := interface_descriptors.item
				if l_interface.is_implementing_coclass (Current) then
					l_interface.disambiguate_coclass_names (Current)
					feature_c_names.append (l_interface.feature_c_names)
				end
				interface_descriptors.forth
			end
			if l_interface.is_implementing_coclass (Current) then
				rename_arguments (interface_descriptors)
				if source_interface_descriptors /= Void then
					rename_arguments (source_interface_descriptors)
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := guid.is_equal (other.guid)
		end

feature {WIZARD_TYPE_INFO_VISITOR} -- Visitor

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_coclass (Current)
		end

feature {NONE} -- Implementation

	rename_arguments (a_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]) is
			-- Rename arguments in features of interfaces in `a_descriptors' to avoid name clashes.
		require
			non_void_descriptors: a_descriptors /= Void
		local
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_argument: WIZARD_PARAM_DESCRIPTOR
			l_func: WIZARD_FUNCTION_DESCRIPTOR
		do
			from
				a_descriptors.start
			until
				a_descriptors.after
			loop
				l_interface := a_descriptors.item
				from
					l_interface.functions_start
				until
					l_interface.functions_after
				loop
					l_func := l_interface.functions_item
					if not l_func.is_renaming_clause and l_func.argument_count > 0 then
						l_arguments := l_func.arguments
						from
							l_arguments.start
						until
							l_arguments.after
						loop
							l_argument := l_arguments.item
							l_argument.set_name (unique_identifier (l_argument.name, agent feature_eiffel_names.has))
							l_arguments.forth
						end
					end
					l_interface.functions_forth
				end
				a_descriptors.forth
			end
		end

invariant
	non_void_feature_c_names: feature_c_names /= Void
	valid_feature_c_names: feature_c_names.object_comparison
	non_void_feature_eiffel_names: feature_eiffel_names /= Void

end -- class WIZARD_COCLASS_DESCRIPTOR

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

