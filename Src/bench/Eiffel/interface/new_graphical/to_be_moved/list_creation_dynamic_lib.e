indexing

	description:
		"Popup a list of all valid creation procedures for a dynamic lib. %
		%This functionality has been integrated into the EB_DYNAMIC_LIB_WINDOW %
		%in the new interface and is not needed here any more.%
		%This class is here only for backward compatibility."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_CREATION_DYNAMIC_LIB

creation
	make

feature -- Initialization

	make (d_cl: CLASS_C; d_r: E_FEATURE; d_i: INTEGER; d_a, d_c: STRING) is
		do
--			init (Project_tool)
			d_class := d_cl
			d_routine := d_r
			d_index := d_i
			d_alias := d_a
			d_call_type := d_c
		end

feature -- Properties

	d_class: CLASS_C
	d_routine: E_FEATURE
	d_index: INTEGER
	d_alias, d_call_type: STRING

feature -- Interface

	choose_creation is
		do
		end

feature {NONE} -- Execution

end -- class LIST_CREATION_DLL

