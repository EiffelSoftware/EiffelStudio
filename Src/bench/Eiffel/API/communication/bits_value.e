class BITS_VALUE

inherit
	DEBUG_VALUE

creation
	make

feature

	append_value (cw: CLICK_WINDOW) is 
		local
			os: OBJECT_STONE
		do 
			cw.put_string ("BITS ");
			cw.put_int (size);
			cw.put_string (" [");
			!! os.make (reference.out);
			cw.put_clickable_string (os, reference.out);
			cw.put_string ("]")
		end;

	reference: POINTER;
	size: INTEGER;

	make (ref: like reference; s: like size) is
		do
			reference := ref;
			size := s;
		end

end

