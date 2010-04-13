note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLASS_STRUCTURE

inherit
	STRING_HANDLER

create
	make,
	make_with_string,
	make_with_filename

feature {NONE} -- Initialization

	make
		do
			initialize
		end

	make_with_filename (fn: STRING)
			-- Make with filename `fn'
		do
			initialize
			get_structure (fn)
		end

	make_with_string (txt: STRING)
			-- Make with string `txt'
		do
			initialize
			get_structure_from_string (txt)
		end

	initialize
			-- Initialize internal data
		do
			create factory
			has_syntax_warning := False
			is_note_keyword := True
			is_indexing_keyword := True
			is_attribute_keyword := True

			create parser.make_with_factory (factory)
				-- Enabling `il_parsing' only means accepting more, not accepting less
				-- which is important to allow for such a syntax converter
			parser.set_il_parser
			parser.set_syntax_version (parser.transitional_64_syntax)
--			parser.set_is_note_keyword (is_note_keyword)
--			parser.set_is_attribute_keyword (is_attribute_keyword)
--			parser.set_is_indexing_keyword (is_indexing_keyword)
			parser.set_has_syntax_warning (has_syntax_warning)
			create visitor.make_with_default_context

			create string_buffer.make (102400)
		end

feature -- Access

	has_structure: BOOLEAN
			-- Has structure?
		do
			Result := attached class_as as c and then c.features /= Void
		end

	class_as: detachable CLASS_AS
			-- Associated CLASS_AS

	structure: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- Scanned structure
		require
			has_structure: has_structure
		do
			Result := class_as.features
		end

feature -- Options

	is_note_keyword: BOOLEAN
	is_indexing_keyword: BOOLEAN
	is_attribute_keyword: BOOLEAN
	has_syntax_warning: BOOLEAN

feature -- Element change

	move_feature (f_as: AST_EIFFEL; tgt_f_c_as: AST_EIFFEL; ref_f_as: AST_EIFFEL)
			-- Move feature `f_as' to feature clause `tgt_f_c_as'
			-- if ref_f_as is attached, insert before ref_f_as
		local
			t: STRING
		do
			t := f_as.text (match_list)
			if ref_f_as /= Void then
				ref_f_as.prepend_text (t + "%N%N%T" , match_list)
				f_as.remove_text (match_list)
			else
				tgt_f_c_as.append_text ("%T" + t + "%N%N", match_list)
				f_as.remove_text (match_list)
			end
		end

	move_feature_clause (f_c_as, tgt_f_c_as: AST_EIFFEL)
			-- Move feature clause `f_c_as' to `tgt_f_c_as'
		local
			t: STRING
		do
			t := f_c_as.text (match_list)
			tgt_f_c_as.prepend_text (t, match_list)
			f_c_as.remove_text (match_list)
		end

	remove_feature_clause (fc_as: FEATURE_CLAUSE_AS)
			-- Remove feature clause `fc_as'
		do
			fc_as.remove_text (match_list)
		end

	insert_feature_clause (fc_t, fc_x: STRING; fc_as: FEATURE_CLAUSE_AS)
			-- Insert new feature clause `fc_as'
			-- with comment `fc_t' and export clause `fc_x'
		require
			fc_t_attached: fc_t /= Void
			fc_as_attached: fc_as /= Void
		local
			s: STRING
		do
			s := "feature"
			if fc_x /= Void then
				s.append (" {" + fc_x + "}")
			end
			s.append (" -- " + fc_t)
			s.append_character ('%N')
			s.append_character ('%N')

			fc_as.prepend_text (s, match_list)
		end

	update_feature_clause_comment (a_fc_as: FEATURE_CLAUSE_AS; a_txt: STRING)
			-- Update comment of the feature clause `a_fc_as' with `a_txt'
		local
			s, t, tn: STRING
			i,j: INTEGER
		do
			s := a_txt.twin
			s.left_adjust
			s.right_adjust
			s.prepend ("-- ")

			t := a_fc_as.text (match_list)
			i := t.substring_index ("--", 1)
			if i > 0 then
				j := t.index_of ('%N', i)
				t := t.substring (i, j - 1)
			else
					-- No feature clause name...
				i := 1
				j := t.index_of ('%N', i)
				t := t.substring (i, j - 1)
				tn := t.twin
				tn.right_adjust
				tn.append_character (' ')
				s.prepend (tn)
			end
			a_fc_as.replace_subtext (t, s, True, match_list)
		end

