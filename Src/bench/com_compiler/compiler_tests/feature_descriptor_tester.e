indexing
	description: "Test IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_DESCRIPTOR_TESTER

inherit
	COMPILER_TESTER_SHARED
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Implementation

	make (a_interface: like feature_descriptor_interface) is
			-- create a test for `IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE'
		require
			non_void_interface: a_interface /= Void
		do
			feature_descriptor_interface := a_interface
			display_current_properties
		end

feature {NONE} -- Output

	display_current_properties is
			-- display current feature descriptors properties
		local
			l_file_path: CELL [STRING]
			l_line_number: INTEGER_REF
		do
			put_string ("%N  all_callers_count=")
			put_int (feature_descriptor_interface.all_callers_count)
			put_string ("%N  all_callers=")
			display_features (feature_descriptor_interface.all_callers)
			put_string ("%N  ancestor_version_count=")
			put_int (feature_descriptor_interface.ancestor_version_count)
			put_string ("%N  ancestor_versions=")
			display_features (feature_descriptor_interface.ancestor_versions)			
			put_string ("%N  descendant_callers_count=")
			put_int (feature_descriptor_interface.descendant_callers_count)
			put_string ("%N  descendant_callers=")
			display_features (feature_descriptor_interface.descendant_callers)
			put_string ("%N  descendant_version_count=")
			put_int (feature_descriptor_interface.descendant_version_count)
			put_string ("%N  descendant_versions=")
			display_features (feature_descriptor_interface.descendant_versions)
			put_string ("%N  description=")
			put_string (feature_descriptor_interface.description)
			put_string ("%N  evaluated_class=")
			put_string (feature_descriptor_interface.evaluated_class)
			put_string ("%N  exported_to_all=")
			put_bool (feature_descriptor_interface.exported_to_all)
			put_string ("%N  external_name=")
			put_string (feature_descriptor_interface.external_name)
			put_string ("%N  feature_location=")
			create l_file_path.put (Void)
			l_line_number := 0
			--feature_descriptor_interface.feature_location (l_file_path, l_line_number)
			put_string ("(")
			put_int (l_line_number.item)
			put_string (") ")
			put_string (l_file_path.item)
			put_string ("%N  has_postcondition=")
			put_bool (feature_descriptor_interface.has_postcondition)
			put_string ("%N  has_precondition=")
			put_bool (feature_descriptor_interface.has_precondition)
			put_string ("%N  implementer_count=")
			put_int (feature_descriptor_interface.implementer_count)
			put_string ("%N  implementers=")
			display_features (feature_descriptor_interface.implementers)
			put_string ("%N  is_attribute=")
			put_bool (feature_descriptor_interface.is_attribute)
			put_string ("%N  is_constant=")
			put_bool (feature_descriptor_interface.is_constant)
			put_string ("%N  is_deferred=")
			put_bool (feature_descriptor_interface.is_deferred)
			put_string ("%N  is_external=")
			put_bool (feature_descriptor_interface.is_external)
			put_string ("%N  is_frozen=")
			put_bool (feature_descriptor_interface.is_frozen)
			put_string ("%N  is_function=")
			put_bool (feature_descriptor_interface.is_function)
			put_string ("%N  is_infix=")
			put_bool (feature_descriptor_interface.is_infix)
			put_string ("%N  is_obsolete=")
			put_bool (feature_descriptor_interface.is_obsolete)
			put_string ("%N  is_once=")
			put_bool (feature_descriptor_interface.is_once)
			put_string ("%N  is_prefix=")
			put_bool (feature_descriptor_interface.is_prefix)
			put_string ("%N  is_procedure=")
			put_bool (feature_descriptor_interface.is_procedure)
			put_string ("%N  is_unique=")
			put_bool (feature_descriptor_interface.is_unique)
			put_string ("%N  local_callers_count=")
			put_int (feature_descriptor_interface.local_callers_count)
			put_string ("%N  local_callers=")
			display_features (feature_descriptor_interface.local_callers)
			put_string ("%N  parameters=")
			display_parameters (feature_descriptor_interface.parameters)
			put_string ("%N  return_type=")
			put_string (feature_descriptor_interface.return_type)
			put_string ("%N  written_class=")
			put_string (feature_descriptor_interface.written_class)
		end
		
	display_features (a_interface: IENUM_FEATURE_INTERFACE) is
			-- display a list of features
		local
			l_index: INTEGER
			l_feature: CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			if a_interface /= Void then
				put_string ("%N    Feature Count: ")
				put_int (a_interface.count)
				from
					l_index := 1
				until
					l_index > a_interface.count
				loop
					create l_feature.put (Void)
					a_interface.ith_item (l_index, l_feature)
					put_string ("%N      ")
					put_string (l_feature.item.written_class)
					put_string (": ")
					put_string (l_feature.item.name)
					l_index := l_index + 1
				end
			else
				put_string (Void)
			end
		end
		
	display_parameters (a_interface: IENUM_PARAMETER_INTERFACE) is
			-- display a list of feature parameters
		local
			l_index: INTEGER
			l_parameter: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]
		do
			if a_interface /= Void then
				put_string ("%N    Parameter Count: ")
				put_int (a_interface.count)
				from
					l_index := 1
				until
					l_index > a_interface.count
				loop
					create l_parameter.put (Void)
					a_interface.ith_item (l_index, l_parameter)
					put_string ("%N      ")
					put_string (l_parameter.item.name)
					put_string (": ")
					put_string (l_parameter.item.display)
					l_index := l_index + 1
				end
			else
				put_string (Void)
			end
		end
		
		
feature {NONE} -- Implementation

	feature_descriptor_interface: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE

invariant
	non_void_interface: feature_descriptor_interface /= Void

end -- class FEATURE_DESCRIPTOR_TESTER
