indexing
	description: 
		"Extended AST representation of a feature clause structure. %
		%Keeps the comments as an attribute, instead of %
		%retrieving them each time. Also keeps position information."
	date: "$Date$"
	revision: "$Revision$"

class EXT_FEATURE_CLAUSE_AS

inherit
	EXT_AST_EIFFEL
	FEATURE_CLAUSE_AS
		redefine
			features, simple_format, features_simple_format,
			has_equiv_declaration
		end

creation

	make_from_other_and_features

feature -- Initialization

	make_from_other_and_features (other: like Current; flist: like features) is
			-- Create a feature clause similar to `other' in every aspect,
			-- except that the feature list will be `flist'
		do
			clients := other.clients
			position := other.position
			comments := other.comments
			end_position := other.end_position
			start_position := other.start_position
			features := flist
		end

feature -- Properties

	comments: EIFFEL_COMMENTS
			-- Comments associated to Current feature clause
			--| Kept in an attribute, unlike in FEATURE_CLAUSE_AS

	features: EIFFEL_LIST [EXT_FEATURE_AS]
			-- Features

	start_position, end_position: INTEGER
			-- Beginning and end of the feature clause, in character
			--| Valid only after `simple_format' has been called.

feature {COMPILER_EXPORTER} -- Settings

	set_comments (c: like comments) is
			-- Set `comments' to `c'
		do
			comments := c
		ensure
			comments_set: comments = c
		end

feature -- Access

	has_equiv_declaration (other: like Current): BOOLEAN is
			-- Has this feature clause a declaration equivalent to `other' 
			-- feature clause? i.e. `feature {CLIENTS} -- Comment'
		do
			if other /= Void then
				if has_same_clients (other) then
					Result := equal (comments, other.comments)
				end
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			c: like comments
		do
			start_position := ctxt.text.position
			ctxt.put_text_item (ti_Feature_keyword)
			ctxt.put_space
			if clients /= Void then
				ctxt.set_separator (ti_Comma)
				ctxt.set_space_between_tokens
				clients.simple_format (ctxt)
			end
			c := comments
			if c = Void then
				ctxt.new_line
			else
				if c.count > 1 then
					ctxt.indent
					ctxt.indent
					ctxt.new_line
					ctxt.put_comments (c)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_space
					ctxt.put_comments (c)
				end
			end
			ctxt.new_line
			ctxt.indent
			ctxt.set_new_line_between_tokens
			ctxt.set_separator (ti_Empty)
			features_simple_format (ctxt)
			ctxt.exdent
			end_position := ctxt.text.position
		end

feature {COMPILER_EXPORTER} -- Setting

	extract_comments (e_file: EIFFEL_FILE) is
			-- Extract the comments for Current feature clause and
			-- its features.
		local
			i, l_count: INTEGER
			f: like features
			next_feat, feat: EXT_FEATURE_AS
		do
			comments := e_file.current_feature_clause_comments
			f := features
			from
				i := 1
				l_count := f.count
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
				feat.extract_comments (e_file)
				feat := next_feat
			end
		end

feature {NONE} -- Implementation

	features_simple_format (ctxt :FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER
			f: like features
			feat: EXT_FEATURE_AS
		do
			f := features
			ctxt.begin
			from
				i := 1
				l_count := f.count
			until
				i > l_count
			loop
				ctxt.new_expression
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				feat := f.i_th (i)
				feat.simple_format (ctxt)
				i := i + 1
				ctxt.commit
			end
			ctxt.commit
		end

end -- class EXT_FEATURE_CLAUSE_AS
