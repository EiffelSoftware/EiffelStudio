class UN_OLD_AS

inherit

	UNARY_AS
		redefine
			operator_is_keyword, simple_format
		end;

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
		end; -- prefix_feature_name

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin;
			ctxt.set_insertion_point;
			expr.simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.need_dot;
				ctxt.prepare_for_prefix ("_prefix_old");
				ctxt.put_current_feature;
				if ctxt.last_was_printed then
					ctxt.commit;
				end;
			end;
		end; 
			
	operator_name: STRING is "old";
	
	operator_is_keyword: BOOLEAN is true;

end
