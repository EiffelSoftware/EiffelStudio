indexing
	description: "Representation of a value that cannot be pre-computed."
	date: "$Date$"
	revision: "$Revision$"

class
	NO_VALUE_I

inherit
	VALUE_I
		redefine
			is_no_value
		end
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to current?
			-- False since no value cannot be compared.
		do
			Result := False
		end

feature -- Status report

	is_no_value: BOOLEAN is True
			-- Current is a no value.

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is current value compatible with `t'?
		do
			check
				not_callable: False
			end
		ensure
			not_called: False
		end
		
feature -- Generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate current value in `buffer'.
		do
			check
				not_callable: False
			end
		ensure
			not_called: False
		end
		
	generate_il is
			-- Generate IL code for constant value.
		do
			check
				not_callable: False
			end
		ensure
			not_called: False
		end
		
	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a constant value.
		do
			check
				not_callable: False
			end
		ensure
			not_called: False
		end

feature -- Debug

	dump: STRING is
			-- Dump value.
		do
			check
				not_callable: False
			end
		ensure
			not_called: False
		end
	
end -- class NO_VALUE_I