feature -- Basic operations

	get_structure (file_name: STRING)
			-- Compute `structure' from file `file_name'
		require
			file_name_not_void: file_name /= Void
		local
			file: KL_BINARY_INPUT_FILE
			count, nb: INTEGER
		do
			class_as := Void
			if file_name.substring (file_name.count - 1, file_name.count).is_case_insensitive_equal (".e") then
				create file.make (file_name)
				if file.exists then
					count := file.count
					file.open_read
					if file.is_open_read then
						if string_buffer.count < count then
							string_buffer.resize (count)
						end
						string_buffer.set_count (count)
						nb := file.read_to_string (string_buffer, 1, count)
						string_buffer.set_count (nb)
						file.close

						get_structure_from_string (string_buffer)
					else
						io.error.put_string ("Couldn't open: " + file_name)
						io.error.put_new_line
					end
				else
					io.error.put_string ("Couldn't find: " + file_name)
					io.error.put_new_line
				end
			end
		end

	get_structure_from_string (a_string_buffer: STRING)
			-- Compute `structure' from buffer `a_string_buffer'
		require
			string_buffer_not_void: a_string_buffer /= Void
		do
			class_as := Void

			string_buffer := a_string_buffer

				-- Slow parsing to rewrite the class using the new constructs.
			parser.set_has_syntax_warning (False)
