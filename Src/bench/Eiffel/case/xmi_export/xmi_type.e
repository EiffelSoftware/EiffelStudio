indexing
	description: "Information on a type of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_TYPE

inherit
	XMI_ITEM
		redefine 
			is_equal
		end

create 
	make_type

feature --Initialization

	make_type (id: INTEGER; n: STRING) is
			-- Initialization of `Current'.
		do
			create associations.make
			xmi_id := id
			name := n
		end

feature -- Access

	name: STRING
			-- Name of the type represented by `Current'.

	associations: LINKED_LIST [XMI_ASSOCIATION]
			-- List of associations to which Current belongs

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same name as `Current'?
		do
			Result := name.is_equal (other.name)
		end

feature -- Status Setting

	add_association (a_association: XMI_ASSOCIATION) is
			-- Add 'a_association' to associations
		require
			a_association /= Void
		do
			if not associations.has (a_association) then
				associations.extend (a_association)
			end
		end

feature -- Action 

	code: STRING is
			-- XMI representation of the code.
		do
			Result := "<Foundation.Core.DataType xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'> %N%
				%          <Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%          <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%          <Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isAbstract xmi.value = 'false'/>%N%
				%        </Foundation.Core.DataType>%N")
		end

end -- class XMI_TYPE
