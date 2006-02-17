indexing
	description: "Interface descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INTERFACE_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR
		rename
			c_header_file_name as c_definition_header_file_name
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

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

	ECOM_FUNC_KIND

	ECOM_VAR_TYPE
		rename
			is_iunknown as is_unknown_interface,
			is_idispatch as is_dispatch_interface
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_INTERFACE_DESCRIPTOR_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			create {ARRAYED_LIST [WIZARD_COCLASS_DESCRIPTOR]} implementing_coclasses.make (5)
			create {ARRAYED_LIST [STRING]} feature_eiffel_names.make (20)
			create {ARRAYED_LIST [STRING]} feature_c_names.make (20)
			implementing_coclasses.compare_objects
			feature_eiffel_names.compare_objects
			feature_c_names.compare_objects
			create {SORTED_TWO_WAY_LIST [WIZARD_FUNCTION_DESCRIPTOR]} vtable_functions.make
			create {ARRAYED_LIST [WIZARD_FUNCTION_DESCRIPTOR]} dispatch_functions.make (function_table.count)
		end

feature -- Access

	is_interface_disambiguated: BOOLEAN
			-- Interface feature names were disambiguated

	c_declaration_header_file_name: STRING
			-- File name for declaration header file

	vtable_functions: SORTED_TWO_WAY_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's vtable functions

	dispatch_functions: LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's dispatch functions

	function_table: LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Table of interface functions

	properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface
			--| Used when parent interface hasn't been analyzed yet

	inherited_interface_descriptor: WIZARD_INHERITED_INTERFACE_DESCRIPTOR
			-- Parent interface

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	dispinterface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Descriptor for dispinterface or dual interface
			-- Note: this descriptor is "flat" (i.e. includes all inherited functions)

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	is_idispatch_heir: BOOLEAN is
			-- Does interface inherit from IDispatch?
		do
			if inherited_interface /= Void then
				if not inherited_interface.is_iunknown then
					Result := inherited_interface.is_idispatch or else inherited_interface.is_idispatch_heir
				end
			end
		end

	creation_message: STRING is
			-- Creation message for wizard output
		local
			l_description: STRING
			l_property: WIZARD_PROPERTY_DESCRIPTOR
		do
			create Result.make (256)
			Result.append ("Processing ")
			if dispinterface then
				Result.append ("dispatch interface ")
			else
				Result.append ("interface ")
			end
			Result.append (name)
			Result.append (" (")
			Result.append (guid.to_string)
			Result.append (")")
			if inherited_interface /= Void then
				Result.append ("%R%N%Tinherit from ")
				Result.append (inherited_interface.name)
			end
			if not description.is_empty then
				Result.append ("%R%N%T%T-- ")
				Result.append (description)
			end
			from
				functions_start
				if not functions_after then
					Result.append ("%R%N%TFunctions:")
				end
			until
				functions_after
			loop
				if not functions_item.is_renaming_clause then
					Result.append ("%R%N%T%T")
					Result.append (functions_item.to_string)
					l_description := functions_item.description
					if l_description /= Void and then not l_description.is_empty then
						Result.append ("%R%N%T%T%T-- ")
						Result.append (l_description)
					end
				end
				functions_forth
			end
			from
				properties.start
				if not properties.after then
					Result.append ("%R%N%TProperties:")
				end
			until
				properties.after
			loop
				l_property := properties.item
				Result.append ("%R%N%T%T")
				Result.append (l_property.to_string)
				l_description := l_property.description
				if l_description /= Void and then not l_description.is_empty then
					Result.append ("%R%N%T%T%T-- ")
					Result.append (l_property.description)
				end
				properties.forth
			end
			Result.append ("%R%N")
		end

	feature_eiffel_names: LIST [STRING]
			-- List of feature eiffel names.

	feature_c_names: LIST [STRING]
			-- List of feature C names.

	implemented_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR is
			-- Implemented interface descriptor.
		do
			if instance_implemented_interface /= Void then
				Result := instance_implemented_interface
			else
				create Result.make_from_interface (Current)
				instance_implemented_interface := Result
			end
		ensure
			non_void_instance_interface: instance_implemented_interface /= Void
			non_void_implemented_interface: Result /= Void
		end

	functions_item: WIZARD_FUNCTION_DESCRIPTOR is
			-- Item for iteration.
		require
			non_void_functions: vtable_functions /= Void and dispatch_functions /= Void
			not_after: not functions_after
		do
			if in_vtable then
				Result := vtable_functions.item
			else
				Result := dispatch_functions.item
			end
		ensure
			non_void_function: Result /= Void
		end

	functions_count: INTEGER is
			-- Function count.
		local
			vtable_count, dispatch_count: INTEGER
		do
			if vtable_functions = Void then
				vtable_count := 0
			else
				vtable_count := vtable_functions.count
			end
			if dispatch_functions = Void then
				dispatch_count := 0
			else
				dispatch_count := dispatch_functions.count
			end
			Result := vtable_count + dispatch_count
		end

