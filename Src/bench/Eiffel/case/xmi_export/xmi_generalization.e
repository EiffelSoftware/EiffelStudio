indexing
	description: "Information on a relation of inheritance for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_GENERALIZATION

inherit
	XMI_ITEM

create 
	make

feature --Initialization

	make (id: INTEGER; sub, super: XMI_CLASS) is
			-- Initialization of `Current'
			-- assign `id' to `xmi_id'
			-- adds `Current' in `generalizations` field of the two classes involved.
		do
			subtype := sub
			supertype := super
			xmi_id := id
			subtype.add_generalization (Current)
			supertype.add_generalization (Current)
		end

feature -- Access

	subtype: XMI_CLASS
			-- Class which inherits from `supertype'.	

	supertype: XMI_CLASS
			-- Class from which inherits `subtype'.

	enclosing_cluster: CLUSTER_I is
			-- If exists, common cluster of `subtype' and `supertype'
			-- Void otherwise.
		local
			c: CLUSTER_I
		do
			c := subtype.compiled_class.cluster
			if c = supertype.compiled_class.cluster then
				Result := c
			else
				Result := Void
			end
		end

feature -- Action

	code: STRING is
			-- XMI representation of the generalization.
		do
			Result := "<Foundation.Core.Generalization xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				 %        <Foundation.Core.ModelElement.name></Foundation.Core.ModelElement.name>%N%
				 %        <Foundation.Core.ModelElement.visibility xmi.value = 'public'/>%N%
				 %       <Foundation.Core.Generalization.discriminator></Foundation.Core.Generalization.discriminator>%N%
				 %       <Foundation.Core.Generalization.subtype>%N%
				 %         <Foundation.Core.Class xmi.idref = 'S.")
			Result.append (subtype.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (subtype.name)
			Result.append (" -->%N%
				%</Foundation.Core.Generalization.subtype>%N%
				%<Foundation.Core.Generalization.supertype>%N%
				%<Foundation.Core.Class xmi.idref = 'S.")
			Result.append (supertype.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (supertype.name)
			Result.append (" -->%N% 
				%</Foundation.Core.Generalization.supertype>%N%
				%</Foundation.Core.Generalization>%N")

		end

end -- class XMI_GENERALIZATION
