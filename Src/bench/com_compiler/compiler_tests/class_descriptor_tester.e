indexing
	description: "Test IEIFFEL_CLASS_DESCRIPTOR_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DESCRIPTOR_TESTER

inherit
	COMPILER_TESTER_SHARED
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Implementation

	make (a_interface: like class_descriptor_interface) is
			-- create a test for `IEIFFEL_CLASS_DESCRIPTOR_INTERFACE'
		require
			non_void_interface: a_interface /= Void
		do
			class_descriptor_interface := a_interface
			display_current_properties
		end

feature {NONE} -- Output

	display_current_properties is
			-- display current class descriptors properties
		do
			put_String ("%N  Current Properties")
			put_string ("%N    ancestor_count=")
			put_int (class_descriptor_interface.ancestor_count)
			put_string ("%N    ancestors=")
			display_classes (class_descriptor_interface.ancestors)
			put_string ("%N    class_path=")
			put_string (class_descriptor_interface.class_path)
			put_string ("%N    client_count=")
			put_int (class_descriptor_interface.client_count)
			put_string ("%N    clients=")
			display_classes (class_descriptor_interface.clients)
			put_string ("%N    creation_routine_count=")
			put_int (class_descriptor_interface.creation_routine_count)
			put_string ("%N    creation_routines=")
			display_features (class_descriptor_interface.creation_routines)
			put_string ("%N    descendant_count=")
			put_int (class_descriptor_interface.descendant_count)
			put_string ("%N    descendants=")
			display_classes (class_descriptor_interface.descendants)
			put_string ("%N    description=")
			put_string (class_descriptor_interface.description)
			put_string ("%N    external_name=")
			put_string (class_descriptor_interface.external_name)
			put_string ("%N    feature_count=")
			put_int (class_descriptor_interface.feature_count)
			put_string ("%N    feature_names=")
			display_feature_names (class_descriptor_interface.feature_names)
			put_string ("%N    features=")
			display_features (class_descriptor_interface.features)
			put_string ("%N    flat_feature_count=")
			put_int (class_descriptor_interface.flat_feature_count)
			put_string ("%N    flat_features=")
			display_features (class_descriptor_interface.flat_features)
			put_string ("%N    inherited_feature_count=")
			put_int (class_descriptor_interface.inherited_feature_count)
			put_string ("%N    inherited_features=")
			display_features (class_descriptor_interface.inherited_features)
			put_string ("%N    is_deferred=")
			put_bool (class_descriptor_interface.is_deferred)
			put_string ("%N    is_external=")
			put_bool (class_descriptor_interface.is_external)
			put_string ("%N    is_generic=")
			put_bool (class_descriptor_interface.is_generic)
			put_string ("%N    is_in_system=")
			put_bool (class_descriptor_interface.is_in_system)
			put_string ("%N    is_library=")
			put_bool (class_descriptor_interface.is_library)
			put_string ("%N    name=")
			put_string (class_descriptor_interface.name)
			put_string ("%N    supplier_count=")
			put_int (class_descriptor_interface.supplier_count)
			put_string ("%N    suppliers=")
			display_classes (class_descriptor_interface.suppliers)
			put_string ("%N    tool_tip=")
			put_string (class_descriptor_interface.tool_tip)
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
		
	display_classes (a_interface: IENUM_EIFFEL_CLASS_INTERFACE) is
			-- display a list of classes
		local
			l_index: INTEGER
			l_class: CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
		do
			if a_interface /= Void then
				put_string ("%N    Class Count: ")
				put_int (a_interface.count)
				from
					l_index := 1
				until
					l_index > a_interface.count
				loop
					create l_class.put (Void)
					a_interface.ith_item (l_index, l_class)
					put_string ("%N      ")
					put_string (l_class.item.name)
					l_index := l_index + 1
				end
			else
				put_string (Void)
			end
		end
		
	display_feature_names (a_feature_names: ECOM_ARRAY [STRING]) is
			-- display a list of feature names
		local
			l_index: INTEGER
		do
			if a_feature_names /= Void then
				put_string ("%N    Feature Name Count: ")
				put_int (a_feature_names.count)
				from
					l_index := 1
				until
					l_index > a_feature_names.count
				loop
					put_string ("%N      ")
					put_string (a_feature_names.item (<<l_index>>))
					l_index := l_index + 1
				end
			else
				put_string (Void)
			end
		end
		
feature {NONE} -- Implementation

	class_descriptor_interface: IEIFFEL_CLASS_DESCRIPTOR_INTERFACE

invariant
	non_void_interface: class_descriptor_interface /= Void

end -- class CLASS_DESCRIPTOR_TESTER
