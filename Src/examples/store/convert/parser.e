class PARSER

inherit

	EC_TYPES

create

	make 

feature 

	make is
		do
			create descriptor.make;
			create book.make;
			create converter1.make;
			create converter2.make;
			execute
		end

feature {NONE}

	descriptor: EC_DESCRIPTOR;

	book: BOOK;

	converter1, converter2: CONVERTER;

	execute is
		local
			i:INTEGER
		do
			io.putstring ("First example file:%N");
			descriptor.make_conform (book);
			converter1.set_descriptor (descriptor);
			converter1.set_file_name ("example1.dat");
			converter1.parse_file;
			if converter1.conv_error then 
				io.putstring (converter1.conv_message)
			else
				from
					i:=1 
				until 
					i > converter1.container_size
				loop
					print (converter1.container.item (i));
					i := i +1 
				end
			end;
			io.putstring ("Second example file:%N");
			descriptor.ecd_clear;
			descriptor.set_field ("still_published", Boolean_ttype);
			descriptor.set_delimiters('(', ')');
			descriptor.set_use_label (False);
			descriptor.set_field ("author", String_ttype);
			descriptor.set_field ("title", String_ttype);
			descriptor.set_use_label (False);
			descriptor.set_field ("quantity", Integer_ttype);
			descriptor.set_label_separator('/');
			descriptor.set_field ("price", Real_ttype);
			descriptor.set_use_label(False);
			descriptor.set_field_separator ('$');
			descriptor.check_conformity (book);
			if descriptor.ecd_error then
				io.putstring (descriptor.ecd_message)
			else
				converter2.set_descriptor (descriptor);
				converter2.set_file_name ("example2.dat");
				converter2.parse_file;
				if converter2.conv_error then 
					io.putstring (converter2.conv_message)
				else
					from
						i:=1 
					until 
						i > converter2.container_size
					loop
						print (converter2.container.item (i));
						i := i +1 
					end
				end
			end
		end

end -- class PARSER


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

