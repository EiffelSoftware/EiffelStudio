indexing
	description: "Information on a cluster of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CLUSTER

inherit
	XMI_ITEM

create 
	make

feature --Initialization

	make (id: INTEGER; id_ext: INTEGER; c: CLUSTER_I) is
			-- Initialization of `Current'
			-- assign `c' to `lace_cluster'
			-- assign `id_ext' to `id_extender'
			-- assign `id' to `xmi_id'.
		do
			create xmi_classes.make
			lace_cluster := c
			xmi_id := id
			id_extender := id_ext
		end

feature -- Access

	xmi_classes: LINKED_LIST[XMI_CLASS]
		-- XMI representations of the classes included in `Current'.

	lace_cluster: CLUSTER_I
		-- Cluster from which `Current' is a representation.

	id_extender: INTEGER
		-- Number identifying the Rose model element where `Current' is represented.

feature -- Element change

	add_class (c: XMI_CLASS) is
			-- Adds `c' to `xmi_classes'.
		require
			new_class_not_void: c /= Void
		do
			xmi_classes.extend (c)
		ensure
			new_class_added: xmi_classes.has (c)
		end

feature -- Actions

	code: STRING is
			-- XMI representation of the cluster.	
		do
			Result := " <Model_Management.Package xmi.id = 'S."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
          		%	<Foundation.Core.ModelElement.name>")
			Result.append (lace_cluster.name_in_upper)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%  <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%  <Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%  <Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'false'/>%N%
				%  <Foundation.Core.GeneralizableElement.isAbstract xmi.value = 'false'/>%N%
				%  <XMI.extension xmi.extender = 'Unisys.IntegratePlus.2'>%N%
				%    <XMI.reference xmi.idref = 'G.")
			Result.append (id_extender.out)
			Result.append ("'/>%N%
				%  </XMI.extension>%N%
				%  <Foundation.Core.ModelElement.namespace>%N%
				%    <Model_Management.Model xmi.idref = 'G.1'/> <!-- empty -->%N%
				%  </Foundation.Core.ModelElement.namespace>%N%
				%  <Foundation.Core.Namespace.ownedElement>%N")

			from 
				xmi_classes.start
			until
				xmi_classes.after
			loop
				Result.append (xmi_classes.item.code)
				xmi_classes.forth
			end
		
			Result.append ("</Foundation.Core.Namespace.ownedElement>%N%
				%</Model_Management.Package>  <!-- End Package S.")
			Result.append (xmi_id.out)
			Result.append (" -->%N")
		end	

end -- class XMI_CLUSTER
