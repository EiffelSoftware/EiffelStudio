class OPTION_I 
	
feature -- Property

	is_yes: BOOLEAN is
			-- Is the option `yes'?
		do
		end;

	byte_code: CHARACTER is 
		once
			Result := 'n'
		end;

feature -- Output

	generate (file: INDENT_FILE) is
			-- Generate assertion value in `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		do
			file.putstring ("(int16) 0");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code representation of the assertion
		do
debug ("OPTIONS");
	io.error.putstring ("Make byte code: ");
	io.error.putchar (byte_code);
	io.error.new_line;
end;
			ba.append (byte_code)
		end;

end -- class OPTION_I
