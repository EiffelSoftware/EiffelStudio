class FEATURE_CLAUSE_AS_B

inherit

	FEATURE_CLAUSE_AS
		redefine
			clients, features
		end;

	AST_EIFFEL_B
		undefine
			position, simple_format
		redefine
			format
		end;

	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS_B;
			-- Client list

	features: EIFFEL_LIST_B [FEATURE_AS_B];
			-- Features

feature -- Export status computing

	export_status: EXPORT_I is
			-- Export status of the clause
		do
			if clients /= Void then
				Result := clients.export_status;
			else
				Result := Export_all;
			end;
		end;

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if  clients /= Void then
				ctxt.set_separator (ti_Comma);
				ctxt.space_between_tokens;
				clients.format (ctxt);
			end;
			--ctxt.put_trailing_comment (position);
			ctxt.next_line;
			ctxt.indent_one_more;
			ctxt.next_line;
			ctxt.new_line_between_tokens;
			ctxt.set_separator (Void);
			features.format (ctxt);
			ctxt.next_line;
			ctxt.commit;
		end;

	storage_info: LINKED_LIST [S_FEATURE_DATA] is
			-- Storage information of Current
		do
			from
				!! Result.make;
				features.start
			until
				features.after
			loop
				Result.put_right (features.item.storage_info);
				Result.forth;	
				features.forth
			end;
		end;

end -- class FEATURE_CLAUSE_AS_B
