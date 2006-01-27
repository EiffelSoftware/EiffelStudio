indexing
	description: "[
		Associated with a class, can modify certain elements of that class text.

		In order to add a feature with the wizard, call `new_feature'.
		`new_query' does the same but no procedure can be created with the wizard.

		Call `prepare_for_modification' first, which ensures that the
		text is be managed which is a precondition for the other features.

		Now check the flag `valid_syntax'. If it is `False' we cannot do
		a modification because the syntax for the class is currently invalid.

		When done modifying, call `commit_modification'.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_TEXT_MODIFIER

inherit
	ANY
		redefine
			default_create
		end

	EB_CLASS_TEXT_MANAGER
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_MANAGERS
		undefine
			default_create
		end

	FEATURE_CLAUSE_NAMES
		undefine
			default_create
		end

	SHARED_INST_CONTEXT
		undefine
			default_create
		end

	SHARED_SERVER
		undefine
			default_create
		end

create
	make_with_tool,
	make

feature {NONE} -- Initialization

	default_create is
			-- Create an CLASS_TEXT_MODIFIER.
		do
			create {ARRAYED_LIST [TUPLE [STRING, INTEGER]]} last_added_code.make (10)
			create {ARRAYED_LIST [TUPLE [STRING, INTEGER]]} last_removed_code.make (10)
		end

	make (a_class: CLASS_I) is
			--
		require
			a_class_not_void: a_class /= Void
		do
			default_create
			class_i := a_class
			reset_date
		ensure
			set: class_i = a_class
		end

	make_with_tool (a_class: CLASS_I; a_tool: like context_editor) is
			-- Make for `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_tool_not_void: a_tool /= Void
		do
			default_create
			class_i := a_class
			context_editor := a_tool
			reset_date
		ensure
			a_class_assigned: a_class = class_i
			a_tool_assigned: a_tool = context_editor
		end

feature -- Access

	last_feature_as: FEATURE_AS
			-- AST of last added feature.

	last_removed_code: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			-- List of code and positions that has been removed.


	last_added_code: ARRAYED_LIST [TUPLE[STRING, INTEGER]]
			-- List of added code and position.

	class_as: CLASS_AS
			-- Current class AST.

feature -- Status report

	valid_syntax: BOOLEAN is
			-- Was syntax valid when the class was parsed last time?
		do
			Result := class_as /= Void
		end

	is_modified: BOOLEAN
			-- Has `class_text' been modified since it was parsed last time?

	text_managed: BOOLEAN is
			-- Is `text' loaded or retrieved from editor?
		do
			Result := text /= Void
		end

	extend_from_diagram_successful: BOOLEAN
			-- Was last call to `extend_feature_from_diagram_with_wizard' successful?

	class_modified_outside_diagram: BOOLEAN

feature -- Status setting

	prepare_for_modification is
			-- Retrieve `class_text' from file or from an editor if
			-- the class is open.
			-- Callers should check `valid_syntax' afterwards to see if
			-- modification of the class is legal.
		do
			if text = Void then
				text := class_text (class_i)
					-- Ensured that there is some text in the class we are loading
					-- so that we can properly find out if we are using a Unix text
					-- file format.
				if not text.is_empty and then text.item (text.count) = '%N' then
					is_unix_file := (text.count = 1) or else (text.item (text.count - 1) /= '%R')
				else
						-- Text is messed up, we use the platform default
					is_unix_file := (create {PLATFORM_CONSTANTS}).is_unix
				end
				text.prune_all ('%R')
			end
			reparse
			last_removed_code.wipe_out
			last_added_code.wipe_out
			class_modified_outside_diagram := False
		ensure
			text_managed: text_managed
			syntax_still_valid: old valid_syntax implies valid_syntax
			modified_flag_cleared: not is_modified
			last_removed_code_empty: last_removed_code.is_empty
			last_added_code_empty: last_added_code.is_empty
		end

	commit_modification is
			-- Save `class_text' to file when not opened in an editor
			-- or display changes in editors, and reset `date'.
		require
			text_managed: text_managed
		do
			set_class_text (class_i, text)
			reset_date
			text := Void
			class_as := Void
		ensure
			text_unreferenced: not text_managed
		end

	reset_date is
			-- A modifying session is about to begin.
			-- Update `date'.
		local
			class_file: PLAIN_TEXT_FILE
		do
			create class_file.make (class_i.file_name)
			if class_file.exists then
				date := class_file.date
			end
		end

