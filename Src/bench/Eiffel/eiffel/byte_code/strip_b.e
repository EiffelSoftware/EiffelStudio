-- Byte code for strip expression

class STRIP_B 

inherit

	EXPR_B
		redefine
			make_byte_code, enlarged, size, generate_il
		end
	SHARED_INSTANTIATOR

creation

	make
	
feature 

	feature_ids: LINKED_SET [INTEGER]
			-- Set of attributes feature ids to strip from the current
			-- type

	make is
		do
			create feature_ids.make
		end

	type: GEN_TYPE_I is
			-- Type of byte code strip expression
		once
			Result := Instantiator.Array_type
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
		end;

	enlarged: STRIP_BL is
			-- Enlarge node
		do
			!!Result;
			Result.set_feature_ids (feature_ids)
		end;

	attribute_names: LINKED_LIST [STRING] is
			-- Get routine ids.
		local
			skeleton: SKELETON;
			attr: ATTR_DESC;
		do
			skeleton := Context.class_type.skeleton;
			from
				!!Result.make;
				feature_ids.start
			until
				feature_ids.after
			loop
				skeleton.search_feature_id (feature_ids.item);
				attr := skeleton.item;
					--! Should always be found
				Result.put_right (attr.attribute_name);
				Result.forth;
				feature_ids.forth;
			end;
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for strip expression.
		do
			check False end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a strip expression
		local
			cl_type: CLASS_TYPE;
			attr_names: LINKED_LIST [STRING];
		do
			cl_type := Context.class_type;
			attr_names := attribute_names;
			from
				attr_names.start
			until
				attr_names.after
			loop
				ba.append (Bc_add_strip);
				ba.append_raw_string (attr_names.item);
				attr_names.forth
			end;
			ba.append (Bc_end_strip);
			ba.append_short_integer (cl_type.type_id - 1);
			ba.append_integer (attr_names.count);
		end;

feature -- Inlining

	size: INTEGER is
		do
			Result := feature_ids.count + 1
		end

invariant

	set_exists: feature_ids /= Void

end
