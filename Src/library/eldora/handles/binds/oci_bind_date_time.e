indexing
	description: "Bind Variable of type DATE_TIME"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind_date_time.e $"

class
	OCI_BIND_DATE_TIME

inherit
	OCI_BIND

	OCI_DEFINE_DATE_TIME
		undefine
			handle_type
		end

create
	make

feature -- Basic operations

	set_value (new_value: DATE_TIME) is
			-- Set value of bind-variable to `new_value'
		local
			c, y, mo, d, h, mi, s: INTEGER_8
		do
			c := (new_value.year // 100 + 100).to_integer_8
			y := (new_value.year \\ 100 + 100).to_integer_8
			mo := new_value.month.to_integer_8
			d := new_value.day.to_integer_8
			h := (new_value.hour + 1).to_integer_8
			mi := (new_value.minute + 1).to_integer_8
			s := (new_value.second + 1).to_integer_8;
			
			(buffer + 0).memory_copy ($c, 1)
			(buffer + 1).memory_copy ($y, 1)
			(buffer + 2).memory_copy ($mo, 1)
			(buffer + 3).memory_copy ($d, 1)
			(buffer + 4).memory_copy ($h, 1)
			(buffer + 5).memory_copy ($mi, 1)
			(buffer + 6).memory_copy ($s, 1)			
		end
	
end -- class OCI_BIND_DATE_TIME