feature -- Element change

	insert_code (a_text: STRING) is
			-- Insert in `class_text' on `insertion_position', `a_text'.
		require
			text_managed: text_managed
		do
			last_added_code.extend ([a_text, insertion_position])
			text.insert_string (a_text, insertion_position)
			insertion_position := insertion_position + a_text.count
			is_modified := True
		ensure
			is_modified: is_modified
		end

	remove_code (start_pos, end_pos: INTEGER) is
			-- Remove code between `start_pos' and `end_pos'.
		require
			start_pos_smaller_than_end_pos: start_pos <= end_pos
			text_managed: text_managed
		do
			last_removed_code.put_front ([text.substring (start_pos, end_pos), start_pos])
			text.replace_substring ("", start_pos, end_pos)
			is_modified := True
		ensure
			is_modified: is_modified
		end

	replace_code (new_code: STRING; start_pos, end_pos: INTEGER) is
			-- Replace code between `start_pos' and `end_pos' with `new_code'.
		require
			start_pos_smaller_than_end_pos: start_pos <= end_pos
			text_managed: text_managed
			new_code_not_void: new_code /= Void
		do
			text.replace_substring (new_code, start_pos, end_pos)
			is_modified := True
		ensure
			is_modified: is_modified
		end

	code (start_pos, end_pos: INTEGER): STRING is
			-- Code between `start_pos' and `end_pos'.
		require
			start_pos_smaller_than_end_pos: start_pos <= end_pos
			text_managed: text_managed
		do
			Result := text.substring (start_pos, end_pos)
		end

	index_of (c: CHARACTER; start: INTEGER): INTEGER is
			-- Position of first occurrence of `c' at or after `start';
			-- 0 if none.
		require
			start_large_enough: start >= 1
		do
			if start <= text.count + 1 then
				Result := text.index_of (c, start)
			end
		end

