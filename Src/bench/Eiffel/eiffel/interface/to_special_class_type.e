-- Class type for class TO_SPECIAL

class TO_SPECIAL_CLASS_TYPE 

inherit

	CLASS_TYPE
		rename
			generate_feature as basic_generate_feature
		end;
	CLASS_TYPE
		redefine
			generate_feature
		select
			generate_feature
		end;
	SHARED_TABLE;
	SHARED_ENCODER;
	SHARED_BODY_ID;

creation

	make

feature

	generate_feature (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generate feature `feat' in `file'.
		local
			feature_name: STRING;
		do
			feature_name := feat.feature_name;
			if feature_name.is_equal ("make_area") then
					-- Generate built-in feature `put' of class SPECIAL
				generate_make_area (feat, file);
			else
					-- Basic generation
				basic_generate_feature (feat, file);
			end;
		end;

	generate_make_area (feat: FEATURE_I; file: INDENT_FILE) is
			-- Generates built-in feature `make_area' of class TO_SPECIAL
		require
			good_argument: file /= Void;
			feat_exists: feat /= Void;
		local
			gen_param: TYPE_I;
			is_expanded: BOOLEAN;
			type_c: TYPE_C;
			expanded_type, non_expanded_type: CL_TYPE_I;
			gen_type: GEN_TYPE_I;
			dtype: INTEGER;
			c_name: STRING;
			final_mode: BOOLEAN;
		do
			gen_param := first_generic;
			is_expanded := gen_param.is_expanded;
			type_c := gen_param.c_type;

				-- HEADER:
				--		void make_area(Current, arg1)
				--		char *Current;
				--		long arg1;
				--		{
				--			char *result;
				--			struct union overhead *zone;
			file.putstring ("%
				%/*%N%
				% * make_area%N%
				% */%Nvoid ");
			file.putstring (Encoder.feature_name (id, feat.body_id));
			file.putstring ("%
				% (Current, arg1)%N%
				%char *Current;%N%
				%long arg1;%N%
				%{%N%
				%%Tchar *result, *ref;%N%
				%%Tunion overhead *zone;%N%
				%%TRTLD;%N%N");

				-- Garbage collector hooks
			file.putstring ("%TRTLI(2);%N%
				%%Tl[0] = Current;%N%
				%%Tl[1] = (char *) 0;%N%N");

			final_mode := byte_context.final_mode;
			if 	(not final_mode)
				or else
				associated_class.assertion_level.check_precond
			then
				if not final_mode then
					file.putstring
						("%Tif (~in_assertion & WASC(Dtype(Current)) & CK_REQUIRE) {%N");
				else
					file.putstring
						("%Tif (~in_assertion) {%N");
				end;
					-- Precondition
					--		RTCT("positive_argument", EX_PRE);
					--		if (arg1 >= 0)
					--			RTCK;
					--		else
					--			RTCF;
				file.putstring ("%
					%%TRTCT(%"positive_argument%", EX_PRE);%N%
					%%Tif (arg1 >= 0) {%N%
					%%T%TRTCK;%N%
					%%T} else {%N%
					%%T%TRTCF;%N%T}%N");
				if not final_mode then
					file.putstring ("%T}%N");
				else
					file.putstring ("%T}%N");
				end;
			end;

				-- Allocation of a special object
				--		l[1] = spmalloc(arg1 * sizeof(char *) + LNGPAD(2));
			file.putstring ("%Tl[1] = spmalloc(CHRPAD(arg1 * ");
		
			if is_expanded then
				file.putstring ("(Size(");
				expanded_type ?= gen_param;
				non_expanded_type := clone (expanded_type);
				non_expanded_type.set_is_expanded (False);
				dtype := non_expanded_type.type_id - 1;
				file.putint (dtype);
				file.putstring (")+OVERHEAD)");
			else
				type_c.generate_size (file);
			end;
			file.putstring (") + LNGPAD(2));%N");

				-- Header evaluation
				--		zone = HEADER(l[1]);
			file.putstring ("%Tzone = HEADER(l[1]);%N");
			file.putstring ("%
				%%Tref = l[1] + (zone->ov_size & B_SIZE) - LNGPAD(2);%N");

				-- Set dynamic type
			!!gen_type;
			gen_type.set_base_id (System.special_id);
			gen_type.set_meta_generic (clone (type.meta_generic));
			file.putstring ("%Tzone->ov_flags |= ");
			if final_mode then
				file.putint (gen_type.type_id - 1);
			else
				file.putstring ("RTUD(");
				file.putint (gen_type.associated_class_type.id - 1);
				file.putchar (')');
			end;
			if gen_param.is_reference then
				file.putstring (" | EO_REF");
			end;
			file.putstring (";%N");

				-- Set count
			file.putstring ("%T*(long *) ref = arg1;%N");

				-- Set element size
			file.putstring ("%T*(long *) (ref + sizeof(long)) = ");
			if is_expanded then
				file.putstring ("Size(");
				file.putint (dtype);
				file.putstring (") + OVERHEAD;%N");
				file.putstring ("%Tzone->ov_flags |= EO_COMP;%N");
				
					-- Call initialization routines
				file.putstring ("%
					%%T{%N%
					%%T%Tchar *ref;%N%
					%%T%Tlong i;%N%
					%%T%Tfnptr init;%N%
					%%T%Tinit = Create(");
				file.putint (dtype);
				file.putstring (");%N%
					%%T%Tfor (ref = l[1]+OVERHEAD, i = 0; i < arg1; i++,%
							%ref += Size(");
				file.putint (dtype);
				file.putstring (")+OVERHEAD){%N%
					%%T%T%THEADER(ref)->ov_size = ref - l[1];%N%
				   %%T%T%THEADER(ref)->ov_flags = ");
				file.putint (dtype);
				file.putstring (";%N%
					%%T%T%Tif ((fnptr) 0 != init)%N%
					%%T%T%T%T(init)(ref, l[1]);%N%
					%%T%T};%N%T};%N");
			else
				type_c.generate_size (file);
				file.putstring (";%N");
			end;
				-- Assignment of result to `area'.
			file.putstring ("%TRTAR(l[1], l[0]);%N");
			file.putchar ('%T');
			generate_area_access (file);
			file.putstring (" = l[1];%N");
				
			file.putstring ("%TRTLE;%N");

			file.putstring ("}%N%N");

		end;

	first_generic: TYPE_I is
			-- First generic parameter type
		require
			has_generics: type.meta_generic /= Void;
			good_generic_count: type.meta_generic.count = 1;
		do
			Result := type.meta_generic.item (1);
		end;

	generate_area_access (file: UNIX_FILE) is
			-- Generate access to area.
		require
			good_argument: file /= Void;
		local
			area_feature: FEATURE_I;
			rout_id: INTEGER;
			table: POLY_TABLE [ENTRY];
			table_name: STRING;
		do
			file.putstring ("*(char **) (l[0] + ");

			area_feature := associated_class.feature_table.item ("area");

			if byte_context.final_mode then
				rout_id := - area_feature.rout_id_set.first;
				table := Eiffel_table.item_id (rout_id);
			
				if table.is_polymorphic (type_id) then
						-- Access to area is polymorphic
					table_name := Encoder.table_name (rout_id);
					file.putchar ('(');
					file.putstring (table_name);
					file.putchar ('-');
					file.putint (table.min_type_id - 1);
					file.putchar (')');
					file.putstring ("[Dtype(l[0])]");
						-- Remember extern declaration
					Extern_declarations.add_attribute_table (clone (table_name));
					   -- Mark attribute table used
					Eiffel_table.mark_used (rout_id);
				else
					skeleton.generate_offset (file, area_feature.feature_id);
				end;
				file.putchar (')');
			else
				file.putstring ("RTWA(");
				file.putint (id - 1);
				file.putstring (", ");
				file.putint (area_feature.feature_id);
				file.putstring (", ");
				file.putstring ("Dtype(l[0])))");
			end;				
		end;

end
