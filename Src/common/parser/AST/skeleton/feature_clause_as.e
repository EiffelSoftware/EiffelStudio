class FEATURE_CLAUSE_AS

inherit

	AST_EIFFEL
		redefine
			format,
			position
		end;
	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS;
			-- Client list

	features: EIFFEL_LIST [FEATURE_AS];
			-- Features

feature -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
			features ?= yacc_arg (1);
			position := yacc_position;
		ensure then
			features_exists: features /= Void;
		end;

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

	position: INTEGER;
		-- position after feature [{clients}]: expected comment

	format (ctxt: FORMAT_CONTEXT) is
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

end