feature -- Modification (Add/Remove feature)

	new_feature is
			-- Complete steps for adding a feature to a class.
			-- If class text is ready for code generation (no
			-- syntax errors), pops up the Feature Composition Wizard (FCW)
			-- If user clicks OK and entered data is correct,
			-- generates the feature.
			-- Sets `last_feature_as' if everything was successful.
		do

			last_feature_as := Void
			prepare_for_modification
			if valid_syntax then
				execute_wizard (create {EB_FEATURE_COMPOSITION_WIZARD}.make)
			else
				create warning_dialog.make_with_text (Warning_messages.w_Class_syntax_error)
				warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
			end
		end

	remove_ancestor (a_name: STRING) is
			-- Remove `a_name' from the parent list of `class_as'.
		require
			a_name_not_void: a_name /= Void
		local
			p: PARENT_AS
			class_file: PLAIN_TEXT_FILE
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end
			prepare_for_modification
			if valid_syntax then
				p := class_as.parent_with_name (a_name)
				if p /= Void then
					remove_code (p.start_position, p.end_position)
					reparse
					if valid_syntax then
						if class_as.parents = Void or else class_as.parents.is_empty then
							remove_code (
								position_before_inherit,
								class_as.inherit_clause_insert_position - 1)
							reparse
						end
					end
					if valid_syntax then
						commit_modification
					end
				end
			end
		end

	add_ancestor (a_name: STRING) is
			-- Reinclude `code' to inheritance clause.
		require
			a_name /= Void
		local
			class_file: PLAIN_TEXT_FILE
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end
			prepare_for_modification
			if valid_syntax then
				insertion_position := class_as.inherit_clause_insert_position
				if class_as.parents = Void then
					insert_code ("inherit%N")
				end
				insert_code ("%T" + a_name + "%N%N")
				commit_modification
			end
		end

	remove_features (data: LIST [FEATURE_AS]) is
			-- Remove features in `data', store removed.
		require
			data_not_void: data /= Void
		local
			class_file: PLAIN_TEXT_FILE
			actual_feature_as: FEATURE_AS
			l_item: FEATURE_AS
			feat_code: STRING
			f_name: FEATURE_NAME
			names: EIFFEL_LIST [FEATURE_NAME]
			name_index, name_start_position, name_end_position, tmp: INTEGER
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end
			prepare_for_modification
			if valid_syntax then
				from
					data.start
				until
					data.after
				loop
					l_item := data.item
					actual_feature_as := class_as.feature_with_name (l_item.feature_name)
					if actual_feature_as /= Void then
						if actual_feature_as.feature_names.count = 1 then
							feat_code := code (actual_feature_as.start_position, actual_feature_as.end_position)

								--| FIXME We assume here that features are indented in a standard way.
							if feat_code.item (feat_code.count) = '%T' then
								feat_code.remove (feat_code.count)
							end
							remove_feature_with_ast (actual_feature_as)
						else
							feat_code := code (actual_feature_as.start_position, actual_feature_as.end_position)
							f_name := Void
							names := actual_feature_as.feature_names
							name_index := 1
							from
								names.start
							until
								f_name /= Void or else names.after
							loop
								if names.item.internal_name.is_equal (l_item.feature_name) then
									f_name := names.item
								else
									name_index := name_index + 1
									names.forth
								end
							end

							check f_name /= Void end
							if name_index = names.count then
									-- `f_name' is last.
								name_start_position := actual_feature_as.start_position +
									feat_code.last_index_of (',', feat_code.count) - 1
								name_end_position := actual_feature_as.start_position +
									feat_code.index_of (':', 1) - 1
								feat_code := code (name_start_position, name_end_position - 1)
								remove_code (name_start_position, name_end_position - 1)
								reparse
							else
								tmp := feat_code.substring_index (l_item.feature_name, 1)
								name_start_position := actual_feature_as.start_position + tmp
								name_end_position := actual_feature_as.start_position +
									feat_code.index_of (',', tmp) + 1
								feat_code := code (name_start_position, name_end_position)
								remove_code (name_start_position, name_end_position)
								reparse
							end
						end
					end
					data.forth
				end
				commit_modification
			end
		end

	undelete_code (data: LIST [TUPLE [STRING, INTEGER]]) is
			-- Reinclude code in `data'.
		require
			data_not_void: data /= Void
		local
			class_file: PLAIN_TEXT_FILE
			l_item: TUPLE [STRING, INTEGER]
			str: STRING
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end
			prepare_for_modification
			if valid_syntax then
				from
					data.start
				until
					data.after
				loop
					l_item := data.item
					str ?= l_item.item (1)
					insertion_position := l_item.integer_item (2)
					check
						insertion_position <= text.count
					end
					insert_code (str)
					data.forth
				end
				commit_modification
			end
		end

	delete_code (data: LIST [TUPLE [STRING, INTEGER]]) is
			--
		local
			class_file: PLAIN_TEXT_FILE
			l_item: TUPLE [STRING, INTEGER]
			str: STRING
			pos: INTEGER
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end
			prepare_for_modification
			if valid_syntax then
				from
					data.finish
				until
					data.before
				loop
					l_item := data.item
					str ?= l_item.item (1)
					pos := l_item.integer_item (2)
					check
						text.has_substring (str)
					end
					check
						text.substring_index (str, 1) = pos
					end
					check
						text.substring (pos, pos + str.count - 1).is_equal (str)
					end
					remove_code (pos, pos + str.count - 1)
					data.back
				end
				commit_modification
			end
		end

	new_query_from_diagram (preset_type: STRING; x_pos, y_pos, screen_w, screen_h: INTEGER) is
			-- Complete steps for adding a supplier of `preset_type'.
		require
			preset_type_not_void: preset_type /= Void
		local
			qcw: EB_QUERY_COMPOSITION_WIZARD
			x, y: INTEGER
		do
			context_editor.development_window.window.set_pointer_style (context_editor.default_pixmaps.Wait_cursor)
			last_feature_as := Void
			prepare_for_modification
			if valid_syntax then
				create qcw.make
				qcw.set_type (preset_type)
				qcw.set_name_number (context_editor.graph.next_feature_name_number)
				if x_pos + qcw.width > screen_w then
					x := screen_w - qcw.width - 150
				else
					x := x_pos - 150
				end
				if y_pos + qcw.height > screen_h then
					y := screen_h - qcw.height - 180
				else
					y := y_pos - 150
				end
				qcw.set_position (x, y)
				context_editor.development_window.window.set_pointer_style (context_editor.default_pixmaps.Standard_cursor)
				execute_wizard_from_diagram (qcw)
			else
				create warning_dialog.make_with_text (
					Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
				warning_dialog.show_modal_to_window (context_editor.development_window.window)
				warning_dialog := Void
				extend_from_diagram_successful := False
				invalidate_text
				context_editor.development_window.window.set_pointer_style (context_editor.default_pixmaps.Standard_cursor)
			end
		end

	new_aggregate_query_from_diagram (preset_type: STRING; x_pos, y_pos, screen_w, screen_h: INTEGER) is
			-- Complete steps for adding a supplier of `preset_type'.
		require
			preset_type_not_void: preset_type /= Void
		local
			qcw: EB_QUERY_COMPOSITION_WIZARD
			x, y: INTEGER
		do
			context_editor.development_window.window.set_pointer_style (context_editor.Default_pixmaps.Wait_cursor)
			last_feature_as := Void
			prepare_for_modification
			if valid_syntax then
				create qcw.make
				qcw.set_type (preset_type)
				qcw.set_name_number (context_editor.graph.next_feature_name_number)
				qcw.enable_expanded_needed
				if x_pos + qcw.width > screen_w then
					x := screen_w - qcw.width - 150
				else
					x := x_pos - 150
				end
				if y_pos + qcw.height > screen_h then
					y := screen_h - qcw.height - 180
				else
					y := y_pos - 150
				end
				qcw.set_position (x, y)
				context_editor.development_window.window.set_pointer_style (context_editor.Default_pixmaps.Standard_cursor)
				execute_wizard_from_diagram (qcw)
			else
				create warning_dialog.make_with_text (
					Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
				warning_dialog.show_modal_to_window (context_editor.development_window.window)
				warning_dialog := Void
				extend_from_diagram_successful := False
				invalidate_text
				context_editor.development_window.window.set_pointer_style (context_editor.Default_pixmaps.Standard_cursor)
			end
		end

	extend_feature_with_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD) is
			-- Add feature described in `fcw' to the class.
		require
			wizard_not_void: fcw /= Void
		local
			inv: STRING
			retried: BOOLEAN
		do
			if not retried then
				prepare_for_modification
				if valid_syntax then
					if fcw.generate_setter_procedure then
						set_position_by_feature_clause ("", fc_Element_change)
						insert_code (setter_procedure (
							fcw.feature_name,
							fcw.feature_type,
							fcw.precondition
							))
						reparse
					end
					if valid_syntax then
						inv := fcw.invariant_part
						if inv /= Void then
							extend_invariant (inv)
							reparse
						end
						set_position_by_feature_clause (fcw.clause_export, fcw.clause_comment)
						insert_code (fcw.code)
						if valid_syntax then
							commit_modification
						else
							create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
							warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
							warning_dialog := Void
							invalidate_text
						end
					else
						create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
						warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
						warning_dialog := Void
						invalidate_text
					end
				else
					create warning_dialog.make_with_text (
						Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
					warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
					warning_dialog := Void
					invalidate_text
				end
			end
		end


--	extend_ancestor (a_name: STRING; ihf: BON_INHERITANCE_FIGURE) is
--			-- Add `a_name' to parent list of the class
--			-- with respect to `ihf' if is is not Void.
--		require
--			a_name_not_void: a_name /= Void
--			text_managed: text_managed
--			valid_syntax: valid_syntax
--			not_modified: not is_modified
--		do
----			insertion_position := class_as.inherit_clause_insert_position + 1
----			if class_as.parents = Void then
----				insert_code ("inherit%N")
----			end
----			if ihf /= Void and then ihf.code /= Void then
----				insert_code (ihf.code)
----			else
----				insert_code ("%T" + a_name + "%N%N")
----			end
----			reparse
--		end
--

--	remove_feature_from_diagram_with_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD; supplier_data: CASE_SUPPLIER) is
--			-- Remove feature described in `fcw' from the class.
--		require
--			wizard_not_void: fcw /= Void
--		local
--			class_file: PLAIN_TEXT_FILE
--			editor: EB_SMART_EDITOR
--		do
----			editor := diagram.context_editor.development_window.editor_tool.text_area
----			if not editor.is_empty then
----					-- Wait for the editor to read class text.
----				from
----					process_events_and_idle
----				until
----					editor.text_is_fully_loaded
----				loop
----				end
----			end
----
----			create class_file.make (class_i.file_name)
----			check class_file.exists end
----			if date = class_file.date then
----				prepare_for_modification
----				if valid_syntax then
----					if fcw.invariant_part /= Void then
----						remove_code (
----							supplier_data.invariant_insertion_position,
----							class_as.invariant_insertion_position - 1)
----						reparse
----					end
----					if fcw.generate_setter_procedure then
----						remove_feature ("set_" + fcw.feature_name)
----					end
----					remove_feature (fcw.feature_name)
----					commit_modification
----					supplier_data.remove
----				end
----			else
----				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
----				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
----				warning_dialog := Void
----				diagram.context_editor.reset_history
----				date := class_file.date
----			end
--		end
--
--	extend_features_with_data (data: LINKED_LIST [CASE_SUPPLIER]) is
--			-- Extend features associated to `data' items.
--		require
--			data_not_void: data /= Void
--		local
--			class_file: PLAIN_TEXT_FILE
--			cs: CASE_SUPPLIER
--			saved_code: STRING
--		do
----			create class_file.make (class_i.file_name)
----			check class_file.exists end
----			if date = class_file.date then
----				prepare_for_modification
----				if valid_syntax then
----					from
----						data.start
----					until
----						data.after
----					loop
----						cs := data.item
----						if cs.feature_code /= Void then
----							insertion_position := cs.insertion_position
----							saved_code := cs.feature_code
----							insert_code (saved_code)
----							cs.restore
----						end
----						data.forth
----					end
----					commit_modification
----				end
----			else
----				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
----				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
----				warning_dialog := Void
----				diagram.context_editor.reset_history
----				date := class_file.date
----			end
--		end
--
--	remove_feature (a_name: STRING) is
--			-- Remove `a_name' from the class.
--		require
--			a_name_not_void: a_name /= Void
--			text_managed: text_managed
--			valid_syntax: valid_syntax
--			not_modified: not is_modified
--		local
--			old_comment: STRING
--			f: FEATURE_AS
--			clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
--			old_f_clause, f_clause: FEATURE_CLAUSE_AS
--		do
--			f := class_as.feature_with_name (a_name.as_lower)
--			clauses := class_as.features
--			from
--				clauses.start
--			until
--				old_f_clause /= Void or else clauses.after
--			loop
--				if clauses.item.has_feature (f) then	
--					old_f_clause := clauses.item
--				end
--				clauses.forth
--			end
--			old_comment := old_f_clause.comment (text)
--			
--				--| FIXME: Why is `clients' set to Void when feature clause is empty?
--			old_f_clause.set_clients (Void)
--				
--			remove_feature_with_ast (f)
--			clauses := class_as.features
--			from
--				clauses.start
--			until
--				f_clause /= Void or else clauses.after
--			loop
--				if clauses.item.has_same_clients (old_f_clause) and
--					clauses.item.comment (text).is_equal (old_comment) then	
--						f_clause := clauses.item
--				end
--				clauses.forth
--			end
--			
--				--| The following check should not be needed (see previous FIXME).
--			if f_clause /= Void then
--				if f_clause.features.is_empty then
--					remove_code (
--						f_clause.end_position - 7,
--						text.substring_index ("%N", f_clause.end_position) + 1)
--					reparse
--				end
--			end
--		end
--
--	set_formal_generics (a_formal_list: STRING) is
--			-- Set formal generics of class to `a_formal_list'.
--		require
--			a_formal_list_not_void: a_formal_list /= Void
--			text_managed: text_managed
--			valid_syntax: valid_syntax
--			not_modified: not is_modified
--		do
--			remove_formal_generics
--			insertion_position := class_as.generics_start_position
--			insert_code (a_formal_list)
--		end
--
--	remove_formal_generics is
--			-- Remove all formal generics for this class.
--		require
--			text_managed: text_managed
--			valid_syntax: valid_syntax
--			not_modified: not is_modified
--		do
--			if class_as.generics_end_position > 0 then
--				remove_code (class_as.generics_start_position + 1, class_as.generics_end_position + 1)
--			end
--		end

