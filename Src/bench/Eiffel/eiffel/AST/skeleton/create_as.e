class CREATE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, format
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like clients; f: like feature_list) is
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Feature list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (feature_list, other.feature_list)
		end

feature -- Access

	has_feature_name (f: FEATURE_NAME): BOOLEAN is
			-- Is `f' present in current creation?
		local
			cur: CURSOR
		do
			cur := feature_list.cursor
			
			from
				feature_list.start
			until
				feature_list.after or else Result
			loop
				Result := feature_list.item <= f and feature_list.item >= f
				feature_list.forth
			end

			feature_list.go_to (cur)
		end

feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			last_was_printed: BOOLEAN
		do
			ctxt.begin
			ctxt.put_text_item (ti_Create_keyword)
			ctxt.put_space
			if clients = Void then
				last_was_printed := true
			else
				clients.format (ctxt)
				last_was_printed := ctxt.last_was_printed
			end
			if not last_was_printed then 
				ctxt.rollback; -- check whether must retain if short
			else
				if feature_list /= Void then
					ctxt.indent
					ctxt.new_line
					ctxt.set_new_line_between_tokens
					ctxt.set_classes (ctxt.class_c, ctxt.class_c)
					if ctxt.is_flat_short then
						format_features (ctxt, feature_list)
					else
						ctxt.set_separator (ti_Comma)
						feature_list.format (ctxt)
						ctxt.new_line
					end
				end
				ctxt.commit
			end
		end

feature {NONE} -- Implementation

	format_features (ctxt: FORMAT_CONTEXT; list: like feature_list) is
			-- Format the features in the creation clause,
			-- including header comment and contracts.
		local
			i, l_count: INTEGER
			item: FEATURE_NAME
			creators: HASH_TABLE [FEATURE_ADAPTER, STRING]
			feat_adapter: FEATURE_ADAPTER
		do
			ctxt.begin
			creators := ctxt.format_registration.creation_table
			from
				i := 1
				l_count := list.count
			until
				i > l_count 
			loop
				item := list.i_th (i)
				feat_adapter := creators.item (item.internal_name)
				if feat_adapter /= Void then
					feat_adapter.format (ctxt)
				end
				i := i + 1
			end
			ctxt.commit
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Create_keyword)
			ctxt.put_space
			if clients /= Void then
				clients.simple_format (ctxt)
			end
			if feature_list /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.set_separator (ti_Comma)
				ctxt.set_new_line_between_tokens
				feature_list.simple_format (ctxt)
				ctxt.new_line
			end
		end
			
feature {COMPILER_EXPORTER} -- Convenience

	set_feature_list (f: like feature_list) is
		do
			feature_list := f
		end

	set_clients (c: like clients) is
		do
			clients := c
		end

end -- class CREATE_AS
