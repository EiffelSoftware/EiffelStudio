indexing

	description: 
		"AST representation for normal class type.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit

	TYPE
		redefine
			has_like, simple_format,
			is_equivalent
		end;
	CLICKABLE_AST
		redefine
			is_class
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			class_name ?= yacc_arg (0);
			generics ?= yacc_arg (1);
		ensure then
			class_name_exists: class_name /= Void;
		end;

feature -- Properties

	class_name: ID_AS;
			-- Class type name

	generics: EIFFEL_LIST [TYPE];
			-- Possible generical parameters

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Access

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_like;
					generics.forth
				end;
			end;
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING;
		do
			s := clone (class_name)
			s.to_upper;

			ctxt.put_class_name (s)
			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_L_bracket);
				ctxt.set_space_between_tokens;
				ctxt.set_separator (ti_Comma);
				ctxt.format_ast (generics);
				ctxt.put_text_item_without_tabs (ti_R_bracket);
			end;
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (generics, other.generics)
		end

feature {COMPILER_EXPORTER} -- Conveniences

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

	dump: STRING is
			-- Dumped string
		local
			dumped_class_name: STRING;
		do
			!!Result.make (class_name.count);
			dumped_class_name := clone (class_name)
			dumped_class_name.to_upper;
			Result.append (dumped_class_name);
			if generics /= Void then
				from
					generics.start; 
					Result.append (" [");
				until
					generics.after
				loop
					Result.append (generics.item.dump);
					if not generics.islast then
						Result.append (", ");
					end;
					generics.forth;
				end;
				Result.append ("]");
			end;
		end;

end -- class CLASS_TYPE_AS
