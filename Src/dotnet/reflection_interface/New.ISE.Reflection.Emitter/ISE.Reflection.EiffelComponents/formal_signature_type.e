indexing
	description: "Formal signature type"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	FORMAL_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE

create 
	make

feature -- Access

	generic_parameter_index: INTEGER
		indexing
			description: "Generic parameter index"
		end

feature -- Status Setting

	set_generic_parameter_index (an_index: like generic_parameter_index) is
		indexing
			description: "Set `generic_parameter_index' with `an_index'."
		do
			generic_parameter_index := an_index
		ensure
			index_set: generic_parameter_index = an_index
		end
		
end -- class FORMAL_SIGNATURE_TYPE
