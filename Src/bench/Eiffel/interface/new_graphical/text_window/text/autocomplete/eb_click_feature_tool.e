indexing
	description: "Object that analyze a feature text to make it clickable"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICK_FEATURE_TOOL

inherit
	EB_CLASS_INFO_ANALYZER

create
	default_create

feature -- Initialization

	initialize (feat: E_FEATURE) is
			-- initialize the tool before analyzing a class called `a_classname' located in cluster called `a_cluster_name'
			-- `a_content' is text of this class
		require
			feat_is_not_void: feat /= Void
		local
			current_class_i: CLASS_I
			class_c: CLASS_C
			current_feature: E_FEATURE
		do
			class_c := feat.written_class
			can_analyze_current_class := False
			if class_c /= Void and then not Workbench.is_compiling then
				current_class_name := class_c.name
				current_feature_name := feat.name
				cluster_name := class_c.cluster.cluster_name
				is_ready := False
	 			current_class_i := Universe.class_named (current_class_name, Universe.cluster_of_name (cluster_name))
				if current_class_i /= Void and then current_class_i.compiled and then not current_class_i.date_has_changed then
					class_c := current_class_i.compiled_class
					if class_c.has_feature_table then
						generate_ast (class_c, False)
						if last_syntax_error = Void and then current_class_as /= Void then
							current_feature := class_c.feature_with_name (current_feature_name)
							if current_feature /= Void then
								current_feature_as := current_feature.ast
								if feat.associated_class /= Void then
									current_class_name := feat.associated_class.name
									cluster_name := feat.associated_class.cluster.cluster_name
									can_analyze_current_class := True
								end
							end
						end
					end
				end
			end
		end

	set_content (a_content: CLICKABLE_TEXT) is
		require
			content_is_not_void: a_content /= Void
			can_analyze: can_analyze_current_class
		do
			content := a_content
		end

feature -- Basic operation

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
		local
			ft		: FEATURE_AS
			feat		: E_FEATURE
			a_position	: INTEGER
			token		: EDITOR_TOKEN
			line		: EDITOR_LINE
		do
			initialize_context
			if context_initialized_successfully then
				feat := current_class_c.feature_with_name (current_feature_name)
				if feat /= Void then
					ft := feat.ast
					feat := Void
				end
				token := cursor.token
				line := cursor.line
				a_position := token.pos_in_text
				Result := stone_in_click_ast (a_position)
				if Result = Void and then ft /= Void then 
					inspect
						feature_part_at (token, line)
					when instruction_part then
						feat := described_feature (token, line, ft)
					when assertion_part then
						feat := described_feature (token, line, ft)
					else
					end
				end
				if feat /= Void then
					create {FEATURE_STONE} Result.make (feat)
				end
			end
			reset_after_search
		end


feature -- Analysis preparation

	prepare_on_click_analysis is
			-- gather information necessary to analysis
		do
			reset_positions
			make_click_list_from_ast
			is_ready := True
		end

	update is
		do
		end

	reset_positions is
			-- look for position of subsection of class text (inherit, invariant, creation..)
			-- and set the `pos_in_text' attribute of interesting tokens.
		require
			class_as_already_built: current_class_as /= Void
			content_not_void: content /= Void
		local
			token: EDITOR_TOKEN
			line: EDITOR_LINE
		do
			split_string := False
			pos_in_file := 0
			from
				content.start
				line := content.current_line
				token := line.first_token
			until
				token = Void or token_image_is_same_as_word (token, current_feature_name)
			loop
				if token.next /= Void then
					token := token.next
				elseif line.next /= Void then
					line := line.next
					token := line.first_token
				else
					token := Void
				end
			end
			if token = Void or else current_feature_as = Void then
				error := True
			else
				pos_in_file := current_feature_as.start_position
				token.set_pos_in_text (pos_in_file)
			end
			from
			until
				error or else token = Void
			loop
				if token.is_text then
					if is_keyword (token) then
							-- no interesting token : skip
					elseif is_comment (token) then
							-- no interesting token : skip
					elseif is_string (token) then
							-- no interesting token : skip

							-- If a string is written one several lines (more than 2 in fact),
							-- it will be made of several token, some of which may not be
							-- string tokens (those like % .... % ) 
						if token.image @ token.image.count /= '%"' then
							from
								if token.next /= Void then
									pos_in_file := token.length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if platform_is_windows then
										pos_in_file := pos_in_file + 1
									end
									token := line.first_token
								end
							invariant
								token /= Void
							until
								is_string (token)
							loop
								if token.next /= Void then
									pos_in_file := token.length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if platform_is_windows then
										pos_in_file := pos_in_file + 1
									end
									token := line.first_token
								else
									token := Void
								end
							end
						end
					else
							-- "Normal" text token
						token.set_pos_in_text (pos_in_file)						
					end
				end
				if token.next /= Void then
					pos_in_file := token.length + pos_in_file
					token := token.next
				elseif line.next /= Void then
					line := line.next
					pos_in_file := pos_in_file + 1
					if platform_is_windows then
						pos_in_file := pos_in_file + 1
					end
					token := line.first_token
				else
					token := Void
				end
			end			
		end

feature -- Implementation

	split_string: BOOLEAN

	current_feature_name: STRING

end -- class EB_CLICK_FEATURE_TOOL
