indexing

	description: "Node for normal class type.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit

	TYPE
		redefine
			has_like, is_deep_equal, simple_format
		end;

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

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING;
		do
			s := clone (class_name)
			s.to_upper;

			ctxt.put_string (s)
			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_L_bracket);
				ctxt.set_space_between_tokens;
				ctxt.set_separator (ti_Comma);
				ctxt.format_ast (generics);
				ctxt.put_text_item_without_tabs (ti_R_bracket);
			end;
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

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			o: CLASS_TYPE_AS;
			o_g: like generics;
			p, o_p: INTEGER
		do
			o ?= other;
			Result := o /= Void and then
				class_name.is_equal (o.class_name)
			if Result then
				o_g := o.generics;
				if generics = Void then
					Result := o_g = Void
				elseif o_g = Void then
					Result := False
				else
					p := generics.index;
					o_p := o_g.index;
					from
						generics.start;
						o_g.start;
						Result := o_g.count = generics.count
					until
						generics.after or else not Result
					loop
						Result := generics.item.is_deep_equal (o_g.item);
						generics.forth;
						o_g.forth
					end;
				end;
				generics.go_i_th (p);
				o_g.go_i_th (o_p);
			end;
		end;

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

	dump: STRING is
			-- Dumped string
		local
			dumped_class_name: STRING;
		do
-- FIXME append_clickable_signature should be redefined
-- some parts of the signature can be clickable !!!

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
