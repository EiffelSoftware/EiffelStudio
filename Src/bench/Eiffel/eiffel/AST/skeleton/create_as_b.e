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

	format (ctxt: FORMAT_CONTEXT_B) is
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
					ctxt.set_new_line_between_tokens;
					ctxt.set_classes (ctxt.class_c, ctxt.class_c);
					if ctxt.is_flat_short then
						ctxt.set_separator (ti_Semi_Colon);
						format_features (ctxt, feature_list)
					else
						ctxt.set_separator (ti_Comma);
						feature_list.format (ctxt);
						ctxt.new_line;
					end;
				end;
				ctxt.commit
			end
		end;

feature {NONE} -- Implementation

	format_features (ctxt: FORMAT_CONTEXT_B; list: like feature_list) is
			-- Format the features in the creation clause
		local
			i, l_count: INTEGER;
			item: FEATURE_NAME_B;
			creators: HASH_TABLE [FEATURE_ADAPTER, STRING];
			feat_adapter: FEATURE_ADAPTER
		do
			ctxt.begin;
			creators := ctxt.format_registration.creation_table;
			from
				i := 1;
				l_count := list.count;
			until
				i > l_count 
			loop
				item := list.i_th (i);
				feat_adapter := creators.item (item.internal_name);	
				if feat_adapter /= Void then
					feat_adapter.format (ctxt)
				end;
				i := i + 1
			end;
			ctxt.commit;
		end;

end -- class CREATE_AS_B
