-- Meta-type size

class SHARED_SIZE

feature {NONE}

	Char_size: INTEGER is
			-- Size of a character
		once
			Result := c_char_size;
		end;

	Long_size: INTEGER is
            -- Size of a long integer
        once
            Result := c_long_size;
        end;

	Float_size: INTEGER is
            -- Size of a float
        once
            Result := c_float_size;
        end;

	Double_size: INTEGER is
            -- Size of a double
        once
            Result := c_double_size;
        end;

	Pointer_size: INTEGER is
			-- Size of a function pointer
		once
			Result := c_pointer_size;
		end;

	Reference_size: INTEGER is
			-- Size of a reference
		once
			Result := c_reference_size;
		end;

feature {NONE} -- External features

	c_char_size: INTEGER is
		external
			"C"
		end;

	c_reference_size: INTEGER is
		external
			"C"
		end;

	c_pointer_size: INTEGER is
		external
			"C"
		end;

	c_double_size: INTEGER is
		external
			"C"
		end;

	c_float_size: INTEGER is
		external
			"C"
		end;

	c_long_size: INTEGER is
		external
			"C"
		end;

end
