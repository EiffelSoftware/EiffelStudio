indexing
	description: "Create MIDL coclass"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_COCLASS_CREATOR

inherit
	EI_MIDL_COMPONENT_CREATOR

create
	make

feature -- Access

	midl_coclass: EI_MIDL_COCLASS
			-- MIDL coclass

feature -- Basic operations

	create_from_eiffel_class (eiffel_class: EI_CLASS) is
			-- Generate MIDL coclass from 'eiffel_class'.
		local
			interface_creator: EI_MIDL_INTERFACE_CREATOR
		do
			create midl_coclass.make (eiffel_class.name)
			midl_coclass.set_description (eiffel_class.description)

			create interface_creator.make
			interface_creator.create_from_eiffel_class (eiffel_class)
			if interface_creator.succeed then
				midl_coclass.add_interface (interface_creator.midl_interface)
				succeed := True
			end
		end

end -- class EI_MIDL_COCLASS_CREATOR

