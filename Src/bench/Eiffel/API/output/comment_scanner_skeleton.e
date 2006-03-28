indexing
	description: "Scanner skeleton class for COMMENT_SCANNER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMENT_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
			redefine
				reset
			end

	SHARED_EIFFEL_PROJECT

	SHARED_TEXT_ITEMS

	CONF_REFACTORING

feature {NONE} -- Initialization

	make_with_text_formatter (a_text_formatter: like text_formatter) is
			-- Initialization
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
			for_comment := True
			make
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

feature -- Element change

	reset is
			-- Reset
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			reset_last_type
		end

	set_text_formatter (a_text_formatter: like text_formatter) is
			-- Set `text_formatter' with `a_text_formatter'.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			text_formatter := a_text_formatter
		ensure
			text_formatter_not_void: text_formatter = a_text_formatter
		end

	set_for_comment (a_for_comment: BOOLEAN) is
			-- Set `for_comment' with `a_for_comment'.
		do
			for_comment := a_for_comment
		ensure
			for_comment_set: for_comment = a_for_comment
		end

feature {NONE} -- Implementation

	add_email_tokens is
			-- Email address encountered.
		local
			l_text : like text
		do
			l_text := text
			if for_comment then
				text_formatter.process_comment_text (l_text, "mailto:" + l_text)
			else
				text_formatter.process_string_text (l_text, "mailto:" + l_text)
			end
		end

	add_url_tokens is
			-- URL encountered.
		local
			l_text : like text
		do
			l_text := text
			if for_comment then
				text_formatter.process_comment_text (l_text, l_text.twin)
			else
				text_formatter.process_string_text (l_text, l_text.twin)
			end
		end

	add_dot_feature is
			-- A feature like {CLASS}.feature encountered.
		local
			l_text : like text
			l_feat_name: STRING
			l_feat: E_FEATURE
		do
			l_text := text
			l_feat_name := l_text.twin
			l_feat_name.keep_tail (l_text.count - 1)
			l_feat := feature_by_name (l_feat_name)
			if l_feat /= Void then
				text_formatter.process_symbol_text (ti_dot)
				text_formatter.process_feature_text (l_feat_name, l_feat, false)
				if not l_feat.is_procedure then
					last_type := l_feat.type.actual_type
				else
					reset_last_type
				end
			else
				add_text (l_text)
				reset_last_type
			end
		end

	add_quote_feature is
			-- A feature like `feature' encountered.
		local
			l_text : like text
			l_feat_name: STRING
			l_feat: E_FEATURE
		do
			l_text := text
			check
				l_text.count > 2
			end
			l_feat_name := l_text
			l_feat_name := l_text.substring (2, l_text.count - 1)
			if eiffel_system.system.current_class /= Void then
				last_type := eiffel_system.system.current_class.actual_type
			end
			l_feat := feature_by_name (l_feat_name)
			if l_feat /= Void then
				text_formatter.process_feature_text (l_feat_name, l_feat, false)
			else
				add_text (l_text)
			end
		end

	add_class is
			-- A class like {CLASS} encountered.
		local
			l_text : like text
			l_class_name: STRING
			l_class: CLASS_I
		do
			l_text := text
			check
				l_text.count > 2
			end
			l_class_name := l_text.substring (2, l_text.count - 1)
			l_class := class_by_name (l_class_name)
			if l_class /= Void then
				text_formatter.process_symbol_text (ti_l_curly)
				text_formatter.process_class_name_text (l_class_name, l_class, False)
				text_formatter.process_symbol_text (ti_r_curly)
				if l_class.is_compiled then
					last_type := l_class.compiled_class.actual_type
				end
			else
				add_text (l_text)
			end
		end

	add_cluster is
			-- A cluster like [cluster] encountered.
		local
--			l_text : like text
--			l_cluster_name: STRING
--			l_cluster: CLUSTER_I
		do
--			l_text := text
--			check
--				l_text.count > 2
--			end
--			l_cluster_name := l_text.substring (2, l_text.count - 1)
--			l_cluster := cluster_by_name (l_cluster_name)
--			if l_cluster /= Void then
--				text_formatter.process_cluster_name_text (l_cluster_name, l_cluster, False)
--			else
--				add_text (l_text)
--			end
		end

	add_text (a_text: STRING) is
			-- Add `a_text' as normal text.
		require
			a_text_not_void: a_text /= Void
		do
			if not a_text.is_empty then
				if for_comment then
					text_formatter.process_comment_text (a_text, Void)
				else
					text_formatter.process_string_text (a_text, Void)
				end
			end
		end

	text_formatter: TEXT_FORMATTER
			-- Output text formatter.

	for_comment: BOOLEAN;
			-- Texts are for comment?
			-- Or verbatim string

feature {NONE} -- Helpers

	last_type: TYPE_A
			-- Class context where feature should be analysed.

	reset_last_type is
			-- Reset `last_type'
		do
			last_type := Void
		end

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
			is_class_name: (create {IDENTIFIER_CHECKER}).is_valid_upper (name)
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

--	cluster_by_name (name: STRING): CLUSTER_I is
--			-- Return cluster with `name'. `Void' if not in system.
--		require
--			name_not_void: name /= Void
--		do
--			Result := Eiffel_universe.cluster_of_name (name)
--		end

	feature_by_name (name: STRING): E_FEATURE is
			-- Return feature in current class with `name'. `Void' if not in system.
		local
			cc: CLASS_C
		do
			if last_type /= Void then
				cc := last_type.associated_class
			end
			if cc /= Void then
				Result := cc.feature_with_name (name)
			end
		end

invariant
	invariant_clause: True -- Your invariant here

end
