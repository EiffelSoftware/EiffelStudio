indexing
	description: "Test IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_DESCRIPTOR_TESTER

inherit
	COMPILER_TESTER_SHARED
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Implementation

	make (a_interface: like cluster_descriptor_interface) is
			-- create a test for `IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE'
		require
			non_void_interface: a_interface /= Void
		do
			cluster_descriptor_interface := a_interface
			display_current_properties
		end

feature {NONE} -- Output

	display_current_properties is
			-- display current cluster descriptors properties
		do
			put_String ("%N  Current Properties")
			put_string ("%N    class_count=")
			put_int (cluster_descriptor_interface.class_count)
			put_string ("%N    classes=")
			display_classes (cluster_descriptor_interface.classes)
			put_string ("%N    cluster_count=")
			put_int (cluster_descriptor_interface.cluster_count)
			put_string ("%N    cluster_path=")
			put_string (cluster_descriptor_interface.cluster_path)
			put_string ("%N    clusters=")
			display_clusters (cluster_descriptor_interface.clusters)
			put_string ("%N    description=")
			put_string (cluster_descriptor_interface.description)
			put_string ("%N    is_library=")
			put_bool (cluster_descriptor_interface.is_library)
			put_string ("%N    is_override_cluster=")
			put_bool (cluster_descriptor_interface.is_override_cluster)
			put_string ("%N    name=")
			put_string (cluster_descriptor_interface.name)
			put_string ("%N    relative_path=")
			put_string (cluster_descriptor_interface.relative_path)
			put_string ("%N    tool_tip=")
			put_string (cluster_descriptor_interface.tool_tip)
		end
		
	display_clusters (a_interface: IENUM_CLUSTER_INTERFACE) is
			-- display a list of features
		local
			l_index: INTEGER
			l_feature: CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
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
		
feature {NONE} -- Implementation

	cluster_descriptor_interface: IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE

invariant
	non_void_interface: cluster_descriptor_interface /= Void

end -- cluster CLUSTER_DESCRIPTOR_TESTER