feature -- Modification (Change class name)

	set_class_name_declaration (a_name, a_generics: STRING) is
			-- Set `a_name' `a_generics' as new class header.
		require
			a_name_not_void: a_name /= Void
			a_generics_not_void: a_generics /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		local
			click_ast: CLICK_AST
			sp, ep: INTEGER
		do
			click_ast := class_as.click_ast
			sp := click_ast.start_position
			if class_as.generics_end_position > 0 then
				ep := class_as.generics_end_position
			else
				ep := click_ast.end_position
			end

			remove_code (sp, ep)
			insertion_position := sp
			insert_code (a_name)
			if not a_generics.is_empty then
				insert_code (" " + a_generics)
			end
		end

	set_end_mark (a_name: STRING) is
			-- Set `a_name' as X in "end -- class X".
		require
			a_name_not_void: a_name /= Void
			text_managed: text_managed
		local
			i, j: INTEGER
			end_mark: STRING
		do
			end_mark := "end -- class "
			i := text.substring_index (end_mark, 1)
			if i > 0 then
				j := text.index_of ('%N', i)
				if j = 0 then
					j := text.count
				else
					j := j - 1
				end
				remove_code (i, j)
				insertion_position := i
				insert_code (end_mark + a_name)
				is_modified := True
			end
		end


feature {NONE} -- Implementation

	text: STRING
			-- Current class text.

	is_unix_file: BOOLEAN
			-- is current file a unix file ?
			-- (i.e. is "%N" line separator ?)	

	insertion_position: INTEGER
			-- Current place to insert code at.

	reparse is
			-- Parse `class_text' and assign AST to `class_as'.
		require
			text_managed: text_managed
		local
			retried: BOOLEAN
		do
			if not retried then
					--| FIXME set `current_class' in `system'.
				if class_i.compiled then
					class_i.system.set_current_class (class_i.compiled_class)
				end
				inst_context.set_cluster (class_i.cluster)
				Eiffel_parser.parse_from_string (text)
				class_as := Eiffel_parser.root_node
				is_modified := False
			else
				class_as := Void
			end
		rescue
			retried := True
			Error_handler.error_list.wipe_out
			retry
		end

	remove_feature_with_ast (f: FEATURE_AS) is
			-- Remove `f' from the class.
		require
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		do
			if f /= Void then
				remove_code (f.start_position, f.end_position)
				reparse
			end
		end

	execute_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD) is
			-- Show `fcw' and generate code if requested.
		require
			valid_syntax: valid_syntax
			unmodified: not is_modified
		do
			fcw.show_modal_to_window (Window_manager.last_focused_development_window.window)
			if fcw.ok_clicked then
				extend_feature_with_wizard (fcw)
			end
		end

	set_last_feature_as (a_name: STRING) is
			-- Assign `last_feature_as'.
		do
			last_feature_as := Void
			reparse
			if class_as /= Void then
				last_feature_as := class_as.feature_with_name (a_name)
			end
		end

	setter_procedure (a_attribute, a_type, a_pc: STRING): STRING is
			-- Add in "Element change" for `a_attribute'.
			-- If `a_pc' not Void, add as precondition.
		require
			a_attribute_not_void: a_attribute /= Void
			a_type_not_void: a_type /= Void
		local
			s: STRING
			first_character: CHARACTER
			preposition: STRING
		do
			create s.make (60)
			first_character := a_attribute.item (1)
			if first_character = 'a' or first_character = 'e' or first_character = 'i' or
				first_character = 'o' or first_character = 'u' then

				preposition := "an_"
			else
				preposition := "a_"
			end
			s.append ("%Tset_" + a_attribute + " (" + preposition + a_attribute + ": like " + a_attribute + ") is%N")
			s.append ("%T%T%T-- Set `" + a_attribute + "' to `" + preposition + a_attribute + "'.%N")
			if a_pc /= Void then
				s.append ("%T%Trequire%N")
				s.append ("%T%T%T" + a_pc + "%N")
			end
			s.append ("%T%Tdo%N")
			s.append ("%T%T%T" + a_attribute + " := " + preposition + a_attribute + "%N")
			s.append ("%T%Tensure%N")
			s.append ("%T%T%T" + a_attribute + "_assigned: " + a_attribute + " = " + preposition + a_attribute + "%N")
			s.append ("%T%Tend%N")
			s.append ("%N")
			Result := s
		end

	feature_insert_position (f: FEATURE_CLAUSE_AS): INTEGER is
			-- Insertion position for `f'.
		do
			Result := f.feature_keyword.final_position
			Result := index_of ('%N', Result) + 1
			Result := index_of ('%N', Result) + 1
		end

	set_position_by_feature_clause (a_export, a_comment: STRING) is
			-- Go to `insertion_position' at feature clause with `a_export' and `a_comment'.
			-- If it does not exist, add it to the class in the right place.
			-- `a_comment' will be compared case sensitive.
		require
			a_export_not_void: a_export /= Void
			a_comment_not_void: a_comment /= Void
			a_comment_clean: not a_comment.has ('%R')
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		local
			l: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			exp, s, c: STRING
			lcs: like leading_clauses
			l_match_list: LEAF_AS_LIST
			l_comments: EIFFEL_COMMENTS
		do
			l_match_list := match_list_server.item (class_as.class_id)
			exp := a_export.as_lower
			insertion_position := 0

				-- Check if specified clause is present.
			l := class_as.features
			if l /= Void then
				from l.start until insertion_position > 0 or else l.after loop
					if l.item.clients /= Void then
						s := l.item.clients.dump
					else
						s := ""
					end
