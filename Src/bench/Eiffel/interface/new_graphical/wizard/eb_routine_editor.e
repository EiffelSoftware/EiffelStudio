indexing
	description: "Component to let the user create routines."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_ROUTINE_EDITOR

inherit
	EB_FEATURE_EDITOR
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Create as function/procedure wizard.
		local
			vb, fake_vb: EV_VERTICAL_BOX
			name_hb, hb: EV_HORIZONTAL_BOX
			tab, tab2: EV_CELL
		do
			Precursor
			set_border_width (layout_constants.default_border_size)
			create feature_clause_selector
			extend (feature_clause_selector)
			disable_item_expand (feature_clause_selector)

			create tab
			tab.set_minimum_height (10)
			extend (tab)
			disable_item_expand (tab)

			create fake_vb
			create name_hb
			create feature_name_field.make_with_text ("new_feature")
			feature_name_field.set_minimum_width (70)
			name_hb.extend (new_tab (1))
			name_hb.disable_item_expand (name_hb.last)
			name_hb.extend (feature_name_field)
			name_hb.extend (new_label (" ("))
			name_hb.disable_item_expand (name_hb.last)
			fake_vb.extend (name_hb)
			fake_vb.disable_item_expand (name_hb)
			create tab2
			fake_vb.extend (tab2)
			fake_vb.disable_item_expand (tab2)

			create hb
			hb.extend (fake_vb)
			create vb
			hb.extend (vb)
			create argument_list
			vb.extend (argument_list)
			add_argument_button := new_create_button
			add_argument_button.select_actions.extend (~on_new_argument)
			vb.extend (routine_is_part)
			
			extend (hb)
			disable_item_expand (hb)

			add_comment_field
			add_label ("require", 2)
			create require_field
			add_indented (require_field, 3)
			add_label ("local", 2)
			create local_field
			add_indented (local_field, 3)

			build_body_type_box
			extend (body_type_box)
			disable_item_expand (body_type_box)

			create body_field
			add_indented (body_field, 3)

			add_label ("ensure", 2)
			create ensure_field
			add_indented (ensure_field, 3)
			add_label ("end", 2)
		end

	routine_is_part: EV_HORIZONTAL_BOX is
			-- Procedure: "[!!]): is"
			-- Function: "[!!]): <typefield> is"
		require
			argument_button_not_void: add_argument_button /= Void
		deferred
		ensure
			not_void: Result /= Void
			argument_button_added: Result.has (add_argument_button)
		end

	build_body_type_box is
			-- Create radio group with "do", "once" and "deferred".
		local
			tab: EV_CELL
		do
			create body_type_box
			tab := new_tab (2)
			body_type_box.extend (tab)
			body_type_box.disable_item_expand (tab)
			body_type_label := new_label ("do")
			body_type_box.extend (body_type_label)
			body_type_label.align_text_left

			create do_button.make_with_text ("do")
			body_type_box.extend (do_button)
			body_type_box.disable_item_expand (do_button)
			do_button.select_actions.extend (~on_body_change (do_button.text))

			create once_button.make_with_text ("once")
			body_type_box.extend (once_button)
			body_type_box.disable_item_expand (once_button)
			once_button.select_actions.extend (~on_body_change (once_button.text))

			create deferred_button.make_with_text ("deferred")
			body_type_box.extend (deferred_button)
			body_type_box.disable_item_expand (deferred_button)
			deferred_button.select_actions.extend (~on_body_change (deferred_button.text))

			create external_button.make_with_text ("external")
			body_type_box.extend (external_button)
			body_type_box.disable_item_expand (external_button)
			external_button.select_actions.extend (~on_body_change (external_button.text))
		end

feature -- Status report

	is_deferred: BOOLEAN is
			-- Is current selected body "deferred"?
		do
			Result := body_type_label.text.is_equal ("deferred")
		end

	is_external: BOOLEAN is
			-- Is current selected body "external"?
		do
			Result := body_type_label.text.is_equal ("external")
		end

