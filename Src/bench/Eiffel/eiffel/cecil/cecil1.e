-- Visible routine table to generate

class CECIL1 

inherit

	CECIL_TABLE [FEATURE_I];
	SHARED_DECLARATIONS
		undefine
			twin
		end;
	
feature 

	generate_final (file: UNIX_FILE; type_id: INTEGER) is
			-- Generation of the hash table
		require
			file.is_open_write;
		local
			i: INTEGER;
			routine_name: STRING;
			feat: FEATURE_I;
			c_type: TYPE_C;
			class_type: CLASS_TYPE;
			actual_type: TYPE_A
		do
			file.putstring ("static char *(*cr");
			file.putint (type_id);
			file.putstring ("[])() = {%N");
			from
				i := 0;
			until
				i > upper
			loop
				feat := values.item (i);
				if feat = Void then
					file.putstring ("(char *(*)()) 0");
				else
					class_type := System.class_type_of_id (type_id);
					routine_name := Encoder.feature_name
										(class_type.id, feat.body_id);
					file.putstring ("(char *(*)()) ");
					file.putstring (routine_name);

					actual_type := feat.type.actual_type;
						-- Remember extern declarations
					if actual_type.is_formal then
						actual_type := 
							class_type.associated_class.constraint 
												(actual_type.base_type);
					end; 
					c_type := actual_type.type_i.c_type;
					Extern_declarations.add_routine (c_type, routine_name.twin);
				end;
				file.putstring (",%N");
				i := i + 1;
			end;
			file.putstring ("};%N%N");
		end;

	generate_workbench (file: UNIX_FILE; class_id: INTEGER) is
			-- Generate workbench feature id array
		local
			i: INTEGER;
			feat: FEATURE_I;
		do
			file.putstring ("uint32 cr");
			file.putint (class_id);
			file.putstring ("[] = {%N");
			from
				i := 0
			until
				i > upper
			loop
				feat := values.item (i);
				file.putstring ("(uint32) ");
				if feat = Void then
					file.putchar ('0');
				else
					file.putint (feat.feature_id);
				end;
				file.putstring (",%N");
				i := i + 1
			end;
			file.putstring ("};%N%N");
		end;

	generate_name_table (file: UNIX_FILE; id: INTEGER) is
			-- Generate name table in file `file'.
		require
			good_argument: file /= Void;
		local
			i: INTEGER;
			str: STRING;
			feat: FEATURE_I;
		do
			file.putstring ("char *cl");
			file.putint (id);
			file.putstring (" [] = {%N");
			from
				i := 0;
			until
				i > upper
			loop
				str := array_item (i);
				if str = Void then
					file.putstring ("(char *) 0");
				else
					file.putchar ('"');
					file.putstring (array_item (i));
					file.putstring ("%"");
				end;
				file.putstring (",%N");
				i := i + 1;
			end;
			file.putstring ("};%N%N");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for current cecil table.
		require
			good_argument: ba /= Void;
		local
			i: INTEGER;
			feat: FEATURE_I;
		do
			ba.append_integer (upper + 1);

				-- First names array
			from
				i := 0
			until
				i > upper
			loop
				feat := values.item (i);
				if feat = Void then
					ba.append_short_integer (0);
				else
					ba.append_string (feat.feature_name);
				end;
				i := i + 1
			end;
				-- Second feature id array
			from
				i := 0
			until
				i > upper
			loop
				feat := values.item (i);
				if feat = Void then
					ba.append_uint32_integer (0);
				else
					ba.append_uint32_integer (feat.feature_id);
				end;
				i := i + 1
			end;
		end;

end
