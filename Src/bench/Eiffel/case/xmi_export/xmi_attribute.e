indexing
	description: "Information on an attribute of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_ATTRIBUTE

inherit
	XMI_FEATURE

create
	make

feature -- Actions

	code: STRING is
			-- XMI representation of the attribute.
		local
			xmi_class: XMI_CLASS
		do
			Result := "<Foundation.Core.Attribute xmi.id = 'S."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%                  <Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%                  <Foundation.Core.ModelElement.visibility xmi.value = '")
			if is_public then
				Result.append ("public")
			elseif is_protected then
				Result.append ("protected")
			else 
				Result.append ("private")
			end
			Result.append ("'/>%N%
				%                  <Foundation.Core.Feature.ownerScope xmi.value = 'instance'/>%N%
				%                  <Foundation.Core.StructuralFeature.multiplicity>1..1</Foundation.Core.StructuralFeature.multiplicity>%N%
				%                  <Foundation.Core.StructuralFeature.changeable xmi.value = 'none'/>%N%
				%                  <Foundation.Core.StructuralFeature.targetScope xmi.value = 'instance'/>%N%
				%                  <Foundation.Core.Attribute.initialValue>%N%
				%                     <Foundation.Data_Types.Expression>%N%
				%	                      <Foundation.Data_Types.Expression.language></Foundation.Data_Types.Expression.language>%N%
				%                      <Foundation.Data_Types.Expression.body></Foundation.Data_Types.Expression.body>%N%
				%                     </Foundation.Data_Types.Expression>%N%
				%                  </Foundation.Core.Attribute.initialValue>%N%
				%                  <Foundation.Core.StructuralFeature.type>%N")
			xmi_class ?= type
			if xmi_class /= Void then
				Result.append ("                        <Foundation.Core.Class xmi.idref = 'S.")
				Result.append (xmi_class.xmi_id.out)
				Result.append ("'/> <!-- ")
				Result.append (xmi_class.name)
				Result.append (" -->%N")
			else
				Result.append ("                        <Foundation.Core.DataType xmi.idref = 'G.")
				Result.append (type.xmi_id.out)
				Result.append ("'/> <!-- ")
				Result.append (type.name)
				Result.append (" -->%N")
			end
			Result.append ("                  </Foundation.Core.StructuralFeature.type>%N%
				%                </Foundation.Core.Attribute>%N")
		end

end -- class XMI_ATTRIBUTE
