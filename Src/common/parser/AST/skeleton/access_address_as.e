indexing
	description: "AST representation of an access for the address operator."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_ADDRESS_AS

--inherit
--	ACCESS_ID_AS
--		redefine
--			simple_format
--		end
--
--feature {NONE} -- Output

--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.new_expression;
--			ctxt.prepare_for_feature (feature_name, void);
--			ctxt.put_text_item_without_tabs (ti_Dollar);
--			ctxt.put_current_feature;
--		end

end -- class ACCESS_ADDRESS_AS
