indexing
	description: "Hash table of visible routines."
	date: "$Date$"
	revision: "$Revision$"

class CECIL_ROUTINE_TABLE 

inherit
	CECIL_TABLE [FEATURE_I]
	
	SHARED_DECLARATIONS
		undefine
			copy, is_equal
		end

create
	init

feature -- C code generation

	generate_final (buffer: GENERATION_BUFFER; a_class_type: CLASS_TYPE) is
			-- Generation of the hash table
		local
			i, nb: INTEGER;
			routine_name: STRING;
			feat: FEATURE_I;
			c_type: TYPE_C;
			written_class: CLASS_C;
			written_type: CLASS_TYPE;
			actual_type: TYPE_A;
			formal_type: FORMAL_A
			gen_type_a: GEN_TYPE_A
			l_values: like values
		do
			buffer.putstring ("static char *(*cr");
			buffer.putint (a_class_type.type_id);
			buffer.putstring ("[])() = {%N");
			from
				i := 0;
				nb := capacity - 1
				l_values := values
			until
				i > nb
			loop
				feat := l_values.item (i);
				if (feat = Void) or else feat.is_external or else feat.is_deferred then
					buffer.putstring ("(char *(*)()) 0");
				else
					if feat.is_constant and then not feat.is_once then
							-- A non-string constant has always its feature generated in
							-- visible class.
						written_class := System.class_of_id (a_class_type.associated_class.class_id)
					else
						written_class := System.class_of_id (feat.written_in);
					end
					written_type := written_class.meta_type (a_class_type.type).associated_class_type
					routine_name := Encoder.feature_name (written_type.static_type_id, feat.body_index);
debug ("CECIL")
    io.putstring ("Generating entry for feature: ");
    io.putstring (feat.feature_name);
    io.putstring (" of class: ");
    io.putstring (written_type.associated_class.name);
    io.putstring (", encoded name is: ");
    io.putstring (routine_name);
    io.new_line;
end;


					buffer.putstring ("(char *(*)()) ");
					buffer.putstring (routine_name);

						-- Remember extern declarations
					actual_type := feat.type.actual_type;
					if actual_type.is_formal then
							-- If `actual_type' is a formal parameter, it means that the
							-- current class declaration is a generic class and therefore
							-- `gen_type_a' cannot be Void (enforced by a check statement).
						formal_type ?= actual_type
						gen_type_a ?= a_class_type.type.type_a
						check
							gen_type_a_exists: gen_type_a /= Void
						end
						actual_type := gen_type_a.generics.item (formal_type.position)
					end; 
					c_type := actual_type.type_i.c_type;
					Extern_declarations.add_routine (c_type, routine_name);
				end;
				buffer.putstring (",%N");
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_workbench (buffer: GENERATION_BUFFER; class_id: INTEGER) is
			-- Generate workbench feature id array
		local
			i, nb: INTEGER;
			feat: FEATURE_I;
			l_values: like values
		do
			buffer.putstring ("uint32 cr");
			buffer.putint (class_id);
			buffer.putstring ("[] = {%N");
			from
				l_values := values
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				feat := l_values.item (i);
				buffer.putstring ("(uint32) ");
				if feat = Void then
					buffer.putchar ('0');
				else
					buffer.putint (feat.feature_id);
				end;
				buffer.putstring (",%N");
				i := i + 1
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_precomp_workbench (buffer: GENERATION_BUFFER; class_id: INTEGER) is
			-- Generate workbench routine id array.
			-- (Used when the class is precompiled.)
		local
			i, nb: INTEGER;
			feat: FEATURE_I;
			l_values: like values
		do
			buffer.putstring ("uint32 cr");
			buffer.putint (class_id);
			buffer.putstring ("[] = {%N");
			from
				l_values := values
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				feat := l_values.item (i);
				buffer.putstring ("(uint32) ");
				if feat = Void then
					buffer.putchar ('0');
				else
					buffer.putint (feat.rout_id_set.first);
				end;
				buffer.putstring (",%N");
				i := i + 1
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_name_table (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate name table in `buffer'.
		require
			good_argument: buffer /= Void;
		local
			i, nb: INTEGER
			str: STRING
			l_keys: like keys
		do
			buffer.putstring ("char *cl")
			buffer.putint (id)
			buffer.putstring (" [] = {%N")
			from
				i := 0
				nb := capacity - 1
				l_keys := keys
			until
				i > nb
			loop
				str := l_keys.item (i)
				if str = Void then
					buffer.putstring ("(char *) 0")
				else
					buffer.putchar ('"')
					buffer.putstring (str)
					buffer.putstring ("%"")
				end
				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N%N")
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for current cecil table.
		require
			good_argument: ba /= Void;
		local
			i, nb: INTEGER;
			feat: FEATURE_I;
			l_values: like values
		do
			ba.append_integer (capacity);
			l_values := values

				-- First names array
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				feat := l_values.item (i);
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
				i > nb
			loop
				feat := l_values.item (i);
				if feat = Void then
					ba.append_uint32_integer (0);
				else
					ba.append_uint32_integer (feat.feature_id);
				end;
				i := i + 1
			end;
		end;

end
