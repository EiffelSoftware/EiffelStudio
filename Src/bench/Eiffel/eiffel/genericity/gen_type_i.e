-- Generic type class

class GEN_TYPE_I

inherit

	CL_TYPE_I
		redefine
			meta_generic,
			same_as,
			is_valid,
			has_formal,
			instantiation_in,
			dump,
			append_clickable_signature
		end;

feature

	meta_generic: META_GENERIC;
			-- Meta generic description of the type class

	set_meta_generic (m: META_GENERIC) is
			-- Assign `m' to `meta_generic'.
		do
			meta_generic := m;
		end;

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			gen_type_i: GEN_TYPE_I;
		do
			gen_type_i ?= other;
			if gen_type_i /= Void then
				Result :=	base_id = gen_type_i.base_id
							and then
							is_expanded = gen_type_i.is_expanded
							and then
							meta_generic.same_as (gen_type_i.meta_generic);
			end;
		end;

	is_valid: BOOLEAN is
			-- Are all the base classes still in the system ?
		do
			Result := base_class /= Void and then meta_generic.is_valid;
		end;

	duplicate: like Current is
			-- Duplication
		do
			Result := twin;
			Result.set_meta_generic (meta_generic.twin);
		end;

	instantiation_in (other: like Current): like Current is
			-- Instantiation of Current in context of `other'
		local
			i, count, meta_position: INTEGER;
			formal: FORMAL_I;
			meta_gen: like meta_generic;
		do
			from
				Result := duplicate;
				meta_gen := Result.meta_generic;
				i := 1;
				count := meta_generic.count;
			until
				i > count
			loop
				meta_gen.put
					(meta_generic.item (i).instantiation_in (other), i);
				i := i + 1
			end;
		end;

	has_formal: BOOLEAN is
			-- Are some meta formals present in `meta_generic' ?
		local
			i, count: INTEGER;
		do
			from
				i := 1;
				count := meta_generic.count;
			until
				i > count or else Result
			loop
				Result := meta_generic.item (i).has_formal;
				i := i + 1;
			end;
		end;

	dump (file: UNIX_FILE) is
		local
			i, count, meta_type: INTEGER;
		do
			from
				if is_expanded then
					file.putstring ("expanded ");
				end;
				file.putint (base_id);
				file.putstring (base_class.class_name);
				file.putstring (" {");
				i := 1;
				count := meta_generic.count;
			until
				i > count
			loop
				meta_generic.item (i).dump (file);
				if i < count then
					file.putstring (", ");
				end;
				i := i + 1;
			end;
			file.putchar ('}');
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		local
			i, count, meta_type: INTEGER;
		do
			from
				if is_expanded then
					a_clickable.put_string ("expanded ");
				end;
				base_class.append_clickable_name (a_clickable);
				a_clickable.put_string (" [");
				i := 1;
				count := meta_generic.count;
			until
				i > count
			loop
				meta_generic.item (i).append_clickable_signature (a_clickable);
				if i < count then
					a_clickable.put_string (", ");
				end;
				i := i + 1;
			end;
			a_clickable.put_char (']');
		end;

end
