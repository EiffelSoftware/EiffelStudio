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
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_TEXT_MODIFIER
 
inherit
	EB_CLASS_TEXT_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	EB_FORMATTER_DATA
		export
			{NONE} all
		end
	
		--| FIXME: only needed to cope with bug in FEATURE_CLAUSE_AS (see `remove_feature').
	COMPILER_EXPORTER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end
	
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I) is
			-- Make for `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			class_i := a_class
			reset_date
		ensure
			a_class_assigned: a_class = class_i
		end

feature -- Access

	class_i: CLASS_I
			-- Subject for modification.

	date: INTEGER
			-- Date of last modification on `class_i' by `Current'.

	last_feature_as: FEATURE_AS
			-- AST of last added feature.

	diagram: CONTEXT_DIAGRAM
			-- Diagram `class_i' associated figure belongs to.

	warning_dialog: EB_WARNING_DIALOG
			-- Window that warns user of incorrect syntax or file modification.

feature -- Element change

	set_diagram (d: CONTEXT_DIAGRAM) is
			-- Assign `d' to `diagram'.
		require 
			d_not_void: d /= Void
		do
			diagram := d
		ensure
			d_assigned: diagram = d
		end

feature {INHERITANCE_FIGURE} -- Element change

	set_date (i: INTEGER) is
			-- Assign `i' to `date'.
		require
			i_non_negative: i >= 0
		do
			date := i
		ensure
			i_assigned: date = i
		end
		
	invalidate_text is
			-- Errors were found during last parsing. 
			-- Class text will have to be reloaded.
		do
			text := Void
		end
		
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

feature -- Status setting

	prepare_for_modification is
			-- Retrieve `class_text' from file or from an editor if
			-- the class is open.
			-- Callers should check `valid_syntax' afterwards to see if
			-- modification of the class is legal.
		do
			if text = Void then
				text := class_text (class_i)
			end
			is_unix_file := text.substring_index ("%R%N", 1) = 0
			reparse
		ensure
			text_managed: text_managed
			syntax_still_valid: old valid_syntax implies valid_syntax
			modified_flag_cleared: not is_modified
		end

	commit_modification is
			-- Save `class_text' to file when not opened in an editor
			-- or display changes in editors.
		require
			text_managed: text_managed
		do
			set_class_text (class_i, text)
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

feature -- Modification

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
				execute_wizard (create {EB_FEATURE_COMPOSITION_WIZARD})
			end
		end

	new_aggregate_query_from_diagram (preset_type: STRING; x_pos, y_pos, screen_w, screen_h: INTEGER) is
			-- Complete steps for adding a supplier of `preset_type'.
		require
			preset_type_not_void: preset_type /= Void
			diagram_set: diagram /= Void 
		local
			qcw: EB_QUERY_COMPOSITION_WIZARD
			x, y: INTEGER
		do
			diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Wait_cursor)
			last_feature_as := Void
			prepare_for_modification
			if valid_syntax then
				create qcw
				qcw.set_type (preset_type)
				qcw.set_name_number (diagram.next_feature_name_number)
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
				diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Standard_cursor)
				execute_wizard_from_diagram (qcw)
			else
				create warning_dialog.make_with_text (
					Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
				warning_dialog := Void
				extend_from_diagram_successful := False
				text := Void
				diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Standard_cursor)
			end
		end

	new_query_from_diagram (preset_type: STRING; x_pos, y_pos, screen_w, screen_h: INTEGER) is
			-- Complete steps for adding a supplier of `preset_type'.
		require
			preset_type_not_void: preset_type /= Void
			diagram_set: diagram /= Void 
		local
			qcw: EB_QUERY_COMPOSITION_WIZARD
			x, y: INTEGER
		do
			diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Wait_cursor)
			last_feature_as := Void
			prepare_for_modification
			if valid_syntax then
				create qcw
				qcw.set_type (preset_type)
				qcw.set_name_number (diagram.next_feature_name_number)
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
				diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Standard_cursor)
				execute_wizard_from_diagram (qcw)
			else
				create warning_dialog.make_with_text (
					Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
				warning_dialog := Void
				extend_from_diagram_successful := False
				text := Void
				diagram.context_editor.development_window.window.set_pointer_style (diagram.Default_pixmaps.Standard_cursor)
			end
		end

	extend_ancestor (a_name: STRING; ihf: INHERITANCE_FIGURE) is
			-- Add `a_name' to parent list of the class
			-- with respect to `ihf' if is is not Void.
		require
			a_name_not_void: a_name /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		do
			insertion_position := class_as.inherit_clause_insert_position + 1
			if class_as.parents = Void then
				insert_code ("inherit%N")
			end
			if ihf /= Void and then ihf.code /= Void then
				insert_code (ihf.code)
			else
				insert_code ("%T" + a_name + "%N%N")
			end
			reparse
		end

	remove_ancestor (a_name: STRING; ihf: INHERITANCE_FIGURE) is
			-- Remove `a_name' from the parent list of `class_as'
			-- with respect to `ihf' if is is not Void.
		require
			a_name_not_void: a_name /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		local
			n: STRING
			p: PARENT_AS
			pl: EIFFEL_LIST [PARENT_AS]
			ip: INTEGER
		do
			n := clone (a_name)
			n.to_lower
			p := class_as.parent_with_name (n)
			if p /= Void then
				pl := class_as.parents
				pl.start
				pl.search (p)
				if pl.islast then
					ip := class_as.inherit_clause_insert_position
				else
					pl.forth
					ip := pl.item.start_position - 1
				end
				if ihf /= Void then
					ihf.set_code (code (p.start_position, ip))
				end
				if (position_before_inherit + 7) = p.start_position then
					remove_code (p.start_position + 1, ip)
				else
					remove_code (p.start_position, ip)
				end			
				reparse
			end
			if valid_syntax then
				if class_as.parents /= Void and then class_as.parents.is_empty then
					remove_code (
						position_before_inherit,
						class_as.inherit_clause_insert_position)
					reparse
				end
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
							extend_invariant ("%T" + inv + "%N")
							reparse
						end
						set_position_by_feature_clause (fcw.clause_export, fcw.clause_comment)
						insert_code (fcw.code)
						if valid_syntax then
							set_class_text (class_i, text)
							text := Void
							class_as := Void
						else
							create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
							warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
							warning_dialog := Void
							text := Void
						end
					else
						create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
						warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
						warning_dialog := Void
						text := Void
					end
				else
					create warning_dialog.make_with_text (
						Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
					warning_dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
					warning_dialog := Void
					text := Void
				end					
			end
		end

	extend_feature_on_diagram_with_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD; supplier_data: CASE_SUPPLIER) is
			-- Add feature described in `fcw' to the class.
		require
			wizard_not_void: fcw /= Void
		local
			class_file: PLAIN_TEXT_FILE
			inv: STRING
			cs_fig: CLIENT_SUPPLIER_FIGURE
			sl: LIST [CLASS_I]
			fig, c: CLASS_FIGURE
			editor: EB_SMART_EDITOR
		do
			editor := diagram.context_editor.development_window.editor_tool.text_area
			if not editor.is_empty then
					-- Wait for the editor to read class text.
				from
					ev_application.process_events
				until
					editor.text_is_fully_loaded
				loop
				end
			end
				
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if class_file.date = date then
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
						set_position_by_feature_clause (fcw.clause_export, fcw.clause_comment)
						insert_code (fcw.code)
						set_last_feature_as (fcw.feature_name)
						if valid_syntax then
							supplier_data.set_invariant_insertion_position (
								class_as.invariant_insertion_position)
							inv := fcw.invariant_part
							if inv /= Void then
								extend_invariant ("%T" + inv + "%N")
								reparse
							end	
							if valid_syntax then
								set_class_text (class_i, text)
								text := Void
								class_as := Void
								create class_file.make (class_i.file_name)
								check class_file.exists end
								date := class_file.date
							else
								create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
								warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
								warning_dialog := Void
								extend_from_diagram_successful := False
								text := Void
							end
						else
							create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
							warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
							warning_dialog := Void
							extend_from_diagram_successful := False
							text := Void
						end
					else
						create warning_dialog.make_with_text (Warning_messages.w_New_feature_syntax_error)
						warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
						warning_dialog := Void
						extend_from_diagram_successful := False
						text := Void
					end
				else
					create warning_dialog.make_with_text (
						Warning_messages.w_Class_syntax_error_before_generation (class_i.name_in_upper))
					warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
					warning_dialog := Void
					extend_from_diagram_successful := False
					text := Void
				end
				if last_feature_as /= Void and extend_from_diagram_successful then	
					c ?= diagram.class_figure_by_class (class_i)
					if c /= Void then
	
							-- We do not add a supplier link to `s',
							-- because the user might have entered a different
							-- class name, or even more than one.
						if not supplier_data.initialized then
							supplier_data.set_feature_as (last_feature_as)
							supplier_data.initialize
						end
						c.queries.extend (supplier_data)
	
							-- Add all `supplier_classes' in `supp' to the diagram.
						sl := supplier_data.supplier_classes
						from
							sl.start
						until
							sl.after
						loop
							fig := diagram.class_figure_by_class (sl.item)
							if fig /= Void then
									-- `fig' is in the diagram. Add graphical link.
								cs_fig := supplier_data.graphical_link_with_supplier (fig)
								if cs_fig = Void then
										-- Graphical link does not exist. Create it.
									cs_fig := diagram.new_client_supplier_figure (c, fig, supplier_data)
								end
								diagram.add_client_supplier_figure (cs_fig)
								if cs_fig.is_reflexive then
									cs_fig.set_reflexive
								end
								cs_fig.update
							end
							sl.forth
						end
					end
					diagram.context_editor.projector.project
				end
			else
				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
				warning_dialog := Void
				diagram.context_editor.reset_history
				date := class_file.date
			end
		end

	remove_feature_from_diagram_with_wizard (fcw: EB_FEATURE_COMPOSITION_WIZARD; supplier_data: CASE_SUPPLIER) is
			-- Remove feature described in `fcw' from the class.
		require
			wizard_not_void: fcw /= Void
		local
			class_file: PLAIN_TEXT_FILE
			editor: EB_SMART_EDITOR
		do
			editor := diagram.context_editor.development_window.editor_tool.text_area
			if not editor.is_empty then
					-- Wait for the editor to read class text.
				from
					ev_application.process_events
				until
					editor.text_is_fully_loaded
				loop
				end
			end

			create class_file.make (class_i.file_name)
			check class_file.exists end
			if date = class_file.date then
				prepare_for_modification
				if valid_syntax then
					if fcw.invariant_part /= Void then
						remove_code (
							supplier_data.invariant_insertion_position,
							class_as.invariant_insertion_position - 1)
						reparse
					end
					if fcw.generate_setter_procedure then
						remove_feature ("set_" + fcw.feature_name)
					end
					remove_feature (fcw.feature_name)
					commit_modification
					create class_file.make (class_i.file_name)
					check class_file.exists end
					date := class_file.date
					supplier_data.remove
				end
			else
				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
				warning_dialog := Void
				diagram.context_editor.reset_history
				date := class_file.date
			end
		end

	extend_features_with_data (data: LINKED_LIST [CASE_SUPPLIER]) is
			-- Extend features associated to `data' items.
		require
			data_not_void: data /= Void
		local
			class_file: PLAIN_TEXT_FILE
			cs: CASE_SUPPLIER
			saved_code: STRING
		do
			create class_file.make (class_i.file_name)
			check class_file.exists end
			if date = class_file.date then
				prepare_for_modification
				if valid_syntax then
					from
						data.start
					until
						data.after
					loop
						cs := data.item
						if cs.feature_code /= Void then
							insertion_position := cs.insertion_position
							saved_code := cs.feature_code
			--				if saved_code.item (saved_code.count) = '%N' then
			--					saved_code.remove (saved_code.count)
			--				end
							insert_code (saved_code)
							cs.restore
						end
						data.forth
					end
					commit_modification
					create class_file.make (class_i.file_name)
					check class_file.exists end
					date := class_file.date
				end
			else
				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)
				warning_dialog := Void
				diagram.context_editor.reset_history
				date := class_file.date
			end
		end

	remove_features_with_data (data: LINKED_LIST [CASE_SUPPLIER]) is
			-- Remove features associated to `data' items.
		require
			data_not_void: data /= Void
		local
			class_file: PLAIN_TEXT_FILE
			actual_feature_as: FEATURE_AS
			cs: CASE_SUPPLIER
			feat_code: STRING
			f_name: FEATURE_NAME
			names: EIFFEL_LIST [FEATURE_NAME]
			name_index, name_start_position, name_end_position, tmp: INTEGER
		do

			create class_file.make (class_i.file_name)
			check class_file.exists end
			if date = class_file.date then
				prepare_for_modification
				if valid_syntax then
					from
						data.start
					until
						data.after
					loop
						cs := data.item
						actual_feature_as := class_as.feature_with_name (cs.name)
						if actual_feature_as /= Void then
							cs.set_feature_as (actual_feature_as)
							if cs.feature_as.feature_names.count = 1 then
								feat_code := code (cs.feature_as.start_position, cs.feature_as.end_position)
	
									--| FIXME We assume here that features are indented in a standard way.
								if feat_code.item (feat_code.count) = '%T' then
									feat_code.remove (feat_code.count)
								end
								cs.set_feature_code (feat_code)
								cs.set_insertion_position (cs.feature_as.start_position)
								remove_feature_with_ast (cs.feature_as)
							else
								feat_code := code (cs.feature_as.start_position, cs.feature_as.end_position)
								f_name := Void
								names := cs.feature_as.feature_names
								name_index := 1
								from
									names.start
								until
									f_name /= Void or else names.after
								loop
									if names.item.associated_feature_name.is_equal (cs.name) then
										f_name := names.item
									else
										name_index := name_index + 1
										names.forth
									end
								end

								check f_name /= Void end
								if name_index = names.count then
										-- `f_name' is last.
									name_start_position := cs.feature_as.start_position + 
										feat_code.last_index_of (',', feat_code.count) - 1
									name_end_position := cs.feature_as.start_position + 
										feat_code.index_of (':', 1) - 1
									feat_code := code (name_start_position, name_end_position - 1)
									cs.set_feature_code (feat_code)
									cs.set_insertion_position (name_start_position)
									remove_code (name_start_position, name_end_position - 1)
									reparse
								else
									tmp := feat_code.substring_index (cs.name, 1)
									name_start_position := cs.feature_as.start_position + tmp 
									name_end_position := cs.feature_as.start_position + 
										feat_code.index_of (',', tmp) + 1
									feat_code := code (name_start_position, name_end_position)
									cs.set_feature_code (feat_code)
									cs.set_insertion_position (name_start_position)
									remove_code (name_start_position, name_end_position)
									reparse
								end
							end
							cs.remove
						else
								-- The feature is not present in class text.
							cs.set_feature_code (Void)
						end
						data.forth
					end
					commit_modification
					create class_file.make (class_i.file_name)
					check class_file.exists end
					date := class_file.date
				end
			else
				create warning_dialog.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
				warning_dialog.show_modal_to_window (diagram.context_editor.development_window.window)	
				warning_dialog := Void
				diagram.context_editor.reset_history
				date := class_file.date
			end
		end

	remove_feature (a_name: STRING) is
			-- Remove `a_name' from the class.
		require
			a_name_not_void: a_name /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		local
			n, old_comment: STRING
			f: FEATURE_AS
			clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			old_f_clause, f_clause: FEATURE_CLAUSE_AS
		do
			n := clone (a_name)
			n.to_lower
			f := class_as.feature_with_name (n)
			clauses := class_as.features
			from
				clauses.start
			until
				old_f_clause /= Void or else clauses.after
			loop
				if clauses.item.has_feature (f) then	
					old_f_clause := clauses.item
				end
				clauses.forth
			end
			old_comment := old_f_clause.comment (text)
			
				--| FIXME: Why is `clients' set to Void when feature clause is empty?
			old_f_clause.set_clients (Void)
				
			remove_feature_with_ast (f)
			clauses := class_as.features
			from
				clauses.start
			until
				f_clause /= Void or else clauses.after
			loop
				if clauses.item.has_same_clients (old_f_clause) and
					clauses.item.comment (text).is_equal (old_comment) then	
						f_clause := clauses.item
				end
				clauses.forth
			end
			
				--| The following check should not be needed (see previous FIXME).
			if f_clause /= Void then
				if f_clause.features.is_empty then
					remove_code (
						f_clause.position - 7,
						text.substring_index ("%N", f_clause.position) + 1)
					reparse
				end
			end
		end

	set_formal_generics (a_formal_list: STRING) is
			-- Set formal generics of class to `a_formal_list'.
		require
			a_formal_list_not_void: a_formal_list /= Void
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		do
			remove_formal_generics
			insertion_position := class_as.generics_start_position
			insert_code (a_formal_list)
		end

	remove_formal_generics is
			-- Remove all formal generics for this class.
		require
			text_managed: text_managed
			valid_syntax: valid_syntax
			not_modified: not is_modified
		do
			if class_as.generics_end_position > 0 then
				remove_code (class_as.generics_start_position + 1, class_as.generics_end_position + 1)
			end
		end

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
			sp := click_ast.start_position + 1
			if class_as.generics_end_position > 0 then
				ep := class_as.generics_end_position + 1
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
			i: INTEGER
			end_mark: STRING
		do
			end_mark := "end -- class "
			i := text.substring_index (end_mark, 1)
			if i > 0 then
				i := i + end_mark.count
				text.replace_substring (a_name, i, i + class_i.name.count - 1)
				is_modified := True
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
				insert_code ("%Ninvariant%N")
			end
			insert_code (a_inv)
		end

