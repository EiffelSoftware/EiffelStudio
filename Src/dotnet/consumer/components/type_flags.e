indexing
	description: "Type flags"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_FLAGS

feature -- Access

	Is_class: INTEGER is 0
	Is_interface: INTEGER is 1
	Is_enum: INTEGER is 2
	Is_delegate: INTEGER is 3
	Is_value_type: INTEGER is 4

end -- class TYPE_FLAGS
