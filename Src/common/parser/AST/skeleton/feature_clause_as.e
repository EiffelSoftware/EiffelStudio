class FEATURE_CLAUSE_AS

inherit

	AST_EIFFEL
		redefine
			position
		end;

feature -- Propertoes

	clients: CLIENT_AS;
			-- Client list

	features: EIFFEL_LIST [FEATURE_AS];
			-- Features

	comment: EIFFEL_COMMENTS is
			-- Feature clause comments
		do	
		end;

	position: INTEGER;
		-- Position after feature [{clients}]: 
		-- expected comment

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

feature
		
	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does `n' appear in current feature clause?
		local
			cur: CURSOR
		do
			cur := features.cursor

			from
				features.start
			until
				features.after or else Result
			loop
				Result := features.item.has_feature_name (n)
				features.forth
			end
	
			features.go_to (cur)	
		end;

	has_same_clients (other: like Current): BOOLEAN is
			-- Does this feature clause have the same clients
			-- as `other' feature clause?
		do
			Result := clients = Void and other.clients = Void

			if not Result then
				if clients /= Void then
					if other.clients /= Void then
						Result := clients.is_equiv (other.clients)
					else
						Result := False
					end
				end
			end
		end;

	has_equiv_declaration (other: like Current): BOOLEAN is
		-- Has this feature clause a declaration equivalent to `other' feature clause?
		-- i.e. `feature {CLIENTS} -- Comment'
		do
			if other = Void then
				Result := False
			else
				if clients = Void and other.clients = Void and then
					equal (comment, other.comment) then
						Result := True
				elseif clients /= Void and then other.clients /= Void  then
					Result := clients.is_equiv (other.clients) and then
						equal (comment, other.comment)
				end
			end
		end;

	features_deep_equal (other: like features): BOOLEAN is
		do
			if features = Void and other = Void then
				Result := True
			elseif features /= Void and then
				other /= Void and then
				other.count = features.count
			then
				Result := True
				from
					features.start;
					other.start
				until
					features.after or else not Result
				loop
					Result := features.item.is_equiv (other.item)
					features.forth
					other.forth
				end
			end
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' feature clause equivalent to Current?
		require
			valid_other: other /= Void
		do
			Result := 
				deep_equal (clients, other.clients) and then
				features_deep_equal (other.features)	
		end

feature -- Setting

	set_features (f: like features) is
		do
			features := f
		end;

	set_clients (c: like clients) is
		do
			clients := c
		end;

	set_comment (c: EIFFEL_COMMENTS) is
			-- Set comment for clause.
		do
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Feature_keyword)
			ctxt.put_space
			if clients /= Void then
				ctxt.set_separator (ti_Comma);
				ctxt.set_space_between_tokens;
				clients.simple_format (ctxt);
			end;
			if comment = Void then
				ctxt.new_line
			else
				if comment.count > 1 then
					ctxt.indent
					ctxt.indent
					ctxt.new_line
					ctxt.put_comment (comment)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_space;
					ctxt.put_comment (comment)
				end
			end
			ctxt.new_line;
			ctxt.indent;
			ctxt.set_new_line_between_tokens;
			ctxt.set_separator (Void);
			features.simple_format (ctxt);
			ctxt.exdent;
		end;

end -- class FEATURE_CLAUSE_AS
