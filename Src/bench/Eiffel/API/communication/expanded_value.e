class

	EXPANDED_VALUE

inherit

	DEBUG_VALUE
		redefine
			set_hector_addr, append_to,
			append_type_and_value
		end

creation {ATTR_REQUEST}

	make_attribute

feature {ATTR_REQUEST}

	make_attribute (attr_name: like name; a_class: like e_class; 
			type: like dynamic_type_name) is
		require
			not_attr_name_void: attr_name /= Void;
			not_type_void: type /= Void
		do
			name := attr_name;
			dynamic_type_name := type;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			!! attributes.make
		end;

feature -- Property

	attributes: SORTED_TWO_WAY_LIST [DEBUG_VALUE];
			-- Attributes of expanded object

feature -- Access

	dynamic_class: E_CLASS is
		local
			type: CLASS_TYPE;
			class_i: CLASS_I;
			type_name: STRING
		do
			Result := private_dynamic_class;
			if Result = Void then
				type_name := clone (dynamic_type_name);
				type_name.to_lower;
				class_i := Eiffel_universe.class_with_name (type_name);
				if class_i /= Void then
					Result := class_i.compiled_eclass;
					private_dynamic_class := Result
				end
			end	
		end;

feature -- Output

	append_to (cw: CLICK_WINDOW; indent: INTEGER) is
			-- Append `Current' to `cw' with `indent' tabs the left margin.
		local
			ec: E_CLASS;
		do
			append_tabs (cw, indent);
			cw.put_clickable_string (feature_stone, name)
			cw.put_string (": expanded ");
			ec := dynamic_class;
			if ec /= Void then
				ec.append_clickable_name (cw);
				cw.new_line;
				append_tabs (cw, indent + 1);
				cw.put_string ("-- begin sub-object --");
				cw.new_line;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_to (cw, indent + 2);
					attributes.forth
				end;
				append_tabs (cw, indent + 1);
				cw.put_string ("-- end sub-object --");
				cw.new_line
			else
				Any_class.append_clickable_name (cw);
				cw.put_string (" = Unknown")
			end
		end;

	append_type_and_value (cw: CLICK_WINDOW) is
		do
		end;

feature {NONE} -- Implementation

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			from
				attributes.start
			until
				attributes.after
			loop
				attributes.item.set_hector_addr;
				attributes.forth
			end;
		end;

feature {NONE} -- Implementation

	dynamic_type_name: STRING;
			-- Dynamic type of expanded object

	private_dynamic_class: E_CLASS
			-- Saved class

invariant

	is_attribute: is_attribute;
	attributes_exists: attributes /= Void;
	dynamic_type_not_void: dynamic_type_name /= Void

end -- class EXPANDED_VALUE
