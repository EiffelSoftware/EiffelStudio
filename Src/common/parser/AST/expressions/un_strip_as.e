indexing
	description: "AST represenation of a unary `strip' operation.";
	date: "$Date$";
	revision: "$Revision $"

class UN_STRIP_AS

inherit

	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize (i: like id_list) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
		ensure
			id_list_set: id_list = i
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			if id_list = Void then
				-- Empty list
				!!id_list.make_filled (0)
			end;
				-- The following line is already a
				-- property of EIFFEL_LIST! -- ericb
			id_list.compare_objects;
		ensure then
			id_list /= Void;
		end;

feature -- Property

	id_list: EIFFEL_LIST [ID_AS];
			-- Attribute list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (id_list, other.id_list)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			first_printed: BOOLEAN;
		do
			ctxt.put_text_item (ti_Strip_keyword);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_L_parenthesis);

			from
				id_list.start;
			until
				id_list.after
			loop
				ctxt.new_expression;
				ctxt.prepare_for_feature (id_list.item, void);
				if ctxt.is_feature_visible then
					if first_printed then
						ctxt.put_text_item_without_tabs (ti_Comma);
						ctxt.put_space
					end;
					ctxt.put_current_feature;
					first_printed := True;
				end;
				id_list.forth
			end;
			ctxt.put_text_item_without_tabs (ti_R_parenthesis);
		end;

end -- class UN_STRIP_AS
