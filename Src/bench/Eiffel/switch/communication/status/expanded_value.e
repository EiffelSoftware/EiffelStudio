indexing

	description: 
		"Run time value representing an expanded object.";
	date: "$Date$";
	revision: "$Revision $"

class
	EXPANDED_VALUE

inherit

	REFERENCE_VALUE
		rename
			make_attribute as ref_make_attribute
		redefine
			set_hector_addr, append_to,
			append_type_and_value,
			type_and_value, expandable,
			children, kind, append_value,
			output_value
		end

creation {ATTR_REQUEST}

	make_attribute

feature {ATTR_REQUEST}

	make_attribute (attr_name: like name; a_class: like e_class; 
			type: like dynamic_type_id) is
		require
			not_attr_name_void: attr_name /= Void
		do
			name := attr_name;
			dynamic_type_id := type;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			!! attributes.make
		end;

feature -- Property

	attributes: SORTED_TWO_WAY_LIST [ABSTRACT_DEBUG_VALUE];
			-- Attributes of expanded object

feature -- Output

	append_to (st: STRUCTURED_TEXT; indent: INTEGER) is
			-- Append `Current' to `st' with `indent' tabs the left margin.
		local
			ec: CLASS_C;
		do
			append_tabs (st, indent);
			st.add_feature_name (name, e_class)
			st.add_string (": expanded ");
			ec := dynamic_class;
			if ec /= Void then
				ec.append_name (st);
				st.add_new_line;
				append_tabs (st, indent + 1);
				st.add_string ("-- begin sub-object --");
				st.add_new_line;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_to (st, indent + 2);
					attributes.forth
				end;
				append_tabs (st, indent + 1);
				st.add_string ("-- end sub-object --");
				st.add_new_line
			else
				Any_class.append_name (st);
				st.add_string (" = Unknown")
			end
		end;

	append_value (st: STRUCTURED_TEXT) is
			-- Append value of `Current' to `st' with `indent' tabs the left margin.
		local
			ec: CLASS_C;
		do
			ec := dynamic_class;
			if ec /= Void then
				st.add_string ("-- begin sub-object --");
				st.add_new_line;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_to (st, 2);
					attributes.forth
				end;
				append_tabs (st, 1);
				st.add_string ("-- end sub-object --");
				st.add_new_line
			else
				Any_class.append_name (st);
				st.add_string (" = Unknown")
			end
		end;

	append_type_and_value (st: STRUCTURED_TEXT) is
		local
			ec: CLASS_C;
		do
			ec := dynamic_class
			if ec /= Void then
				ec.append_name (st)
			end
		end;

	output_value: STRING is "Expanded object"
			-- Return a string representing `Current'.

	type_and_value: STRING is
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
		do
			ec := dynamic_class
			create Result.make (60)
			if ec /= Void then
				Result.append (ec.name_in_upper)
				Result.append (Expanded_label)
			else
				Result.append (Any_class.name_in_upper)
				Result.append (Expanded_label)
			end
		end

	Expanded_label: STRING is " (expanded)"

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result :=	attributes /= Void and then
						not attributes.is_empty and then
						dynamic_class /= Void
		end

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := attributes
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Expanded_value
		end

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

invariant

	is_attribute: is_attribute;
	attributes_exists: attributes /= Void

end -- class EXPANDED_VALUE
