indexing
	description: "AST representation of a feature clause structure."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_CLAUSE_AS

inherit
	AST_EIFFEL
		redefine
			position, is_equivalent
		end
	
	SHARED_EXPORT_STATUS

feature {AST_FACTORY} -- Initialization

	initialize (c: like clients; f: like features; p: INTEGER) is
			-- Create a new FEATURE_CLAUSE AST node.
		require
			f_not_void: f /= Void
			p_non_negative: p > 0
		do
			clients := c
			features := f
			position := p
		ensure
			clients_set: clients = c
			features_set: features = f
			position_set: position = p
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	features: EIFFEL_LIST [FEATURE_AS]
			-- Features

	position: INTEGER
			-- Position after feature keyword

	comment (class_text: STRING): STRING is
			-- Extract first line of comments on `Current' from `class_text'.
		require
			class_text_not_void: class_text /= Void
		local
			end_pos, real_pos: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				real_pos := class_text.substring_index ("--", position)
				if real_pos /= 0 then
					if not features.is_empty then
						end_pos := features.first.start_position
					end
					if end_pos = 0 or else real_pos < end_pos then
						Result := class_text.substring (real_pos + 2, class_text.index_of ('%N', real_pos) - 1)
						Result.prune_all_leading (' ')
					else
						create Result.make (0)
					end
				else
					create Result.make (0)
				end
			else
				create Result.make (0)
			end
		ensure
			not_void: Result /= Void
		rescue
				-- `Position' might not be up-to-date, so that we may look after the end of the file.
			retried := True
			retry
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (features, other.features)
		end

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature ast with internal name `n'
		local
			saved: INTEGER
		do
			saved := features.index
			from
				features.start
			until
				features.after or else Result /= Void
			loop
				Result := features.item.feature_with_name (n)
				features.forth
			end
			features.go_i_th (saved)
		end

	has_feature (f: FEATURE_AS): BOOLEAN is
			-- Does `f' appear in current feature clause?
			--| Based on `object_comparison' of EIFFEL_LIST,
			--| which is a reference comparison.
		local
			saved: INTEGER
			name: STRING
		do
			saved := features.index
			name := f.feature_name
			from
				features.start
			until
				features.after
			loop
				if features.item.feature_name.is_equal (name) then
					Result := True
					features.finish
				end
				features.forth
			end
			features.go_i_th (saved)
		end

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does `n' appear in current feature clause?
		local
			saved: INTEGER
		do
			saved := features.index
			from
				features.start
			until
				features.after or else Result
			loop
				Result := features.item.has_feature_name (n)
				features.forth
			end
			features.go_i_th (saved)
		end

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
		end

	has_equiv_declaration (other: like Current): BOOLEAN is
			-- Has this feature clause a declaration equivalent to `other' 
			-- feature clause? i.e. `feature {CLIENTS}'
			--| NB: The comments are NOT considered for the moment, since 
			--| comments are not an attribute, but are to be retrieved from 
			--| the file that contains the source code.
		do
			if other = Void then
				Result := False
			else
				Result := has_same_clients (other)
					--| To be fixed to take comments into account
			end
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' feature clause equivalent to Current?
		require
			valid_other: other /= Void
		do
			Result := 
				equivalent (clients, other.clients) and then
				equivalent (features, other.features)	
		end

feature -- Export status computing

	export_status: EXPORT_I is
			-- Export status of the clause
		do
			if clients /= Void then
				Result := clients.export_status
			else
				Result := Export_all
			end
		end

feature {CLASS_AS} -- Implementation

	register_features (ast_reg: AST_REGISTRATION) is
			-- Register features in `ast_reg'.
		require
			valid_arg: ast_reg /= Void
		local
			f: like features
			feat, next_feat: FEATURE_AS
			i, l_count: INTEGER
			e_file: EIFFEL_FILE
		do
			f := features
			i := 1
			l_count := f.count
			if ast_reg.already_extracted_comments then
					-- This means that the comments are already 
					-- extracted so there is no record additional 
					-- information to extract comments.
				from
				until
					i > l_count
				loop
					ast_reg.register_feature (f.i_th (i))
					i := i + 1
				end
			else
				e_file := ast_reg.eiffel_file
					-- This means we are registering non precompiled
					-- features for an eiffel project or we are
					-- current precompiling features.
				from
					if l_count > 0 then
						feat := f.i_th (1)
					end
				until
					i > l_count
				loop
					i := i + 1
					if i > l_count then
						e_file.set_next_feature (Void)
					else
						next_feat := f.i_th (i)
						e_file.set_next_feature (next_feat)
					end
					e_file.set_current_feature (feat)
					ast_reg.register_feature (feat)
					feat := next_feat
				end
			end
		end

feature -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

