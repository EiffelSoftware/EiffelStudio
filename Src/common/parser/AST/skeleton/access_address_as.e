indexing

	description: "Access for the address operator";
	date: "$Date$";
	revision: "$Revision$"

class ACCESS_ADDRESS_AS

inherit

	ACCESS_ID_AS
		redefine
			simple_format
		end

creation

	make

feature

	make (s: ID_AS) is
			-- Initialization
		do
			feature_name := s;
		end;

feature 

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.new_expression;
			ctxt.prepare_for_feature (feature_name, void);
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_current_feature;
			--if ctxt.last_was_printed then
				ctxt.commit;
			--end
		end;

end -- class ACCESS_ADDRESS_AS
