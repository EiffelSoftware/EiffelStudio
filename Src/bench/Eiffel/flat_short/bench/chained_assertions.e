indexing

	description: 
		"List of routine assertions defined in precursor%
		%features.";
	date: "$Date$";
	revision: "$Revision $"

class CHAINED_ASSERTIONS

inherit

	SHARED_TEXT_ITEMS;
	SHARED_FORMAT_INFO;
	LINKED_LIST [ROUTINE_ASSERTIONS];

creation

	make

feature -- Output

	format_precondition (ctxt: FORMAT_CONTEXT_B) is
			-- Format precondition to `ctxt'. Detect
			-- if the assertion in the origin precursor
			-- feature is defined. If not, generate
			-- true tag.
		local
			gen_prec, is_not_first: BOOLEAN;
		do
			ctxt.save_global_adapt;
			ctxt.begin;
			from
				--| Detect if there are preconditions for non origin
				--| routines 
				start
			until
				after or else
				gen_prec
			loop
				gen_prec := item.precondition /= Void and then
							(not item.origin.is_origin)
				forth
			end;
			set_in_assertion;
			from
				start
			until
				after
			loop
				if item.precondition /= Void then
					ctxt.begin;
					item.format_precondition (ctxt);
					if ctxt.last_was_printed then 
						ctxt.commit 
						is_not_first := True;
					else 
						ctxt.rollback 
					end;
				elseif (gen_prec) and then item.origin.is_origin then
					ctxt.put_text_item (ti_Require_keyword);
					ctxt.put_space;
					ctxt.put_text_item_without_tabs (ti_Else_keyword);
					ctxt.put_space;
					ctxt.put_text_item (ti_Dashdash);
					ctxt.put_space;
					ctxt.put_class_name (item.origin.written_class);
					ctxt.indent;
					ctxt.new_line;
					ctxt.put_string ("precursor: True");
					ctxt.new_line;
				end;
				forth;
			end;
			set_not_in_assertion;
			if is_not_first then
				ctxt.commit
			else
				ctxt.rollback
			end;
			ctxt.restore_global_adapt;
		end;

	format_postcondition (ctxt: FORMAT_CONTEXT_B) is
			-- Format format_postcondition to `ctxt'. 
		local
			is_not_first: BOOLEAN;
		do
			ctxt.save_global_adapt;
			ctxt.begin;
			set_in_assertion;
			from
				start
			until
				after
			loop
				if item.postcondition /= void then
					ctxt.begin;
					item.format_postcondition (ctxt);
					if ctxt.last_was_printed then 
						is_not_first := true 
						ctxt.commit 
					else 
						ctxt.rollback 
					end;
				end;
				forth;
			end;
			set_not_in_assertion;
			if is_not_first then
				ctxt.commit
			else
				ctxt.rollback
			end;
			ctxt.restore_global_adapt;
		end;

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end
		end
			
end	-- class CHAINED_ASSERTIONS
