indexing
	description: "Processing interface for Eiffel component."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_GENERATOR
		redefine
			default_create
		end

	WIZARD_WRITER_FEATURE_CLAUSES
		rename
			interface as dictionary_interface,
			component as dictionary_component
		export
			{NONE} all
		redefine
			default_create
		end

	WIZARD_VARIABLE_NAME_MAPPER
		rename
			interface as dictionary_interface,
			component as dictionary_component
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance.
		do
			create generated_coclasses.make (10)
			finished := True
		end

feature -- Initialization

	initialize (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS; a_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Initialize
		do
			component := a_component
			interface := a_interface
			eiffel_writer := a_eiffel_writer
			inherit_clause := a_inherit_clause
			finished := False
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
			if (a_feature.result_type /= Void and then not a_feature.result_type.is_empty) and
				(a_feature.arguments = Void or else a_feature.arguments.is_empty)
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
		do
			if a_function_generator.function_renamed then
				inherit_clause.add_rename (a_function_generator.original_name, a_function_generator.changed_name)
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
					a_property_generator.changed_names.after
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
end -- class WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR


