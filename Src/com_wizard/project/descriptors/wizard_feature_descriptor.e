indexing
	description: "Feature descriptor"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FEATURE_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_UNIQUE_IDENTIFIER_FACTORY
		export
			{NONE} all
		end

feature -- Access

	name: STRING
			-- Feature name

	interface_eiffel_name: STRING
			-- Eiffel function name used in deferred interface

	component_eiffel_name (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Eiffel name in `a_component'
		require
			non_void_component: a_component /= Void
			non_void_component_name: a_component.name /= Void
			non_void_interface_name: interface_eiffel_name /= Void
			valid_component_name: not a_component.name.is_empty
			valid_interface_name: not interface_eiffel_name.is_empty
		do
			components_eiffel_names.search (a_component.name)
			if components_eiffel_names.found then
				Result := components_eiffel_names.found_item
			else
				Result := interface_eiffel_name
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	description: STRING
			-- Help String.

	member_id: INTEGER
			-- Member ID.

	from_iunknown_or_idispatch: BOOLEAN
			-- Is function from IUnknown or IDispatch?

feature -- Status Report

	is_renamed_in (a_component: WIZARD_COMPONENT_DESCRIPTOR): BOOLEAN is
			-- Is feature renamed in `a_component'?
		require
			non_void_component: a_component /= Void
			non_void_component_name: a_component.name /= Void
		do
			Result := components_eiffel_names.has (a_component.name)
		end
		
feature -- Transformation

	disambiguate_coclass_names (a_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR; a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate names for coclass.
		require
			non_void_interface_descriptor: a_interface_descriptor /= Void
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			l_name, l_new_name: STRING
			l_names: ARRAYED_LIST [STRING]
			l_eiffel_names: HASH_TABLE [WIZARD_INTERFACE_DESCRIPTOR, STRING]
		do
			-- First check whether this feature was already processed
			l_eiffel_names := a_coclass_descriptor.feature_eiffel_names
			l_eiffel_names.search (interface_eiffel_name)			
			if l_eiffel_names.found then
				-- Check whether processed feature comes from same interface
				if not a_interface_descriptor.is_equal (l_eiffel_names.found_item) then
					-- Check whether feature was already renamed
					if not components_eiffel_names.has (a_coclass_descriptor.name) then
						-- First rename C feature interface name so it's unique in coclass context
						l_name := name
						l_names := a_coclass_descriptor.feature_c_names
						if l_names.has (l_name) then
							create l_new_name.make (240)
							l_new_name.append (a_interface_descriptor.name)
							l_new_name.append_character ('_')
							l_new_name.append (l_name)
							name := unique_identifier (l_new_name, agent l_names.has)
						end
						
						-- Then rename Eiffel feature name in coclass, add corresponding renaming clause
						l_name := interface_eiffel_name
						l_new_name := unique_identifier (l_name, agent table_has_name (l_eiffel_names, ?))
						if not l_new_name.is_equal (l_name) then
							l_name := l_new_name
							add_component_eiffel_name (l_name, a_coclass_descriptor)
						end
						l_eiffel_names.put (a_interface_descriptor, l_name)
					end
				end
			else
				-- Not yet in coclass features table, add it.
				l_eiffel_names.put (a_interface_descriptor, interface_eiffel_name)
			end

			-- Store used name for later comparison
			a_interface_descriptor.feature_c_names.force (name.twin)
		end

	disambiguate_interface_names (a_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Disambiguate names for interface.
		require
			non_void_interface: a_interface_descriptor /= Void
		local
			l_name: STRING
			l_names: LIST [STRING]
		do
			name := unique_identifier (name, agent (system_descriptor.c_types).has)
			l_name := interface_eiffel_name.as_lower
			l_names := a_interface_descriptor.feature_eiffel_names
			interface_eiffel_name := unique_identifier (l_name, agent list_has_name (l_names, ?))
			l_names.force (interface_eiffel_name)
		end

feature -- Basic operations

	add_component_eiffel_name (a_eiffel_name: STRING; a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add `a_eiffel_name' to `components_eiffel_names' table
			-- with key `a_coclass_name'
		require
			non_void_eiffel_name: a_eiffel_name /= Void
			valid_eiffel_name: not a_eiffel_name.is_empty
			non_void_component: a_component /= Void
			valid_component: a_component.name /= Void
			not_has: not is_renamed_in (a_component)
		do
			components_eiffel_names.extend (a_eiffel_name, a_component.name)
		end

	set_interface_eiffel_name (a_name: STRING) is
			-- Set `eiffel_name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			interface_eiffel_name := a_name.twin
		ensure
			valid_name: interface_eiffel_name /= Void and then not interface_eiffel_name.is_empty and interface_eiffel_name.is_equal (a_name)
		end

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := a_name.twin
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_from_iunknown_or_idispatch (a_value: BOOLEAN) is
			-- Set `from_iunknown_or_idispatch' with `a_value'
		do
			from_iunknown_or_idispatch := a_value
		ensure
			set: from_iunknown_or_idispatch = a_value
		end

feature {NONE} -- Implementation

	components_eiffel_names: HASH_TABLE [STRING, STRING]
			-- Eiffel function name used in coclass if different from `interface_eiffel_name'
			-- item: function name
			-- key: Coclass name, `name' in coclass_descriptor.


	list_has_name (a_list: LIST [STRING]; a_name: STRING): BOOLEAN is
			-- Does `a_list' have `a_name' corresponding to `a_name'?
		require
			non_void_list: a_list /= Void
			non_void_name: a_name /= Void
		do
			Result := a_list.has (a_name)
		ensure
			definition: Result = a_list.has (a_name)
		end
				
	table_has_name (a_table: HASH_TABLE [ANY, STRING]; a_name: STRING): BOOLEAN is
			-- Does `a_table' have `a_name' corresponding to `a_name'?
		require
			non_void_table: a_table /= Void
			non_void_name: a_name /= Void
		do
			Result := a_table.has (a_name)
		ensure
			definition: Result = a_table.has (a_name)
		end
				
end -- class WIZARD_FEATURE_DESCRIPTOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

