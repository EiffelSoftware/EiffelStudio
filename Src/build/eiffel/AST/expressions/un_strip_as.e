class UN_STRIP_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS];
			-- Attribute list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			if id_list = Void then
				-- Empty list
				!!id_list.make (0)
			end;
			id_list.compare_objects;
		ensure then
			id_list /= Void;
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			first_printed: BOOLEAN;
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Strip_keyword);
			ctxt.put_space;
			ctxt.put_text_item (ti_L_parenthesis);
			
			from
				id_list.start;
			until
				id_list.after
			loop
				ctxt.new_expression;
				ctxt.prepare_for_feature(id_list.item, void);
				if ctxt.is_feature_visible then	
					if not first_printed then
						ctxt.put_text_item (ti_Comma);
						ctxt.put_space
					end;	
					ctxt.put_current_feature;
					first_printed := true;
				end;
				id_list.forth
			end;
			ctxt.put_text_item (ti_R_parenthesis);
			ctxt.commit
		end;

end