feature {COMPILER_EXPORTER, CLASS_AS} -- Element change

	--| NB: Since fixed structures are used, the following operations
	--| are generally very expensive...

	add_feature (new_f: FEATURE_AS) is
			-- Add `new_f' at end of Current of feature clause 
			--| (easier for offsets)
		require
			new_f_exists: new_f /= Void
		local
			saved, feat_count, i, new_sp, new_ep: INTEGER
			old_features: like features
			feat: FEATURE_AS
		do
				--| Since `features' is an heir of FIXED_LIST,
				--| it's impossible to directly add an element...
				--| Hence the following rather inefficient algorithm:
			saved := features.index
			old_features := features
			feat_count := old_features.count
			!! features.make_filled (feat_count + 1)
			from
				i := 1
			until
				 i > feat_count
			loop
				feat := old_features.i_th (i)
				features.put_i_th (feat, i)
				i := i + 1
			end
			new_sp := feat.end_position
				--| beginning of new feature is the end of the previous one
			new_ep := new_f.end_position - new_f.start_position + new_sp
			new_f.update_positions (new_sp, new_ep)
			features.put_i_th (new_f, i)
			features.go_i_th (saved)
	end

	remove_feature (f: FEATURE_AS) is
			-- Remove feature `f' from Current feature clause.
		require
			f_exists: f /= Void
			has_f: features.has (f)
		local
			old_features: like features
			saved, i, feat_count, offset: INTEGER
			feat: FEATURE_AS
		do
			saved := features.index
			old_features := features
			feat_count := old_features.count
			!! features.make_filled (feat_count - 1)
			from
				i := 1
				feat := old_features.first
			until
				feat = f
			loop
				features.put_i_th (feat, i)
				i := i + 1
				feat := old_features.i_th (i)
			end
			from
				offset := - (f.end_position - f.start_position + 4)
					--| feature size + 1 semicolumn + 2 new lines
				i := i + 1
			until
				i > feat_count
			loop
				feat := old_features.i_th (i)
				feat.update_positions_with_offset (offset)
				features.put_i_th (feat, i - 1)
				i := i + 1
			end
			if features.valid_cursor_index (saved) then
				features.go_i_th (saved)
			end
		end

	replace_feature (old_f, new_f: FEATURE_AS) is
			-- Replace feature `old_f' by feature `new_f'
		require
			old_f_exists: old_f /= Void
			new_f_exists: new_f /= Void
			has_old_f: features.has (old_f)
		local
			feat_count, i, offset, new_sp, new_ep: INTEGER
			feat: FEATURE_AS
		do
			feat_count := features.count
			from
				i := 1
			until
				feat = old_f
			loop
				feat := features.i_th (i)
				i := i + 1
			end
			new_sp := old_f.start_position
			new_ep := (new_f.end_position - new_f.start_position) + new_sp
			new_f.update_positions (new_sp, new_ep)
			features.put_i_th (new_f, i - 1)
			from
				offset := new_f.end_position - old_f.end_position
			until
				i > feat_count
			loop
				feat := features.i_th (i)
				feat.update_positions_with_offset (offset)
				i := i + 1
			end
		end

	update_positions_with_offset (offset: INTEGER) is
			-- Add `offset' to the position information
			-- of features belonging to Current feature clause.
		local
			feat_count, i: INTEGER
			feat: FEATURE_AS
		do
			feat_count := features.count
			from
				i := 1
			until
				i > feat_count
			loop
				feat := features.i_th (i)
				feat.update_positions_with_offset (offset)
				i := i + 1
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			comments: EIFFEL_COMMENTS
		do
			ctxt.put_text_item (ti_Feature_keyword)
			ctxt.put_space
			if clients /= Void then
				ctxt.set_separator (ti_Comma)
				ctxt.set_space_between_tokens
				clients.simple_format (ctxt)
			end
			comments := ctxt.eiffel_file.current_feature_clause_comments
			if comments = Void then
				ctxt.new_line
			else
				if comments.count > 1 then
					ctxt.indent
					ctxt.indent
					ctxt.new_line
					ctxt.put_comments (comments)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_space
					ctxt.put_comments (comments)
				end
			end
			ctxt.new_line
			ctxt.indent
			ctxt.set_new_line_between_tokens
			ctxt.set_separator (ti_Empty)
			features_simple_format (ctxt)
			ctxt.exdent
		end

	features_simple_format (ctxt :FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER
			f: like features
			next_feat, feat: FEATURE_AS
			e_file: EIFFEL_FILE
		do
			f := features
			ctxt.begin
			e_file := ctxt.eiffel_file
			from
				i := 1
				l_count := f.count
				if l_count > 0 then		
					feat := f.i_th (1)
				end
			until
				i > l_count
			loop
				ctxt.new_expression
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i := i + 1
				if i > l_count then
					e_file.set_next_feature (Void)
				else
					next_feat := f.i_th (i)
					e_file.set_next_feature (next_feat)
				end
				e_file.set_current_feature (feat)
				feat.simple_format (ctxt)
				feat := next_feat
				ctxt.commit
			end
			ctxt.commit
		end

feature {COMPILER_EXPORTER} -- Setting

	set_features (f: like features) is
			-- Set `features' to `f'
		do
			features := f
		end

	set_clients (c: like clients) is
			-- Set `clients' to `c'
		do
			clients := c
		end

end -- class FEATURE_CLAUSE_AS
