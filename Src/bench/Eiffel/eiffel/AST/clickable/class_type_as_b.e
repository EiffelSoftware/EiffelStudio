-- Node for normal class type

class CLASS_TYPE_AS

inherit

	TYPE
		redefine
			has_like, format
		end;
	SHARED_INST_CONTEXT;
	STONABLE

feature -- Attributes

	class_name: ID_AS;
			-- Class type name

	generics: EIFFEL_LIST [TYPE];
			-- Possible generical parameters

feature -- Initialization

	set is
			-- Yacc initialization
		do
			class_name ?= yacc_arg (0);
			generics ?= yacc_arg (1);
		ensure then
			class_name_exists: class_name /= Void;
		end;

feature -- Conveniences

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end;

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
		do
			if generics = Void then
				!!Result;
			else
				from
					!!gen_type;
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
				until
					i > count
				loop
					actual_generic.put
						(generics.i_th (i).solved_type (feat_table, f), i);
					i := i + 1;
				end;
				Result := gen_type;
			end;
			a_class :=
		Universe.class_named (class_name, Inst_context.cluster).compiled_class;
			Result.set_base_type (a_class.id);
				-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
		end;

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
		do
			if generics = Void then
				!!Result;
			else
				from
					!!gen_type;
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
				until
					i > count
				loop
					actual_generic.put (generics.i_th (i).actual_type, i);
					i := i + 1;
				end;
				Result := gen_type;
			end;
			a_class :=
			Universe.class_named (class_name, Inst_context.cluster).compiled_class;
			Result.set_base_type (a_class.id);
					-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
		end;

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.offright or else Result
				loop
					Result := generics.item.has_like;
					generics.forth
				end;
			end;
		end;

	dump: STRING is
			-- Dumped string
		local
			dumped_class_name: STRING;
		do
			!!Result.make (class_name.count);
			dumped_class_name := class_name.duplicate;
			dumped_class_name.to_upper;
			Result.append (dumped_class_name);
			if generics /= Void then
				from
					generics.start; 
					Result.append (" [");
				until
					generics.offright
				loop
					generics.item.trace;
					if not generics.islast then
						Result.append (", ");
					end;
					generics.forth;
				end;
				Result.append ("]");
			end;
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do
			aclass := Universe.class_named (class_name, reference_class.cluster).compiled_class;
			!!Result.make (aclass)
		end;


	format (ctxt: FORMAT_CONTEXT) is 
			-- Reconstitute text
		local
			s: STRING;
		do
			ctxt.begin;
			S := class_name.duplicate;
			s.to_upper;
			ctxt.put_string (s);
			if generics /= void then
				ctxt.put_special (" [");
				generics.format (ctxt);
				ctxt.put_special ("]");
			end;
			ctxt.commit;
		end;
			

end