feature -- Access

	add_argument is
			-- Add an argument to `argument_list'.
		do
			on_new_argument
		end

	i_th_argument (i: INTEGER): EB_ARGUMENT_SELECTOR is
		do
			Result ?= argument_list.i_th (i)
		end

	do_button, once_button, deferred_button, external_button: EV_RADIO_BUTTON

feature -- Element change

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		do
			name_number := a_number
			if name_number /= 0 then
				feature_name_field.set_text	("new_feature" + "_" + name_number.out)
			end
		end

feature {NONE} -- Implementation

	arguments_code: STRING is
			-- Arguments as text. Empty if no arguments.
		local
			asc: EB_ARGUMENT_SELECTOR
		do
			create Result.make (10)
			if not argument_list.is_empty then
				Result.append (" (")
				from
					argument_list.start
				until
					argument_list.after
				loop
					asc ?= argument_list.item
					check
						asc_not_void: asc /= Void
					end
					Result.append (asc.code)
					argument_list.forth
					if not argument_list.after then
						Result.append ("; ")
					end
				end
				Result.append (")")
			end
		end

	routine_code: STRING is
			-- Code of routine without signature.
		do
			Result := require_code
			if is_deferred then
				Result.append ("%T%Tdeferred%N")
			elseif is_external then
				Result.append (body_code)
			else
				Result.append (local_code)
				Result.append (body_code)
			end
			Result.append (ensure_code)
			Result.append ("%T%Tend%N%N")
		end

	require_code: STRING is
			-- Code for precondition.
		do
			Result := code_for_field (require_field, "require")
		end

	local_code: STRING is
			-- Code for local symbol declaration.
		do
			Result := code_for_field (local_field, "local")
		end

	body_code: STRING is
			-- Code for routine body.
		do
			if body_field.line_count = 0 then
				Result := "%T%T" + body_type_label.text + "%N"
			else
				Result := code_for_field (body_field, body_type_label.text)
			end
		end

	ensure_code: STRING is
			-- Code for postcondition.
		do
			Result := code_for_field (ensure_field, "ensure")
		end

	code_for_field (f: EB_FEATURE_LINE_EDIT; kw: STRING): STRING is
			-- Code for routine part `f' with keyword `kw'.
		local
			n: INTEGER
		do
			create Result.make (10)
			if f.line_count > 0 then
				Result.append ("%T%T" + kw + "%N")
				from
					n := 1
				until
					n > f.line_count
				loop
					Result.append ("%T%T%T" + f.line (n) + "%N")
					n := n + 1
				end
			end
		end

	on_new_argument is
			-- Add argument selector to `argument_list'.
		local
			asc: EB_ARGUMENT_SELECTOR
		do
			once_button.disable_sensitive
			if once_button.is_selected then
				do_button.enable_select
			end
			if not argument_list.is_empty then
				asc ?= argument_list.last
				asc.add_semicolon
			end
			create asc
			asc.set_remove_procedure (agent on_argument_removed (asc))
			argument_list.extend (asc)
			asc.set_name ("arg" + argument_list.count.out)
		end

	on_argument_removed (arg: EB_ARGUMENT_SELECTOR) is
			-- Remove `arg' from `argument_list'.
		require
			argument_exists: arg /= Void
		local
			asc: EB_ARGUMENT_SELECTOR
		do
			argument_list.prune_all (arg)
			if not argument_list.is_empty then
				asc ?= argument_list.last
				asc.remove_semicolon
			else
				once_button.enable_sensitive
			end
		ensure
			argument_removed: not argument_list.has (arg)
		end

	on_body_change (new_body: STRING) is
			-- User selected different routine body type.
		do
			if new_body.is_equal ("deferred") then
				body_field.disable
				local_field.disable
			elseif new_body.is_equal ("external") then
				body_field.enable
				local_field.disable
			else
				body_field.enable
				local_field.enable
			end
			body_type_label.set_text (new_body)
		end

feature {EB_FEATURE_EDITOR} -- Access

	add_argument_button: EV_BUTTON
	argument_list: EV_VERTICAL_BOX

	require_field: EB_FEATURE_LINE_EDIT
	local_field: EB_FEATURE_LINE_EDIT
	body_type_label: EV_LABEL
	body_type_box: EV_HORIZONTAL_BOX
	body_field: EB_FEATURE_LINE_EDIT
	ensure_field: EB_FEATURE_LINE_EDIT

end -- class EB_ROUTINE_EDITOR
