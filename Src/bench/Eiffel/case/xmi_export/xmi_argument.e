indexing
	description: "Information on an argument of a feature in the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_ARGUMENT

inherit
	XMI_FEATURE

create
	make

feature -- Actions

	code: STRING is
			-- XMI representation of the argument.
		local
			xmi_class: XMI_CLASS
		do
			Result := "<Foundation.Core.Parameter xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%                      <Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%                      <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%                      <Foundation.Core.Parameter.defaultValue>%N%
				%                         <Foundation.Data_Types.Expression>%N%
				%                          <Foundation.Data_Types.Expression.language></Foundation.Data_Types.Expression.language>%N%
				%                          <Foundation.Data_Types.Expression.body></Foundation.Data_Types.Expression.body>%N%
				%                         </Foundation.Data_Types.Expression>%N%
				%                      </Foundation.Core.Parameter.defaultValue>%N%
				%                      <Foundation.Core.Parameter.kind xmi.value = 'inout'/>%N%
				%                      <Foundation.Core.Parameter.type>%N")
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

			Result.append ("                      </Foundation.Core.Parameter.type>%N%
				%                    </Foundation.Core.Parameter>%N")
		end

end -- class XMI_ARGUMENT
