class CREATE_AS_B

inherit

	CREATE_AS
		redefine
			clients, feature_list
		end;

	AST_EIFFEL_B
		redefine
			format
		end

feature -- Attributes

	clients: CLIENT_AS_B;
			-- Client list

	feature_list: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Feature list

feature -- formatter

	format (ctxt : FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		local
			last_was_printed: BOOLEAN;
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Creation_keyword);
			ctxt.put_space;
			if clients = void then
				last_was_printed := true
			else
				clients.format (ctxt);
				last_was_printed := ctxt.last_was_printed;
			end;
			if not last_was_printed then 
				ctxt.rollback; -- check whether must retain if short
			else
				if feature_list /= Void then
					ctxt.indent;
					ctxt.new_line;
					ctxt.set_separator (ti_Comma);
					ctxt.set_new_line_between_tokens;
					ctxt.set_classes (ctxt.class_c, ctxt.class_c);
					feature_list.format (ctxt);
					ctxt.new_line;
				end;
				ctxt.commit
			end
		end;

end -- class CREATE_AS_B