feature -- Element Change

	set_c_declaration_header_file_name (a_name: STRING) is
			-- Set `c_declaration_header_file_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			c_declaration_header_file_name := a_name
		ensure
			c_declaration_header_file_name_set: c_declaration_header_file_name = a_name
		end

	add_implementing_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add `a_coclass' to `implementing_coclasses'.
		require
			non_void_coclass: a_coclass /= Void
		do
			if not implementing_coclasses.has (a_coclass) then
				implementing_coclasses.extend (a_coclass)
			end
		ensure
			added: implementing_coclasses.has (a_coclass)
		end

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

	set_function_table (some_functions: LIST [WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Set `function_table' with `some_functions'
		require
			valid_functions: some_functions /= Void
		do
			function_table := some_functions
		ensure
			valid_functions: function_table /= Void and function_table = some_functions
		end

	set_properties (some_properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]) is
			-- Set `properties' with `some_properties'
		require
			valid_properties: some_properties /= Void
		do
			properties := some_properties
		ensure
			valid_properties: properties /= Void and properties = some_properties
		end

	set_inherited_interface (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Set `inherited_interface' with `an_interface'
		do
			inherited_interface := an_interface
		ensure
			interface_set: inherited_interface = an_interface
		end

	set_inherited_interface_descriptor (a_descriptor: WIZARD_INHERITED_INTERFACE_DESCRIPTOR) is
			-- Set `inherited_interface_descriptor' with `a_descriptor'
		do
			inherited_interface_descriptor := a_descriptor
		ensure
			interface_set: inherited_interface_descriptor = a_descriptor
		end

	set_dual (a_dual_value: BOOLEAN) is
			-- Set `dual' with `a_dual_value'
		do
			dual := a_dual_value
		ensure
			valid_dual: dual = a_dual_value
		end

	set_dispinterface (a_dispinterface_value: BOOLEAN) is
			-- Set `dispinterface' with `a_dispinterface_value'
		do
			dispinterface := a_dispinterface_value
		ensure
			valid_dispinterface: dispinterface = a_dispinterface_value
		end

	set_dispinterface_descriptor (a_dispinterface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Set `dispinterface_descriptor' with `a_dispinterface_descriptor'
		do
			dispinterface_descriptor := a_dispinterface_descriptor
		ensure
			interface_set: dispinterface_descriptor = a_dispinterface_descriptor
		end

	set_lcid (a_lcid: INTEGER) is
			-- Set `lcid' with `a_lcid'
		do
			lcid := a_lcid
		ensure
			valid_lcid: lcid = a_lcid
		end

	set_vtbl_size (a_size: INTEGER) is
			-- Set `vtbl_size' with `a_size'
		do
			vtbl_size := a_size
		ensure
			valid_size: vtbl_size = a_size
		end

	set_flags (some_flags: INTEGER) is
			-- Set `flags' with `some_flags'
		do
			flags := some_flags
		ensure
			valid_flags: flags = some_flags
		end

	set_is_iunknown (a_bool: BOOLEAN) is
			-- Set `is_iunknown' with `a_bool'.
		do
			is_iunknown := a_bool
		ensure
			is_iunknown_set: is_iunknown = a_bool
		end

	set_is_idispatch (a_bool: BOOLEAN) is
			-- Set `is_idispatch' with `a_bool'.
		do
			is_idispatch := a_bool
		ensure
			is_idispatch_set: is_idispatch = a_bool
		end

feature -- Status Report

	is_implementing_coclass (a_coclass: WIZARD_COCLASS_DESCRIPTOR): BOOLEAN is
			-- Is `a_coclass' implementing interface?
		require
			non_void_coclass: a_coclass /= Void
		do
			Result := implementing_coclasses.has (a_coclass)
		end

	dual_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): WIZARD_FUNCTION_DESCRIPTOR is
			-- Dual function
		local
			l_cursor: CURSOR
			l_id, l_invoke_kind: INTEGER
			l_func: WIZARD_FUNCTION_DESCRIPTOR
		do
			l_cursor := function_table.cursor
			l_id := a_function.member_id
			l_invoke_kind := a_function.invoke_kind
			from
				function_table.start
			until
				function_table.after or Result /= Void
			loop
				l_func := function_table.item
				if l_id = l_func.member_id and l_invoke_kind = l_func.invoke_kind then
					Result := l_func
				else
					function_table.forth
				end
			end
			function_table.go_to (l_cursor)
		end

	has_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Does `function_table' or `function_table' of
			-- `inherited_interface' have function `a_function'?
		require
			non_void_table: function_table /= Void
		local
			cursor: CURSOR
		do
			cursor := function_table.cursor
			from
				function_table.start
			until
				function_table.after or Result
			loop
				Result := a_function.member_id = function_table.item.member_id and
					a_function.invoke_kind = function_table.item.invoke_kind
				function_table.forth
			end
			if not Result and inherited_interface /= Void then
				Result := inherited_interface.has_function (a_function)
			end
			function_table.go_to (cursor)
		end

	has_property (a_property: WIZARD_PROPERTY_DESCRIPTOR): BOOLEAN is
			-- Does interface have `a_property'?
		require
			non_void_property: a_property /= Void
		local
			cursor: CURSOR
		do
			cursor := properties.cursor
			from
				properties.start
			until
				properties.after or
				Result
			loop
				Result := a_property.member_id = properties.item.member_id and
					a_property.is_read_only = properties.item.is_read_only
				properties.forth
			end
			properties.go_to (cursor)
		end

	functions_after: BOOLEAN is
			-- Is after?
		require
			non_void_functions: vtable_functions /= Void and dispatch_functions /= Void
		do
			Result := not in_vtable and dispatch_functions.after
		end

	functions_empty: BOOLEAN is
			-- Are functions is_empty?
		do
			Result := (vtable_functions = Void or else vtable_functions.is_empty) and
					(dispatch_functions = Void or else dispatch_functions.is_empty)
		end

feature -- Cursor movement

	functions_start is
			-- Start for iteration.
		require
			non_void_functions: vtable_functions /= Void and dispatch_functions /= Void
		do
			if not vtable_functions.is_empty then
				vtable_functions.start
				in_vtable := True
			else
				dispatch_functions.start
				in_vtable := False
			end
		end

	functions_forth is
			-- Forth for iteration.
		require
			non_void_functions: vtable_functions /= Void and dispatch_functions /= Void
		do
			if in_vtable then
				vtable_functions.forth
				if vtable_functions.after then
					in_vtable := False
					dispatch_functions.start
				end
			else
				dispatch_functions.forth
			end
		end

feature -- Miscellaneous

	finalize_functions is
			-- Finalize interface functions.
			-- Build `vtable_functions' and `dispatch_functions' lists from `function_table'.
		local
			l_descriptor: WIZARD_FUNCTION_DESCRIPTOR
			l_virtual_function, l_dispatch_function: WIZARD_FUNCTION_DESCRIPTOR
			l_functions: LIST [WIZARD_FUNCTION_DESCRIPTOR]
			l_function: WIZARD_FUNCTION_DESCRIPTOR
		do
			from
				function_table.start
			until
				function_table.after
			loop
				l_descriptor := function_table.item
				if l_descriptor.func_kind = Func_dispatch then
					dispatch_functions.force (l_descriptor)
				else
					vtable_functions.force (l_descriptor)
				end
				function_table.forth
			end
			if dispinterface_descriptor /= Void then
				l_functions := dispinterface_descriptor.function_table
				from
					vtable_functions.start
				until
					vtable_functions.after
				loop
					l_virtual_function := vtable_functions.item
					l_dispatch_function := dispinterface_descriptor.dual_function (l_virtual_function)
					if l_dispatch_function /= Void then
						l_virtual_function.set_dual (True)
						l_functions.prune (l_dispatch_function)
					end
					vtable_functions.forth
				end
				if not l_functions.is_empty then
					from
						l_functions.start
					until
						l_functions.after
					loop
						l_function := l_functions.item
						if not l_function.from_iunknown_or_idispatch and not has_function (l_function) then
							dispatch_functions.force (l_function)
						end
						l_functions.forth
					end
				end
			end
		end

feature -- Basic operations

	initialize_inherited_interface is
			-- Initialize inherited interface.
		require
			non_void_descriptor: inherited_interface_descriptor /= Void
		do
			inherited_interface ?= inherited_interface_descriptor.library.descriptors.item (inherited_interface_descriptor.index)
		ensure
			non_void_inherited_interface: inherited_interface /= Void
		end

	disambiguate_interface_names is
			-- Disambiguate feature names.
		require
			not_disambiguated: not is_interface_disambiguated
		local
			l_arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			l_argument: WIZARD_PARAM_DESCRIPTOR
		do
			if inherited_interface /= Void and not inherited_interface.is_iunknown and not inherited_interface.is_idispatch then
				if not inherited_interface.is_interface_disambiguated then
					inherited_interface.disambiguate_interface_names
				end
				feature_eiffel_names.append (inherited_interface.feature_eiffel_names)
			end
			from
				functions_start
			until
				functions_after
			loop
				if not functions_item.is_renaming_clause then
					functions_item.disambiguate_interface_names (Current)
				end
				functions_forth
			end

			from
				properties.start
			until
				properties.after
			loop
				properties.item.disambiguate_interface_names (Current)
				properties.forth
			end

			from
				functions_start
			until
				functions_after
			loop
				if functions_item.argument_count > 0 then
					l_arguments := functions_item.arguments
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
				functions_forth
			end
			is_interface_disambiguated := True
		ensure
			not_empty_feature_names: not functions_empty and not properties.is_empty implies
									not feature_eiffel_names.is_empty
		end

	disambiguate_coclass_names (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate coclass feature names.
			--| For each feature we keep two tables:
			--|  * One table is kept in the feature descriptor which contains new names
			--|    if any, this table is index by coclasses.
			--|  * The second table is kept in the coclass descriptor and associates feature names
			--|    with the corresponding interface. This is necessary to allow for merging
			--|    features in the case a coclass implements both an interface and its parent.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			valid_coclass_descriptor: a_coclass_descriptor.feature_c_names /= Void
		local
			l_rename: WIZARD_RENAMING_CLAUSE
			l_properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
			l_func: WIZARD_FUNCTION_DESCRIPTOR
			l_prop: WIZARD_PROPERTY_DESCRIPTOR
			l_original_name, l_changed_name: STRING
		do
			-- First process parent interface if any and propagate rename clauses
			-- to heir if there are any.
			if inherited_interface /= Void and not inherited_interface.is_iunknown and not inherited_interface.is_idispatch then
				inherited_interface.disambiguate_coclass_names (a_coclass_descriptor)
				feature_c_names.append (inherited_interface.feature_c_names)
				from
					inherited_interface.functions_start
				until
					inherited_interface.functions_after
				loop
					l_func := inherited_interface.functions_item
					if not l_func.is_renaming_clause and l_func.is_renamed_in (a_coclass_descriptor) then
						l_original_name := l_func.interface_eiffel_name
						l_changed_name := l_func.component_eiffel_name (a_coclass_descriptor)
						-- Could be identical if parent interface renaming comes from another component
						if not l_original_name.is_equal (l_changed_name) then
							create l_rename.make (l_original_name, l_changed_name, a_coclass_descriptor)
							vtable_functions.extend (l_rename)
						end
					end
					inherited_interface.functions_forth
				end
				l_properties := inherited_interface.properties
				from
					l_properties.start
				until
					l_properties.after
				loop
					l_prop := l_properties.item
					if l_prop.is_renamed_in (a_coclass_descriptor) then
						l_original_name := l_prop.interface_eiffel_name
						l_changed_name := l_prop.component_eiffel_name (a_coclass_descriptor)
						-- Could be identical if parent interface renaming comes from another component
						if not l_original_name.is_equal (l_changed_name) then
							create l_rename.make (l_original_name, l_changed_name, a_coclass_descriptor)
							vtable_functions.extend (l_rename)
						end
					end
					l_properties.forth
				end
			end
			from
				functions_start
			until
				functions_after
			loop
				if not functions_item.is_renaming_clause then
					functions_item.disambiguate_coclass_names (Current, a_coclass_descriptor)
				end
				functions_forth
			end

			from
				properties.start
			until
				properties.after
			loop
				properties.item.disambiguate_coclass_names (Current, a_coclass_descriptor)
				properties.forth
			end
		ensure
			not_empty_feature_names: not functions_empty and not properties.is_empty implies not feature_c_names.is_empty
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_interface (Current)
		end

feature {WIZARD_INTERFACE_DESCRIPTOR} -- Implementation

	implementing_coclasses: LIST [WIZARD_COCLASS_DESCRIPTOR]
			-- Coclasses that *directly* implement interface

	in_vtable: BOOLEAN
			-- Cursor in vtable.

	counter: INTEGER is
			-- Counter
		do
			Result := counter_impl.item
			counter_impl.set_item (Result + 1)
		end

	counter_impl: INTEGER_REF is
			-- Global counter
		once
			create Result
			Result.set_item (1)
		end

	instance_implemented_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
			-- Implemented interface descriptor.

	dispatch_access (a_function, a_dispatch_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Check Vtable description.
		require
			non_void_virtual_function: a_function /= Void
			non_void_dispatch_function: a_dispatch_function /= Void
			valid_dispatch: a_dispatch_function.func_kind = Func_dispatch
			same_function: a_function.member_id = a_dispatch_function.member_id
		local
			l_count: INTEGER
			l_type: INTEGER
		do
			Result := a_function.return_type = Void or else a_function.return_type.type = Vt_hresult
			if not Result then
				l_count := a_dispatch_function.argument_count
				if a_dispatch_function.return_type /= Void then
					l_type := a_dispatch_function.return_type.type
					if l_type /= Vt_void and l_type /= Vt_empty and l_type /= Vt_null then
						l_count := l_count + 1
					end
				end
				Result := a_function.argument_count /= l_count
			end
		end

end -- class WIZARD_INTERFACE_DESCRIPTOR

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