--			parser.set_is_note_keyword (True)
--			parser.set_is_attribute_keyword (True)
			parser.parse_from_string (a_string_buffer, Void)
			if parser.error_count = 0 then
				match_list := parser.match_list
				visitor.reset
				visitor.setup (parser.root_node, match_list, True, True)
					-- Free some memory from the parser that we don't need.
				parser.reset
				parser.reset_nodes
					-- Perform the visiting
				visitor.process_ast_node (visitor.parsed_class)
				class_as := visitor.parsed_class
				-- Free our memory.
				visitor.reset
			else
				print ("ERROR: " + parser.error_message + "%N")
				parser.reset
				parser.reset_nodes
			end
		end

	class_text: STRING
			-- `structure' to class text
		require
			has_structure: has_structure
		do
--			Result := visitor.text
			Result := class_as.text (match_list)
--			Result := structure_to_string
		end

	structure_to_string: STRING
			-- `structure' to STRING value
		require
			structure_attached: structure /= Void
		local
			l_as: FEATURE_CLAUSE_AS
			cm: EIFFEL_COMMENTS
			s: STRING
			cl: CLIENT_AS
			class_list: CLASS_LIST_AS
			feats: EIFFEL_LIST [FEATURE_AS]
			f: FEATURE_AS
			fn: FEATURE_NAME
			struct: like structure
		do
			struct := structure
			if struct /= Void then
				from
					create Result.make_empty
					struct.start
				until
					struct.after
				loop
					l_as := struct.item
					Result.append ("Feature clause ")
						--| Name
					Result.append ("[")
					cm := l_as.comment (match_list)
					if cm /= Void and then not cm.is_empty then
						s := comments_to_string (Void, cm)
						s.left_adjust
						Result.append (s)
					end
					Result.append ("]")
						--| Export
					cl := l_as.clients
					if cl /= Void then
						class_list := cl.clients
						if class_list /= Void and then not class_list.is_empty then
							Result.append (" <")
							from
								class_list.start
							until
								class_list.after
							loop
								s := class_list.item.text (match_list)
								if s /= Void then
									Result.append (s)
								end
								if not class_list.islast then
									Result.append (",")
								end
								class_list.forth
							end
							Result.append (">")
						end
					end

						--| Position
					Result.append (" (")
					Result.append_integer (l_as.feature_keyword.end_position)
					Result.append (",")
					Result.append_integer (l_as.feature_clause_end_position)
					Result.append (")")
					Result.append_character ('%N')

					feats := l_as.features
					if feats /= Void and then not feats.is_empty then
						from
							feats.start
						until
							feats.after
						loop
							f := feats.item
							Result.append_string ("  + ")
							if attached f.feature_names as fnames and then not fnames.is_empty then
								from
									fnames.start
								until
									fnames.after
								loop
									fn := fnames.item
									Result.append_string (fn.text (match_list))
									if not fnames.islast then
										Result.append_string (", ")
									end
									fnames.forth
								end
							else
								Result.append_string (f.feature_name.text (match_list))
							end
							Result.append_character ('%N')
							s := comments_to_string ("  %T--", f.comment (match_list))
							Result.append_string (s)

							Result.append_character ('%N')
							feats.forth
						end
					end
					struct.forth
				end
			end
		end

	display_structure, print_structure
			-- Display `struct'
		require
			structure_attached: structure /= Void
		do
			print (structure_to_string)
		end

feature -- Access

	ast_text (ast: AST_EIFFEL): STRING
			-- String representation of `ast'
		do
			Result := ast.text (match_list)
		end

	feature_clause_comment (a_fc_as: FEATURE_CLAUSE_AS): STRING
			-- Comment extrated from `a_fc_as'
		local
			cm: EIFFEL_COMMENTS
		do
			create Result.make_empty
			cm := a_fc_as.comment (match_list)
			if cm /= Void and then not cm.is_empty then
				Result.append_string (comments_to_string (Void, cm))
				Result.left_adjust
			end
		end

	feature_class_exports (a_fc_as: FEATURE_CLAUSE_AS): LIST [STRING]
			-- Export classes
		local
			cl: CLIENT_AS
			class_list: CLASS_LIST_AS
		do
			cl := a_fc_as.clients
			if cl /= Void then
				class_list := cl.clients
				if class_list /= Void and then not class_list.is_empty then
					create {ARRAYED_LIST [STRING]} Result.make (class_list.count)
					from
						class_list.start
					until
						class_list.after
					loop
						Result.extend (class_list.item.text (match_list))
						class_list.forth
					end
				end
			end
		end

	feature_names (a_f_as: FEATURE_AS): LIST [STRING]
			-- Feature names under feature clause `a_f_as'
		local
			fn: FEATURE_NAME
		do
			if attached a_f_as.feature_names as fnames and then not fnames.is_empty then
				from
					create {ARRAYED_LIST [STRING]} Result.make (fnames.count)
					fnames.start
				until
					fnames.after
				loop
					fn := fnames.item
					Result.extend (fn.text (match_list).twin)
					fnames.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (1)
				Result.extend (a_f_as.feature_name.text (match_list).twin)
			end
		ensure
			Result_attached: Result /= Void and then Result.count >= 1
		end

	feature_comments_to_string (a_f_as: FEATURE_AS): STRING
			-- Comment extrated from `a_f_as'
		do
			create Result.make_empty
			Result.append_string (comments_to_string ("", a_f_as.comment (match_list)))
		end

	update_text_information (t: TUPLE [s, e: INTEGER; s_offset, e_offset: INTEGER; t: STRING_32])
			-- Update text information
		local
			buf: like string_buffer
			l_s, l_e, p: INTEGER
			s: STRING
		do
			buf := string_buffer

			l_s := t.s
			if t.s_offset /= 0 then
				l_s := l_s + t.s_offset
			else
				from until buf.item (l_s) = '%N' or l_s = 1 loop
					l_s := l_s - 1
				end
				if buf.item(l_s) = '%N' then
					l_s := l_s + 1
				end
			end

			l_e := t.e
			if t.e_offset /= 0 then
				l_e := l_e + t.e_offset
			else
				from until buf.item (l_e) = '%N' or l_e = buf.count	loop
					l_e := l_e + 1
				end
				p := buf.index_of ('%N', l_e + 1)
				if p > l_e then
					s := buf.substring (l_e + 1, p)
					s.left_adjust
					if s.is_empty then
						l_e := p
					end
				end
				if buf.item(l_e) = '%N' then
					l_e := l_e - 1
				end
			end

			t.s_offset := l_s - t.s
			t.e_offset := l_e - t.e
			t.t := string_buffer.substring (l_s, l_e)
		end

feature {NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- List of tokens

	comments_to_string (a_offset: STRING; a_comments: EIFFEL_COMMENTS): STRING
			-- `a_comments' to string value
		require
			a_comments_attached: a_comments /= Void
		local
			line: EIFFEL_COMMENT_LINE
		do
			from
				create Result.make_empty
				a_comments.start
			until
				a_comments.after
			loop
				line := a_comments.item
				if a_offset /= Void then
					Result.append (a_offset)
				end
				Result.append_string (line.content)
				if not a_comments.islast then
					Result.append ("%N")
				end
				a_comments.forth
			end
		end

	parser: EIFFEL_PARSER
	factory: AST_ROUNDTRIP_FACTORY
	visitor: CLASS_STRUCTURE_VISITOR
			-- Factories and visitors being used for parsing.

	string_buffer: STRING
			-- Buffer for reading Eiffel classes.

invariant
	parser_not_void: parser /= Void
	fast_parser_not_void: parser /= Void
	factory_not_void: factory /= Void
	string_buffer_not_void: string_buffer /= Void

end
