indexing
	description: "Facilities for browsing through a system"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_BROWSER

inherit
	IEIFFEL_SYSTEM_BROWSER_IMPL_STUB
		redefine
			system_classes,
			class_count,
			system_clusters,
			cluster_count,
			class_descriptor,
			feature_descriptor,
			cluster_descriptor
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
		end
		
feature -- Access

	system_classes: ECOM_ARRAY [STRING] is
			-- List of classes in system.
		local
			res: ARRAY [STRING]
			classes: ARRAY [CLASS_C]
			i: INTEGER
		do
			if Eiffel_project.initialized then
				classes := Eiffel_system.Workbench.system.classes.sorted_classes
				create res.make (1, Eiffel_system.Workbench.system.classes.count)
				from
					i := 1
				until
					i > res.count
				loop
					res.put (classes.item (i).name, i)
					i := i + 1
				end
				create Result.make_from_array (res, 1, <<1>>, <<res.count>>)
			end
		end

	class_count: INTEGER is
			-- Number of classes in system.
		do
			if Eiffel_project.initialized then
				Result := Eiffel_system.Workbench.system.classes.count
			end
		end

	system_clusters: ECOM_ARRAY [STRING] is
			-- List of system's top-level clusters.
		local
			list: LINKED_LIST [CLUSTER_I]
			res: ARRAY [STRING]
			i: INTEGER
		do
			if Eiffel_project.initialized then
				list := Eiffel_universe.clusters
				create res.make (1,1)
				from
					list.start
					i := 1
				until
					list.after
				loop
					if list.item.parent_cluster = Void then
						res.force (list.item.cluster_name, i)
						i := i + 1
					end
					list.forth
				end
				create Result.make_from_array (res, 1, <<1>>, <<res.count>>)
			end
		end
		
	cluster_count: INTEGER is
			-- Number of top-level clusters in system.
		do
			if Eiffel_project.initialized then
				Result := system_clusters.count
			end
		end
		
feature -- Basic Operations

	cluster_descriptor (cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
			-- Void if no matches.
		local
			ci: CLUSTER_I
		do
			if Eiffel_project.initialized and then cluster_name /= Void then
				ci := Eiffel_universe.cluster_of_name (cluster_name)
				if ci /= Void then
					create {CLUSTER_DESCRIPTOR} Result.make_with_cluster_i (ci)
				end
			end
		end

	class_descriptor (class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
			-- Void if no matches.
		local
			matching_classes: LINKED_LIST [CLASS_I]
		do
			if Eiffel_project.initialized and then class_name1 /= Void then
				matching_classes := Eiffel_universe.compiled_classes_with_name (class_name1)
				if not matching_classes.is_empty then
						--| FIXME What if matching_classes.count > 1 ?
					if matching_classes.first.compiled then
						create {CLASS_DESCRIPTOR} Result.make_with_class_i (matching_classes.first)
					end
				end
			end
		end

	feature_descriptor (class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
			-- Void if no matches.
		local
			class_desc: CLASS_DESCRIPTOR
		do
			if Eiffel_project.initialized then
				class_desc ?= class_descriptor (class_name1)
				if class_desc /= Void then
					Result := class_desc.feature_with_name (feature_name)
				end
			end
		end
		
end -- class SYSTEM_BROWSER
