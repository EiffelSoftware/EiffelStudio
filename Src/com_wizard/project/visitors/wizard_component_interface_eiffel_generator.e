indexing
	description: "Processing interface for Eiffel component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		rename
			interface as dictionary_interface,
			component as dictionary_component
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		rename
			interface as dictionary_interface,
			component as dictionary_component
		export
			{NONE} all
		end

feature -- Initialization

	make (a_component: WIZARD_COMPONENT_DESCRIPTOR;
				an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Initialize
		do
			component := a_component
			interface := an_interface
			eiffel_writer := an_eiffel_writer
			inherit_clause := an_inherit_clause
		end

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
			-- Eiffel class writer.

	inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			-- Inherit clause writer.

feature -- Basic Operations

	add_feature_to_class (a_feature: WIZARD_WRITER_FEATURE) is
			-- Add `a_feature' to `a_class'.
			-- Add efffective, non-external feature to class.
		require
			non_void_feature: a_feature /= Void
		do
			if (a_feature.result_type /= Void and then not a_feature.result_type.empty) and
				(a_feature.arguments = Void or else a_feature.arguments.empty)
			then
				eiffel_writer.add_feature (a_feature, Access)
			else
				eiffel_writer.add_feature (a_feature, Basic_operations)
			end
		end

	add_property_features_to_class (a_property: WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR) is
			-- Add property related features to `a_class'.
		require
			non_void_property: a_property /= Void
			non_void_access_feature: a_property.access_feature /= Void
		do
			eiffel_writer.add_feature (a_property.access_feature, Access)
			if (a_property.external_access_feature /= Void) then
				eiffel_writer.add_feature (a_property.external_access_feature, Externals)
			end
			if (a_property.external_setting_feature /= Void) then
				eiffel_writer.add_feature (a_property.external_setting_feature, Externals)
			end
			if (a_property.setting_feature /= Void) then
				eiffel_writer.add_feature (a_property.setting_feature, Element_change)
			end
		end

	add_feature_rename (a_function_generator: WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR) is
			-- Add rename to `inherit_cluse'.
		require
			non_void_inherit_clause: inherit_clause /= Void
			non_void_function_generator: a_function_generator /= Void
		local
			tmp_original_name, tmp_changed_name: STRING
		do
			if a_function_generator.function_renamed then
				inherit_clause.add_rename (a_function_generator.original_name, a_function_generator.changed_name)
				tmp_original_name := user_precondition_name (a_function_generator.original_name)
				tmp_changed_name := user_precondition_name (a_function_generator.changed_name)
				inherit_clause.add_rename (tmp_original_name, tmp_changed_name)
			end
		end

	add_property_rename (a_property_generator: WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR) is
			-- Add rename to `inherit_cluse'.
		require
			non_void_inherit_clause: inherit_clause /= Void
			non_void_property_generator: a_property_generator /= Void
		do
			if a_property_generator.property_renamed then
				from
					a_property_generator.changed_names.start
				until
					a_property_generator.changed_names.off
				loop
					inherit_clause.add_rename (a_property_generator.changed_names.key_for_iteration, 
							a_property_generator.changed_names.item_for_iteration)
					a_property_generator.changed_names.forth
				end
			end
		end

feature {NONE} -- Implementation

	clean_up is
			-- Clean up.
		do
			component := Void
			interface := Void
			eiffel_writer := Void
			inherit_clause := Void
		end

invariant
	non_void_eiffel_writer: not finished implies eiffel_writer /= Void
	non_void_inherit_clause: not finished implies inherit_clause /= Void

end -- class WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
