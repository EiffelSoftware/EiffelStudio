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

	functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]
			-- Descriptions of interface's functions

	properties: LINKED_LIST[WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values

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
			if not description.empty then
				Result.append (New_line_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (description)
			end
			from
				functions.start
				if not functions.after then
					Result.append (New_line_tab)
					Result.append (Functions_string)
				end				
			until
				functions.after
			loop
				Result.append (New_line_tab)
				Result.append (functions.item.to_string)
				Result.append (New_line_tab_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (functions.item.description)
				functions.forth
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
	

feature -- Status Report

	has_function (a_function: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Does interface have `a_function'?
		require
			non_void_function: a_function /= Void
		do
			if inherited_interface /= Void then
				Result := inherited_interface.has_function (a_function)
			end
			from
				functions.start
			until
				functions.after or Result
			loop
				Result := a_function.is_equal_function (functions.item)
				functions.forth
			end
		end	

	has_property (a_property: WIZARD_PROPERTY_DESCRIPTOR): BOOLEAN is
			-- Does interface have `a_property?
		require
			non_void_property: a_property /= Void
		do
			if inherited_interface /= Void then
				Result := inherited_interface.has_property (a_property)
			end
			from
				properties.start
			until
				properties.after or Result
			loop
				Result := a_property.is_equal_property (properties.item)
				properties.forth
			end
		end	

feature -- Basic operations

	disambiguate_eiffel_names is
			-- Disambiguate feature names.
		local
			tmp_string, tmp_string2: STRING
		do
			if feature_eiffel_names.empty then
				if 
					inherited_interface /= Void and
					not inherited_interface.guid.is_equal (Iunknown_guid) and
					not inherited_interface.guid.is_equal (Idispatch_guid)
				then
					inherited_interface.disambiguate_eiffel_names
					feature_eiffel_names.append (inherited_interface.feature_eiffel_names)
				end
				from
					functions.start
				until
					functions.after
				loop
					functions.item.disambiguate_eiffel_names (Current)
					functions.forth
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
					functions.start
				until
					functions.after
				loop
					if functions.item.argument_count > 0 then
						from
							functions.item.arguments.start
						until
							functions.item.arguments.after
						loop
							if 
								feature_eiffel_names.has (functions.item.arguments.item.name)  or
								eiffel_key_words.has (functions.item.arguments.item.name)
							then
								functions.item.arguments.item.name.prepend ("a_")
							end
							functions.item.arguments.forth
						end
					end
					functions.forth
				end

			end
		ensure
			not_empty_feature_names: not functions.empty and not properties.empty implies 
									not feature_eiffel_names.empty
		end

	disambiguate_c_names (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate feature names.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			valid_coclass_descriptor: a_coclass_descriptor.feature_c_names /= Void
		local
			tmp_name: STRING
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
				functions.start
			until
				functions.after
			loop
				functions.item.disambiguate_names (Current, a_coclass_descriptor)
				functions.forth
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
			not_empty_feature_names: not functions.empty and not properties.empty implies 
									not feature_c_names.empty
		end

	set_functions (some_functions: SORTED_TWO_WAY_LIST[WIZARD_FUNCTION_DESCRIPTOR]) is
			-- Set `functions' with `some_functions'
		require
			valid_functions: some_functions /= Void
		do
			functions := some_functions
		ensure
			valid_functions: functions /= Void and functions = some_functions
		end

	set_properties (some_properties: LINKED_LIST[WIZARD_PROPERTY_DESCRIPTOR]) is
			-- Set `properties' with `some_properties'
		require
			valid_properties: some_properties /= Void
		do
			properties := some_properties
		ensure
			valid_properties: properties /= Void and properties = some_properties
		end

	set_inherited_interface (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Set `inherited_interfaces' with `some_interfaces'
		do
			inherited_interface := a_interface
		ensure
			interface_set: inherited_interface = a_interface
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


	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_interface (Current)
		end

feature {NONE} -- Implementation

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

