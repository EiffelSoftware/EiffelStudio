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

	generate (buffer: GENERATION_BUFFER) is
			-- Generate assertion value in `buffer'.
		require
			good_argument: buffer /= Void;
		do
			buffer.put_string ("(int16) 0");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code representation of the assertion
		do
debug ("OPTIONS");
	io.error.put_string ("Make byte code: ");
	io.error.put_character (byte_code);
	io.error.put_new_line;
end;
			ba.append (byte_code)
		end;

end -- class OPTION_I
