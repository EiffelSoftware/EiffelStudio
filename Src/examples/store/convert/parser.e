indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PARSER