--					c := l.item.comment (text)
					l_comments := l.item.comment (l_match_list)
					if l_comments = Void or else l_comments.is_empty then
						c := " "
					else
						c := l_comments.first
					end
					c.prune_all_trailing ('%R')
					if s.is_equal (exp) and c.is_equal (a_comment) then
						insertion_position := feature_insert_position (l.item)
					end
					l.forth
				end
			end

				-- If no insert position set, feature clause is not
				-- present. Find position based on feature clause order.
			if insertion_position = 0 then
				lcs := leading_clauses (a_comment)

				l := class_as.features
				if l /= Void then
					from
						l.start
					until
						insertion_position > 0 or else l.after
					loop
--						c := l.item.comment (text)
						l_comments := l.item.comment (l_match_list)
						if l_comments = Void or else l_comments.is_empty then
							c := " "
						else
							c := l_comments.first
						end
						c.prune_all_trailing ('%R')
						if not lcs.has (c) then
							insertion_position := l.item.feature_keyword.position
						end
						l.forth
					end
				end
				if insertion_position = 0 then
					insertion_position := class_as.feature_clause_insert_position
				end

				insert_feature_clause (a_export, a_comment)
			end
		end

	insert_feature_clause (a_export, a_comment: STRING) is
			-- Insert in `insertion_position' a new empty feature clause with
			-- `a_export' and `a_comment'.
		require
			a_export_not_void: a_export /= Void
			a_comment_not_void: a_comment /= Void
			text_managed: text_managed
		local
			s, up: STRING
		do
			create s.make (20)
			s.append ("feature")
			if not a_export.is_empty then
				s.append (" {")
				up := a_export.as_upper
				s.append (up)
				s.extend ('}')
			end
			if not a_comment.is_empty then
				s.append (" -- ")
				s.append (a_comment)
			end
			s.append ("%N%N")
			insert_code (s)
		end

