-- Visible routine table to generate

class CECIL1 

inherit

	CECIL_TABLE [FEATURE_I];
	SHARED_DECLARATIONS
		undefine
			copy, setup, consistent, is_equal
		end;
	
feature 

	generate_final (file: INDENT_FILE; type_id: INTEGER) is
			-- Generation of the hash table
		require
			file.is_open_write;
		local
			i: INTEGER;
			routine_name: STRING;
			feat: FEATURE_I;
			c_type: TYPE_C;
			written_class: CLASS_C;
			class_type, written_type: CLASS_TYPE;
			actual_type: TYPE_A;
			formal_type: FORMAL_A
			local_values: like values
		do
			file.putstring ("static char *(*cr");
			file.putint (type_id);
			file.putstring ("[])() = {%N");
			from
				i := 0;
				local_values := values
			until
				i > upper
			loop
				feat := local_values.item (i);
				if 
					(feat = Void) or else 
					feat.is_external or else
					feat.is_deferred
				then
					file.putstring ("(char *(*)()) 0");
				else
					written_class := System.class_of_id (feat.written_in);
					class_type := System.class_type_of_id (type_id);
					if (written_class.generics = Void) then
						written_type := written_class.types.first
					else
						written_type := written_class.meta_type 
											(class_type.type).associated_class_type;
					end;
					routine_name := feat.body_id.feature_name (written_type.id);
debug ("CECIL")
    io.putstring ("Generating entry for feature: ");
    io.putstring (feat.feature_name);
    io.putstring (" of class: ");
    io.putstring (written_type.associated_class.name);
    io.putstring (", encoded name is: ");
    io.putstring (routine_name);
    io.new_line;
end;


					file.putstring ("(char *(*)()) ");
					file.putstring (routine_name);

					actual_type := feat.type.actual_type;
						-- Remember extern declarations
					if actual_type.is_formal then
						formal_type ?= actual_type;
						actual_type := 
							class_type.associated_class.constraint 
												(formal_type.position);
					end; 
					c_type := actual_type.type_i.c_type;
					Extern_declarations.add_routine (c_type, clone (routine_name));
				end;
				file.putstring (",%N");
				i := i + 1;
			end;
			file.putstring ("};%N%N");
		end;

	generate_workbench (file: INDENT_FILE; class_id: CLASS_ID) is
			-- Generate workbench feature id array
		local
			i: INTEGER;
			feat: FEATURE_I;
			local_values: like values
		do
			file.putstring ("uint32 cr");
			file.putint (class_id.id);
			file.putstring ("[] = {%N");
			from
				local_values := values
				i := 0
			until
				i > upper
			loop
				feat := local_values.item (i);
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

	generate_precomp_workbench (file: INDENT_FILE; class_id: CLASS_ID) is
			-- Generate workbench routine id array.
			-- (Used when the class is precompiled.)
		local
			i: INTEGER;
			feat: FEATURE_I;
			local_values: like values
		do
			file.putstring ("uint32 cr");
			file.putint (class_id.id);
			file.putstring ("[] = {%N");
			from
				local_values := values
				i := 0
			until
				i > upper
			loop
				feat := local_values.item (i);
				file.putstring ("(uint32) ");
				if feat = Void then
					file.putchar ('0');
				else
					file.putint (feat.rout_id_set.first.id);
				end;
				file.putstring (",%N");
				i := i + 1
			end;
			file.putstring ("};%N%N");
		end;

	generate_name_table (file: INDENT_FILE; id: CLASS_ID) is
			-- Generate name table in file `file'.
		require
			good_argument: file /= Void;
		local
			i: INTEGER;
			str: STRING;
			feat: FEATURE_I;
			local_copy: like Current
		do
			file.putstring ("char *cl");
			file.putint (id.id);
			file.putstring (" [] = {%N");
			from
				local_copy := Current
				i := 0;
			until
				i > upper
			loop
				str := local_copy.array_item (i);
				if str = Void then
					file.putstring ("(char *) 0");
				else
					file.putchar ('"');
					file.putstring (str);
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
			local_values: like values
		do
			ba.append_integer (upper + 1);
			local_values := values

				-- First names array
			from
				i := 0
			until
				i > upper
			loop
				feat := local_values.item (i);
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
				feat := local_values.item (i);
				if feat = Void then
					ba.append_uint32_integer (0);
				else
					ba.append_uint32_integer (feat.feature_id);
				end;
				i := i + 1
			end;
		end;

feature -- Concurrent Eiffel

	generate_separate_pattern_id_table (file: INDENT_FILE; type_id: INTEGER) is
			-- Generation of the hash table
		require
			file.is_open_write;
		local
			i: INTEGER;
			feat: FEATURE_I;
			written_class: CLASS_C;
			class_type, written_type: CLASS_TYPE;
			local_values: like values
		do
			file.putstring ("static EIF_INTEGER cpatid");
			file.putint (type_id);
			file.putstring ("[] = {%N");
			from
				local_values := values
				i := 0;
			until
				i > upper
			loop
				feat := local_values.item (i);
				if 
					(feat = Void) or else 
					feat.is_external or else
					feat.is_deferred
				then
					file.putstring ("-1");
				else
					written_class := System.class_of_id (feat.written_in);
					class_type := System.class_type_of_id (type_id);
					if (written_class.generics = Void) then
						written_type := written_class.types.first
					else
						written_type := written_class.meta_type 
											(class_type.type).associated_class_type;
					end;
					file.putint (system.pattern_table.c_pattern_id(feat.pattern_id, written_type.type));
				end;
				file.putstring (",%N");
				i := i + 1;
			end;
			file.putstring ("};%N%N");
		end;

end
