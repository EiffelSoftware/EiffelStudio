indexing
	description: 
		"List of routine assertions defined in precursor features.";
	date: "$Date$";
	revision: "$Revision $"

class CHAINED_ASSERTIONS

inherit
	SHARED_TEXT_ITEMS
	SHARED_FORMAT_INFO
	LINKED_LIST [ROUTINE_ASSERTIONS]

creation
	make

feature -- Output

	format_precondition (ctxt: FORMAT_CONTEXT) is
			-- Format precondition to `ctxt'. Detect
			-- if the assertion in the origin precursor
			-- feature is defined. If not, generate
			-- true tag.
		local
			is_not_first: BOOLEAN
		do
			ctxt.save_adaptations;
			ctxt.begin;
			start;
			if not empty then
					--| The chained assertion can be empty:
					--| There are no precursors (and thus no origins detected)
					--| plus the current feature dosn't have aby preconditions itself.
					--| This means the feature is the origin of a branch not defining
					--| a precondition.
				if item.precondition = Void and then count > 1 then
						--| Void precondition is generated in `ASSERTION_SERVER'
						--| and means: no origin with an assertion (and thus
						--| the require is true.
						--| `count' must be greater than one.
						--| If there is just one assertion in the list without a precondition,
						--| then that item comes from the origin(s), where all of them doesn't
						--| have a precondition. And thus we may not generate any precondition.
						--| This relies on the fact that we only record features that have an assertion
						--| and *one* origin if all origins doesn't have a precondition.
					ctxt.put_text_item (ti_Require_keyword);
					ctxt.put_space;
					ctxt.put_text_item (ti_Dashdash);
					ctxt.put_space;
					ctxt.put_classi (item.origin.written_class.lace_class);
					ctxt.indent;
					ctxt.new_line;
					ctxt.put_string ("precursor: True");
					ctxt.new_line;
					ctxt.exdent;
					ctxt.set_first_assertion (False)
				end
			end;

			from
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
				end;
				forth;
			end;
			set_not_in_assertion;
			if is_not_first then
					-- Only commit if there were chained preconditions
				ctxt.commit
			else
				ctxt.rollback
			end;
			ctxt.restore_adaptations;
		end;

	format_postcondition (ctxt: FORMAT_CONTEXT) is
			-- Format format_postcondition to `ctxt'. 
		local
			is_not_first: BOOLEAN;
		do
			ctxt.save_adaptations;
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
			ctxt.restore_adaptations;
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
