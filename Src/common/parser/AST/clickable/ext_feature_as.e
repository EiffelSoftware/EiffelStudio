indexing

	description: 
		"Extended AST representation of an Eiffel feature. %
		%Keeps the comments as an attribute, instead of %
		%retrieving them each time. Also keeps position %
		%information."
	date: "$Date$"
	revision: "$Revision$"

class EXT_FEATURE_AS
		
inherit
	EXT_AST_EIFFEL
	FEATURE_AS
		redefine
			simple_format
		end

feature -- Properties

	comments: EIFFEL_COMMENTS
			-- Comments attached to the feature, if any.
			--| Kept here as an attribute, unlike in FEATURE_AS

feature {COMPILER_EXPORTER} -- Settings

	set_comments (c: like comments) is
			-- Set `comments' to `c'
		do
			comments := c
		ensure
			comments_set: comments = c
		end

feature {COMPILER_EXPORTER, AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			c: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN	
		do
			start_position := ctxt.text.position
			c := comments
			ctxt.set_feature_comments (c)
			if feature_names /= Void then
				ctxt.set_separator (ti_Comma)
				ctxt.set_space_between_tokens
				feature_names.simple_format (ctxt)
			end
			body.simple_format (ctxt)
			cont := body.content
			is_const_or_att := cont = Void or else cont.is_constant
			if is_const_or_att and then c /= Void then
				ctxt.new_line
				ctxt.indent
				ctxt.indent
				ctxt.put_comments (c)
				ctxt.exdent
				ctxt.exdent
			else
				ctxt.new_line
			end
			end_position := ctxt.text.position
		end

feature {COMPILER_EXPORTER} -- Setting

	extract_comments (e_file: EIFFEL_FILE) is
			-- Extract the comments from source file `e_file' and
			-- set `comments' accordingly.
			--| NB: This routine must be called when the processing
			--| is in current feature.
		do
			comments := e_file.current_feature_comments
		end

end -- class EXT_FEATURE_AS