feature {CLASS_NAME_REPLACER} -- Implementation

	text: STRING
			-- Current class text.
			
	is_unix_file: BOOLEAN
			-- is current file a unix file ?
			-- (i.e. is "%N" line separator ?)	

	class_as: CLASS_AS
			-- Current class AST.

	insertion_position: INTEGER
			-- Current place to insert code at.

	insert_code (a_text: STRING) is
			-- Insert in `class_text' on `insertion_position', `a_text'.
		require
			text_managed: text_managed
		do
			text.insert (a_text, insertion_position)
			insertion_position := insertion_position + a_text.count
			is_modified := True
		ensure
			is_modified: is_modified
		end

	remove_code (start_pos, end_pos: INTEGER) is
			-- Remove code between `start_pos' and `end_pos'.
		require
			start_pos_smaller_than_end_pos: start_pos < end_pos
			text_managed: text_managed
		do
			text.replace_substring ("", start_pos, end_pos)
			is_modified := True
		ensure
			is_modified: is_modified
		end

	code (start_pos, end_pos: INTEGER): STRING is
			-- Code between `start_pos' and `end_pos'.
		require
			start_pos_smaller_than_end_pos: start_pos < end_pos
			text_managed: text_managed
		do
			Result := text.substring (start_pos, end_pos)
		end

	reparse is
			-- Parse `class_text' and assign AST to `class_as'.
		require
			text_managed: text_managed
		local
			retried: BOOLEAN
		do
				--| FIXME set `current_class' in `system'.
			if class_i.compiled then
				class_i.system.set_current_class (class_i.compiled_class)
			end
			if retried then
				class_as := Void
			else
				Eiffel_parser.parse_from_string (text)
				class_as := Eiffel_parser.root_node
				is_modified := False
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
				remove_code (f.start_position, f.end_position - 1)
				reparse
			end
		end

	execute_wizard_from_diagram (fcw: EB_FEATURE_COMPOSITION_WIZARD) is
			-- Show `fcw' and generate code if requested.
			-- Add any graphical items.
		require
			valid_syntax: valid_syntax
			unmodified: not is_modified
			diagram_set: diagram /= Void
		local
			supplier_data: CASE_SUPPLIER
		do
			fcw.show_modal_to_window (diagram.context_editor.development_window.window)
			if fcw.ok_clicked then
				create supplier_data.make_default
				extend_from_diagram_successful := True
				diagram.context_editor.history.do_named_undoable(
					Interface_names.t_Diagram_add_cs_link_cmd,
					~extend_feature_on_diagram_with_wizard (fcw, supplier_data),
					~remove_feature_from_diagram_with_wizard (fcw, supplier_data))
				if not extend_from_diagram_successful then
					diagram.context_editor.history.remove_last
				else
					diagram.context_editor.on_client_link_created
				end
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
		do
			create s.make (60)
			s.append ("%Tset_" + a_attribute + " (a_" + a_attribute + ": " + a_type + ") is%N")
			s.append ("%T%T%T-- Set `" + a_attribute + "' to `a_" + a_attribute + "'.%N")
			if a_pc /= Void then
				s.append ("%T%Trequire%N")
				s.append ("%T%T%T" + a_pc + "%N")
			end
			s.append ("%T%Tdo%N")
			s.append ("%T%T%T" + a_attribute + " := a_" + a_attribute + "%N")
			s.append ("%T%Tensure%N")
			s.append ("%T%T%T" + a_attribute + "_assigned: " + a_attribute + " = a_" + a_attribute + "%N")
			s.append ("%T%Tend%N")
			s.append ("%N")
			Result := s
		end

	feature_insert_position (f: FEATURE_CLAUSE_AS): INTEGER is
			-- Insertion position for `f'.
		do
			Result := f.position
			Result := text.index_of ('%N', Result) + 1
			Result := text.index_of ('%N', Result) + 1
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
		do
			exp := clone (a_export)
			exp.to_lower
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
					c := l.item.comment (text)
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
						c := l.item.comment (text)
						c.prune_all_trailing ('%R')
						if not lcs.has (c) then
							insertion_position := text.last_index_of ('%N', l.item.position) + 1
						end
						l.forth
					end
				end
				if insertion_position = 0 then
					insertion_position := class_as.feature_clause_insert_position + 1
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
				up := clone (a_export)
				up.to_upper
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

	trailing_clauses (a_clause: STRING): ARRAYED_LIST [STRING] is
			-- Subset of `feature_clause_order' that should appear after `c' in the class text.
		require
			a_clause_not_void: a_clause /= Void
		do
			create Result.make (20)
			Result.fill (feature_clause_order)
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
					Result.back
				end
				Result.prune_all (fc_Other)
			end
		end

	leading_clauses (a_clause: STRING): ARRAYED_LIST [STRING] is
			-- Subset of `feature_clause_order' that should appear before `c' in the class text.
		require
			a_clause_not_void: a_clause /= Void
		do
			create Result.make (20)
			Result.fill (feature_clause_order)
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
		
end -- class CLASS_TEXT_MODIFIER
