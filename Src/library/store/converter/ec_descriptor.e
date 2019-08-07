note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_DESCRIPTOR inherit

	EC_TYPES;

	EXT_INTERNAL

create -- Creation procedure

	make

feature  -- Initilization

	make
		do
			create ecd_fields.make (10);
			ecd_clear
		end;

feature -- Status report

	ecd_error: BOOLEAN

	ecd_message: detachable STRING

	field_separator: CHARACTER

	ecd_fields: ARRAYED_LIST [EC_FIELD]

	ecd_index: INTEGER
			-- Index of the current field
		do
			Result := ecd_fields.index
		end

	ecd_min_index: INTEGER
			-- Index of the first field

	ecd_max_index: INTEGER
			-- Index of the last field

	ecd_reference_name: detachable STRING

	ecd_reference: detachable ANY

feature -- Status setting

	set_field_separator (fs: CHARACTER)
			-- Set field separator with `fs'.
		do
			field_separator := fs
		ensure
			field_separator = fs
		end;

	ecd_clear
		do
			ecd_fields.wipe_out
			ecd_initialized := False
			ecd_max_index := 0
			field_separator := ';'
		end;

	set_field (n: STRING; type: INTEGER)
			-- Set `ecd_index'-th field with type `type' and name `n'.
		local
			f: EC_FIELD
		do
			ecd_initialized := True;
			create f.make (type, n)
			ecd_fields.extend (f)
			if ecd_fields.count > ecd_max_index then
				ecd_max_index := ecd_fields.count
			end;
		end;

	set_delimiters (ld, rd: CHARACTER)
			-- Set field value delimiters with `ld' and `rd'.
		require
			current_field_exists: not ecd_fields.is_empty
		do
			ecd_fields.last.set_value_delimiters (ld, rd)
		end;

	set_label_separator (ls: CHARACTER)
			-- Set label separator with `ls'.
		require
			current_field_exists: not ecd_fields.is_empty
		do
			ecd_fields.last.set_label_separator (ls)
		end;

	set_use_label (b: BOOLEAN)
			-- Set `use_label' with `b'.
		require
			current_field_exists: not ecd_fields.is_empty
		do
			ecd_fields.last.set_use_label (b)
		end;

	check_conformity (ref: ANY)
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
			l_field: EC_FIELD
		do
			ecd_error := False;
			create tmps.make(0);
			nb_fields := field_count (ref);
			if ecd_fields.is_empty then
				tmps.wipe_out;
				tmps.append ("Type conformity error, No field can be indexed with ");
				tmps.append_integer (nb_fields)
				tmps.append (".%N");
				set_ecd_error (tmps)
			end;
			if not ecd_error and then ecd_fields.count /= nb_fields then
				tmps.wipe_out;
				tmps.append ("Type conformity error, Last field `");
				tmps.append (ecd_fields.last.field_name);
				tmps.append("' cannot be indexed with ");
				tmps.append_integer (nb_fields);
				tmps.append (".%N");
				set_ecd_error(tmps)
			end
			if not ecd_error then
				create ra.make_filled (False, 1, nb_fields);
				create da.make_filled (False, 1, nb_fields);
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
						l_field := ecd_fields.i_th (j)
						if field_conforms (i, ref, l_field) then
							if ra.item (i) then
								tmps.wipe_out;
								tmps.append("Type conformity error, Field ");
								tmps.append(j.out);
								tmps.append(":`");
								tmps.append(l_field.field_name);
								tmps.append("' cannot be declared twice.%N");
								set_ecd_error(tmps)
							elseif da.item(j) then
								tmps.wipe_out;
								tmps.append("Type conformity fatal error: Referenced object has two identical fields%N");
								set_ecd_error(tmps)
							else
								ra.force(True,i);
								da.force(True,j);
								l_field.set_rank(i)
							end
						end
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
							tmps.append(ecd_fields.i_th (i).field_name)
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
			end
		end;

	make_conform (ref: ANY)
			-- Make current description conform to `ref'.
			-- (Using eiffel Standards).
		require
			reference_exists: ref /= Void
		local
			i, nb_fields: INTEGER;
			tmps:STRING
			l_f_name: like f_name
		do
			ecd_error := False;
			create tmps.make(5);
			nb_fields := field_count (ref);
			ecd_clear;
			from
				i:=1
			until
				i > nb_fields or ecd_error
			loop
				f_type := field_type (i, ref);
				l_f_name := field_name (i, ref);
				f_name := l_f_name
				inspect f_type
				when BOOLEAN_TYPE then
					set_field (l_f_name, Boolean_ttype)
				when REAL_TYPE then
					set_field (l_f_name, Real_ttype)
				when INTEGER_TYPE then
					set_field (l_f_name, Integer_ttype)
				else
					set_field (l_f_name, String_ttype);
				end;
				ecd_fields.i_th (i).set_rank (i)
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

	f_name: detachable STRING;

feature {NONE} -- Status setting

	set_ecd_error (s: STRING)
			-- Set error flag and error message with `s'.
		require
			s_not_void: s /= Void
		do
			ecd_error := True;
			ecd_message := s.twin
		end;

	field_conforms (i: INTEGER; o: ANY; f: EC_FIELD): BOOLEAN
			-- Checks for fields confomity.
			-- (names and types)
		require
			reference_object_exists: o /= Void
			f_exists: f /= Void
		local
			tmps:STRING;
			tmpb:BOOLEAN
		do
			create tmps.make(5);
			f_type := field_type (i, o);
			f_name := field_name (i, o);
			if f.field_name ~ f_name then
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
					tmps.append ("Type conformity error, Unknown declared type for field `");
					tmps.append(f.field_name);
					tmps.append("'.%N");
					set_ecd_error(tmps)
				end;
				if not tmpb and not ecd_error then
					tmps.append ("Type conformity error, Invalid declared type for field `");
					tmps.append(f.field_name);
					tmps.append("'.%N");
					set_ecd_error(tmps)
				end;
				Result := tmpb
			else
				Result := False
			end
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EC_DESCRIPTOR
