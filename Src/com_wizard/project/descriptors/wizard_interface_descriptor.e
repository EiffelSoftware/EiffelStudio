indexing
	description: "Interface descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INTERFACE_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR

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

	WIZARD_GUIDS
		export 
			{NONE} all
		end

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
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
			create feature_eiffel_names.make
			feature_eiffel_names.compare_objects
			create feature_c_names.make
			feature_c_names.compare_objects
			
			a_creator.initialize_descriptor (Current)
		end

feature -- Access

	vtable_functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's vtable functions.

	dispatch_functions: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's dispatch functions.
	
	function_table: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Table of interface functions.
			-- Needed for fast search.
			
	properties: LINKED_LIST [WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface

	inherited_interface_descriptor: WIZARD_INHERITED_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	dispinterface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- If interface is dual, then it has dual description as dispinterface.

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	inherit_from_dispatch: BOOLEAN is
			-- Does interface inherit from IDispatch?
		do
			if inherited_interface /= Void then
				if not inherited_interface.name.is_equal (Iunknown_type) then
					Result := inherited_interface.name.is_equal (Idispatch_type) or else
						inherited_interface.inherit_from_dispatch
				end
			end
		end

	creation_message: STRING is
			-- Creation message for wizard output
		do
			Result := clone (Processed)
			Result.append (Space)
			if dispinterface then
				Result.append (Dispinterface_string)
			else
				Result.append (Interface)
			end
			Result.append (Space)
			Result.append (name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (guid.to_string)
			Result.append (Close_parenthesis)
			if inherited_interface /= Void then
				Result.append (New_line_tab)
				Result.append (Inherit_from_string)
				Result.append (Space)
				Result.append (inherited_interface.name)
			end
			if not description.is_empty then
				Result.append (New_line_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (description)
			end
			from
				functions_start
				if not functions_after then
					Result.append (New_line_tab)
					Result.append (Functions_string)
				end				
			until
				functions_after
			loop
				Result.append (New_line_tab)
				Result.append (functions_item.to_string)
				Result.append (New_line_tab_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (functions_item.description)
				functions_forth
			end
			from
				properties.start
				if not properties.after then
					Result.append (New_line_tab)
					Result.append (Properties_string)
				end				
			until
				properties.after
			loop
				Result.append (New_line_tab)
				Result.append (properties.item.to_string)
				Result.append (New_line_tab_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (properties.item.description)
				properties.forth
			end
		end

	feature_eiffel_names: LINKED_LIST [STRING]
			-- List of feature eiffel names.

	feature_c_names: LINKED_LIST [STRING]
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
			non_void_implemnted_interface: Result /= Void
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

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

	set_vtable_functions (some_functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Set `functions' with `some_functions'
		require
			valid_functions: some_functions /= Void
		do
			vtable_functions := some_functions
		ensure
			valid_functions: vtable_functions /= Void and vtable_functions = some_functions
		end

	set_dispatch_functions (some_functions: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Set `functions' with `some_functions'
		require
			valid_functions: some_functions /= Void
		do
			dispatch_functions := some_functions
		ensure
			valid_functions: dispatch_functions /= Void and dispatch_functions = some_functions
		end

	set_function_table (some_functions: LINKED_LIST [WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Set `function_table' with `some_functions'
		require
			valid_functions: some_functions /= Void
		do
			function_table := some_functions
		ensure
			valid_functions: function_table /= Void and function_table = some_functions
		end

	set_properties (some_properties: LINKED_LIST [WIZARD_PROPERTY_DESCRIPTOR]) is
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

	update_dual (a_dual_value: BOOLEAN) is
			-- Set `dual' with `a_dual_value'
		do
			dual := a_dual_value
		ensure
			valid_dual: dual = a_dual_value
		end

	update_dispinterface (a_dispinterface_value: BOOLEAN) is
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

feature -- Status Report

	dual_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): WIZARD_FUNCTION_DESCRIPTOR is
			-- Return dual function.
		local
			cursor: CURSOR
		do
			cursor := function_table.cursor
			from
				function_table.start
			until
				function_table.after or
				Result /= Void
			loop
				if
					a_function.member_id = function_table.item.member_id and
					a_function.invoke_kind = function_table.item.invoke_kind
				then
					Result := function_table.item
				end
				
				function_table.forth
			end
			function_table.go_to (cursor)
		end
		
	has_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Does `function_table' or `function_table' of
			-- `inherited_interface' have function with `member_id'?
		require
			non_void_table: function_table /= Void
		local
			cursor: CURSOR
		do
			cursor := function_table.cursor
			from
				function_table.start
			until
				function_table.after or 
				Result
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
					a_property.var_flags = properties.item.var_flags
				
				properties.forth
			end
			if not Result and inherited_interface /= Void then
				Result := inherited_interface.has_property (a_property)
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
			-- Forth for iteratyion.
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
	
	finalize_interface_functions is
			-- Finalize interface functions.
		local
			a_function_descriptor: WIZARD_FUNCTION_DESCRIPTOR
		do
			from
				function_table.start
			until
				function_table.after
			loop
				a_function_descriptor := function_table.item
				if 
					inherited_interface = Void or else 
					not inherited_interface.has_function (a_function_descriptor)
				then
					if a_function_descriptor.func_kind = Func_dispatch then
						dispatch_functions.force (a_function_descriptor)
					else
						vtable_functions.force (a_function_descriptor)
					end
					
				end
				function_table.forth
			end
			if dispinterface_descriptor /= Void then
				finalize_functions
			end
		end
		
	finalize_functions is
			-- Since dual interface may have functions that accessible
			-- through IDisptch only or Vtable only,
			-- Review both descriptions and make uniform function list.
		require
			dual: dual
			non_void_dispinterface: dispinterface_descriptor /= Void
		local
			virtual_function, dispatch_function: WIZARD_FUNCTION_DESCRIPTOR
			
		do
			from
				vtable_functions.start
			until
				vtable_functions.after
			loop
				virtual_function := vtable_functions.item
				dispatch_function := dispinterface_descriptor.dual_function (virtual_function)
				
				if 
					(dispatch_function /= Void) 
				then
					if dispatch_access (virtual_function, dispatch_function) then
						vtable_functions.replace (dispatch_function)
					else
						virtual_function.set_dual (True)
					end
					dispinterface_descriptor.function_table.prune (dispatch_function)
				end
				
				vtable_functions.forth
			end
			if not dispinterface_descriptor.function_table.is_empty then
				from
					dispinterface_descriptor.function_table.start
				until
					dispinterface_descriptor.function_table.after
				loop
					if 
						not has_function 
							(dispinterface_descriptor.function_table.item) and 
						not is_unknown_dispatch_function 
							(dispinterface_descriptor.function_table.item)
					then
						dispatch_functions.force (dispinterface_descriptor.function_table.item)
					end
					dispinterface_descriptor.function_table.forth
				end
			end
		end
	
	is_unknown_dispatch_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Is IUnknown or IDispatch function.
		require
			non_void_function: a_function /= Void
		local
			a_name: STRING
		do
			a_name := a_function.name
			Result := a_name.is_equal (Add_reference) or
					a_name.is_equal (Release) or
					a_name.is_equal (Query_interface) or
					a_name.is_equal (Invoke) or
					a_name.is_equal (Get_ids_of_names) or
					a_name.is_equal (Get_type_info) or
					a_name.is_equal (Get_type_info_count)
		end
		
feature -- Basic operations

	initialize_inherited_interface is
			-- Initialize inherited interface.
		require
			non_void_descriptor: inherited_interface_descriptor /= Void
		do
			inherited_interface ?= inherited_interface_descriptor.library.descriptors.item (inherited_interface_descriptor.index);
		ensure
			non_void_inherited_interface: inherited_interface /= Void
		end

	disambiguate_eiffel_names is
			-- Disambiguate feature names.
		do
			if feature_eiffel_names.is_empty then
				if 
					inherited_interface /= Void and
					not inherited_interface.guid.is_equal (Iunknown_guid) and
					not inherited_interface.guid.is_equal (Idispatch_guid)
				then
					inherited_interface.disambiguate_eiffel_names
					feature_eiffel_names.append (inherited_interface.feature_eiffel_names)
				end
				from
					functions_start
				until
					functions_after
				loop
					functions_item.disambiguate_eiffel_names (Current)
					functions_forth
				end

				from
					properties.start
				until
					properties.after
				loop
					properties.item.disambiguate_eiffel_names (Current)
					properties.forth
				end

				from
					functions_start
				until
					functions_after
				loop
					if functions_item.argument_count > 0 then
						from
							functions_item.arguments.start
						until
							functions_item.arguments.after
						loop
							if 
								feature_eiffel_names.has (functions_item.arguments.item.name)  or
								eiffel_key_words.has (functions_item.arguments.item.name)
							then
								functions_item.arguments.item.name.prepend ("a_")
							end
							functions_item.arguments.forth
						end
					end
					functions_forth
				end

			end
		ensure
			not_empty_feature_names: not functions_empty and not properties.is_empty implies 
									not feature_eiffel_names.is_empty
		end

	disambiguate_c_names (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate feature names.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			valid_coclass_descriptor: a_coclass_descriptor.feature_c_names /= Void
		do
			if 
				inherited_interface /= Void and
				not inherited_interface.guid.is_equal (Iunknown_guid) and
				not inherited_interface.guid.is_equal (Idispatch_guid)
			then
				inherited_interface.disambiguate_c_names (a_coclass_descriptor)
				feature_c_names.append (inherited_interface.feature_c_names)
			end
			from
				functions_start
			until
				functions_after
			loop
				functions_item.disambiguate_names (Current, a_coclass_descriptor)
				functions_forth
			end

			from
				properties.start
			until
				properties.after
			loop
				properties.item.disambiguate_names (Current, a_coclass_descriptor)
				properties.forth
			end
		ensure
			not_empty_feature_names: not functions_empty and not properties.is_empty implies 
									not feature_c_names.is_empty
		end


	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_interface (Current)
		end

feature {NONE} -- Implementation
	
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

	dispatch_access (virtual_function, dispatch_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Check Vtable description.
		require
			non_void_virtual_function: virtual_function /= Void
			non_void_dispatch_function: dispatch_function /= Void
			valid_dispatch: dispatch_function.func_kind = Func_dispatch
			same_function: virtual_function.member_id = dispatch_function.member_id
		local
			has_result, return_hresult: BOOLEAN
			argument_count: INTEGER
			type: INTEGER
		do
			if 
				dispatch_function.return_type /= Void
			then
				type := dispatch_function.return_type.type
				has_result := not (type = Vt_void or type = Vt_empty or type = Vt_null)
			end
						
			if has_result then
				argument_count := dispatch_function.argument_count + 1
			else
				argument_count := dispatch_function.argument_count
			end
			
			return_hresult := virtual_function.return_type /= Void and then
				virtual_function.return_type.type = Vt_hresult
			
			Result := not return_hresult or
				virtual_function.argument_count /= argument_count
		end
			
end -- class WIZARD_INTERFACE_DESCRIPTOR

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