--	trailing_clauses (a_clause: STRING): ARRAYED_LIST [STRING] is
--			-- Subset of `feature_clause_order' that should appear after `c' in the class text.
--		require
--			a_clause_not_void: a_clause /= Void
--		do
--			create Result.make (20)
--			Result.fill (feature_clause_order)
--			Result.compare_objects
--			if not Result.is_empty then
--				Result.start
--				Result.search (a_clause)
--				if Result.exhausted then
--					Result.start
--					Result.search (fc_Other)
--					if Result.exhausted then
--						Result.wipe_out
--					end
--				end
--				from
--				until
--					Result.off
--				loop
--					Result.remove
--					Result.back
--				end
--				Result.prune_all (fc_Other)
--			end
--		end

	leading_clauses (a_clause: STRING): ARRAYED_LIST [STRING] is
			-- Subset of `feature_clause_order' that should appear before `c' in the class text.
		require
			a_clause_not_void: a_clause /= Void
		do
			create Result.make (20)
			Result.fill (preferences.flat_short_data.feature_clause_order)
			Result.compare_objects
			if not Result.is_empty then
				Result.start
				Result.search (a_clause)
				if Result.exhausted then
					Result.start
					Result.search (fc_Other)
					if Result.exhausted then
						Result.wipe_out
					end
				end
				from
				until
					Result.off
				loop
					Result.remove
				end
				Result.prune_all (fc_Other)
			end
		end

	position_before_inherit: INTEGER is
			-- Position in `text' before inherit keyword.
		local
			i: INTEGER
		do
			from
				i := class_as.inherit_clause_insert_position
			until
				i <= 0 or Result > 0
			loop
				i := i - 1
				Result := text.substring_index ("inherit", i)
			end
		end

	class_i: CLASS_I
			-- Subject for modification.

	date: INTEGER
			-- Date of last modification on `class_i' by `Current'.

	context_editor: EB_CONTEXT_EDITOR
			--

	warning_dialog: EV_WARNING_DIALOG
			-- Window that warns user of incorrect syntax or file modification.

	invalidate_text is
			-- Errors were found during last parsing.
			-- Class text will have to be reloaded.
		do
			text := Void
		end


	execute_wizard_from_diagram (fcw: EB_FEATURE_COMPOSITION_WIZARD) is
			-- Show `fcw' and generate code if requested.
			-- Add any graphical items.
		require
			valid_syntax: valid_syntax
			unmodified: not is_modified
		do
			fcw.show_modal_to_window (context_editor.development_window.window)
			if fcw.ok_clicked then
				extend_from_diagram_successful := True
				extend_feature_on_diagram_with_wizard (fcw)
			else
				extend_from_diagram_successful := False
			end
		end

	extend_feature_on_diagram_with_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD) is --; supplier_data: CASE_SUPPLIER) is
			-- Add feature described in `fcw' to the class.
		require
			wizard_not_void: fcw /= Void
		local
			class_file: PLAIN_TEXT_FILE
			inv: STRING
			editor: EB_SMART_EDITOR
			new_code: STRING
		do
			editor := context_editor.development_window.editor_tool.text_area
			if not editor.is_empty then
					-- Wait for the editor to read class text.
				from
					process_events_and_idle
				until
					editor.text_is_fully_loaded
				loop
				end
			end

			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date /= date then
				put_class_modified_outside_diagram_warning
				date := class_file.date
				class_modified_outside_diagram := True
			end

			prepare_for_modification
			if valid_syntax then
				if fcw.generate_setter_procedure then
					set_position_by_feature_clause ("", fc_Element_change)
					new_code := setter_procedure (
						fcw.feature_name,
						fcw.feature_type,
						fcw.precondition
						)
					insert_code (new_code)
					reparse
				end
				if valid_syntax then
					set_position_by_feature_clause (fcw.clause_export, fcw.clause_comment)
					new_code := fcw.code
					insert_code (new_code)
					set_last_feature_as (fcw.feature_name)
					if valid_syntax then
						inv := fcw.invariant_part
						if inv /= Void then
							extend_invariant (inv)
							reparse
						end
						if valid_syntax then
							commit_modification
						else
							create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
							warning_dialog.show_modal_to_window (context_editor.development_window.window)
							warning_dialog := Void
							extend_from_diagram_successful := False
							invalidate_text
						end
					else
						create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
						warning_dialog.show_modal_to_window (context_editor.development_window.window)
						warning_dialog := Void
						extend_from_diagram_successful := False
						invalidate_text
					end
				else
					create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
					warning_dialog.show_modal_to_window (context_editor.development_window.window)
					warning_dialog := Void
					extend_from_diagram_successful := False
					invalidate_text
				end
			else
				create warning_dialog.make_with_text (
					Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
				warning_dialog.show_modal_to_window (context_editor.development_window.window)
				warning_dialog := Void
				extend_from_diagram_successful := False
				invalidate_text
			end
		end

	extend_invariant (a_inv: STRING) is
			-- Add `a_inv' to end of invariant.
		require
			a_inv_not_void: a_inv /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		do
			insertion_position := class_as.invariant_insertion_position
			if class_as.invariant_part = Void and not class_as.has_empty_invariant then
				insert_code ("invariant%N%T")
				insert_code (a_inv)
				insert_code ("%N%N")
			else
				insert_code ("%N%T")
				insert_code (a_inv)
			end
		end

	put_class_modified_outside_diagram_warning is
			-- Inform user, that class was modified outside diagram.
		local
			l_text: STRUCTURED_TEXT
		do
			if not context_editor.history.is_empty then
				create l_text.make
				l_text.add_multiline_string (warning_messages.w_class_modified_outside_diagram, 0)
				l_text.add_new_line
				output_manager.process_text (l_text)
				context_editor.reset_history
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLASS_TEXT_MODIFIER
