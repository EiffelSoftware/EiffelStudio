indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_DESCRIPTOR inherit 

	EC_TYPES;

	EXT_INTERNAL

creation -- Creation procedure

	make

feature  -- Initilization

	make is
		do
			!! ecd_fields.make (1, 10);
			ecd_clear
		end;

feature -- Status report

	ecd_error: BOOLEAN

	ecd_message: STRING

	field_separator: CHARACTER

	ecd_fields: ARRAY [EC_FIELD]

	ecd_index: INTEGER
			-- Index of the current field

	ecd_min_index: INTEGER
			-- Index of the first field

	ecd_max_index: INTEGER
			-- Index of the last field

	ecd_reference_name: STRING

	ecd_reference: ANY

feature -- Status setting

	set_field_separator (fs: CHARACTER) is
			-- Set field separator with `fs'.
		do
			field_separator := fs
		ensure
			field_separator = fs
		end;

	ecd_clear is
		do
			ecd_fields.clear_all;
			ecd_index := 0;
			ecd_initialized := False;
			ecd_min_index := 32768;
			ecd_max_index := 0;
			field_separator := ';'
		end;

	set_index (i: INTEGER) is
			-- Set `ecd_index' with `i'.
		do
			ecd_index := i-1
		ensure
			ecd_index = i-1
		end;

	set_field (n: STRING; type: INTEGER) is
			-- Set `ecd_index'-th field with type `type' and name `n'.
		local
			f: EC_FIELD
		do
			ecd_initialized := True;
			ecd_index := ecd_index + 1;
			if ecd_index > ecd_max_index then
				ecd_max_index := ecd_index
			end;
			if ecd_index < ecd_min_index then
				ecd_min_index := ecd_index
			end;
			!!f.make;
			f.set_field (type, n);
			ecd_fields.force (f, ecd_index)
		end;

	set_delimiters (ld, rd: CHARACTER) is
			-- Set field value delimiters with `ld' and `rd'.
		require
			current_field_exists: ecd_fields.item(ecd_index) /= Void
		do
			ecd_fields.item (ecd_index).set_value_delimiters (ld, rd)
		end;

	set_label_separator (ls: CHARACTER) is
			-- Set label separator with `ls'.
		require
			current_field_exists: ecd_fields.item(ecd_index) /= Void
		do
			ecd_fields.item(ecd_index).set_label_separator(ls)
		end;

	set_use_label (b: BOOLEAN) is
			-- Set `use_label' with `b'.
		require
			current_field_exists: ecd_fields.item(ecd_index) /= Void
		do
			ecd_fields.item (ecd_index).set_use_label (b)
		end;

	check_conformity (ref: ANY) is
			-- Check if current desciptor conforms to `ref'.
			-- The conformity is true if and only if for each
			-- field of the current descriptor, there is a 
			-- corresponding field in the Eiffel object with
			-- the same field_name and the same field_type.
		require
			reference_exists: ref /= Void
		local
			i, j, nb_fields: INTEGER;
			tmps: STRING;
			ra, da: ARRAY [BOOLEAN]  -- Referenced and Declared array
		do
			ecd_error := False;
			!!tmps.make(0);
			nb_fields := field_count (ref);
			if ecd_min_index /= 1 then
				tmps.wipe_out;
				tmps.append("Type conformity error, First field `");
				tmps.append(ecd_fields.item(ecd_min_index).field_name);
				tmps.append("' can not be indexed with ");
				tmps.append(ecd_min_index.out);
				tmps.append(".%N");
				set_ecd_error(tmps)
			end;
			if not ecd_error and then ecd_max_index /= nb_fields then
				tmps.wipe_out;
				tmps.append("Type conformity error, Last field `");
				tmps.append(ecd_fields.item(ecd_max_index).field_name);
				tmps.append("' can not be indexed with ");
				tmps.append(ecd_max_index.out);
				tmps.append(".%N");
				set_ecd_error(tmps)
			end;
			!!ra.make(1,nb_fields);
			!!da.make(1,nb_fields);
			from 
				i:=1
			until
				i > nb_fields or ecd_error
			loop
				from
					j:=1
				until
					j > nb_fields or ecd_error
				loop
					if ecd_fields.item (j) = Void then
						tmps.wipe_out;
						tmps.append("Type conformity error, Field ");
						tmps.append(j.out);
						tmps.append(" has not been set.%N");
						set_ecd_error(tmps)
					else
						if field_conforms (i, ref, ecd_fields.item(j)) then
							if ra.item (i) then 
								tmps.wipe_out;
								tmps.append("Type conformity error, Field ");
								tmps.append(j.out);
								tmps.append(":`");
								tmps.append(ecd_fields.item(j).field_name);
								tmps.append("' cannot be declared twice.%N");
								set_ecd_error(tmps)
							elseif da.item(j) then 
								tmps.wipe_out;
								tmps.append("Type conformity fatal error: Referenced object has two identical fields%N"); 
								set_ecd_error(tmps)
							else
								ra.force(True,i);
								da.force(True,j);
								ecd_fields.item(j).set_rank(i)
							end
						end
					end;
					j := j + 1
				end;
				i := i + 1
			end;
			if not ecd_error then 
				from 
					i := 1
				until 
					i > nb_fields
				loop
					if not da.item(i) then 
						tmps.append("Type conformity error, Field ");
						tmps.append(i.out);
						tmps.append(":`");
						tmps.append(ecd_fields.item(i).field_name);
						tmps.append("' does not match any reference field.%N");
						set_ecd_error(tmps)
					end;
					i := i + 1
				end
			end;
			if not ecd_error then
				ecd_reference_name := ref.generator;
				ecd_reference := ref
			end
		end;

	make_conform (ref: ANY) is
			-- Make current description conform to `ref'.
			-- (Using eiffel Standards).
		require
			reference_exists: ref /= Void
		local
			i, nb_fields: INTEGER;
			tmps:STRING
		do
			ecd_error := False;
			!!tmps.make(5);
			nb_fields := field_count (ref);
			ecd_clear;
			from 
				i:=1
			until
				i > nb_fields or ecd_error
			loop
				f_type := field_type (i, ref);
				f_name := field_name (i, ref);
				inspect f_type
				when BOOLEAN_TYPE then 
					set_field (f_name, Boolean_ttype)
				when REAL_TYPE then 
					set_field (f_name, Real_ttype)
				when INTEGER_TYPE then 
					set_field (f_name, Integer_ttype)
				else
					set_field (f_name, String_ttype);
				end;
				ecd_fields.item(i).set_rank(i);
				i := i + 1
			end;
			if not ecd_error then
				ecd_reference_name := ref.generator;
				ecd_reference := ref
			end
		end

feature {NONE} -- Status report

	ecd_initialized: BOOLEAN;

	f_type: INTEGER;

	f_name: STRING;

feature {NONE} -- Status setting

	set_ecd_error (s: STRING) is
			-- Set error flag and error message with `s'.
		do
			ecd_error := True;
			ecd_message := clone(s)
		end;

	field_conforms (i: INTEGER; o: ANY; f: EC_FIELD): BOOLEAN is
			-- Checks for fields confomity.
			-- (names and types)
		require 
			reference_object_exists: o /= Void
		local
			tmps:STRING;
			tmpb:BOOLEAN
		do
			!!tmps.make(5);
			f_type := field_type (i, o);
			f_name := field_name (i, o);
			if f.field_name.is_equal(f_name) then
				inspect f.field_type
				when Boolean_ttype then
					tmpb := (f_type = BOOLEAN_TYPE)
				when Integer_ttype then
					tmpb := (f_type = INTEGER_TYPE)
				when Real_ttype then
					tmpb := (f_type = REAL_TYPE)
				when String_ttype then
					tmpb := (f_type = REFERENCE_TYPE)
				else
					tmpb := False;
					tmps.append
						("Type conformity error, Unknown declared type for field `");
					tmps.append(f.field_name);
					tmps.append("'.%N");
					set_ecd_error(tmps)
				end;
				if not tmpb and not ecd_error then 
					tmps.append
						("Type conformity error, Invalid declared type for field `");
					tmps.append(f.field_name);
					tmps.append("'.%N");
					set_ecd_error(tmps)
				end;
				Result := tmpb
			else
				Result := False
			end
		end

end -- class EC_DESCRIPTOR



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

