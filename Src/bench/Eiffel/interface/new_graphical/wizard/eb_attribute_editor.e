indexing
	description:
		"Wizard to create attributes and insert them in a specific%N%
		%feature clause. Also provides field for invariant and option%N%
		%to automatically generate set-feature."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ATTRIBUTE_EDITOR

inherit
	EB_QUERY_EDITOR
		redefine
			initialize,
			is_attribute,
			enable_expanded_needed
		end

	EB_ASSERTION_GENERATOR
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Create as attribute wizard.
		local
			hb: EV_HORIZONTAL_BOX
			tab: EV_CELL
		do
			Precursor
--			set_padding (layout_constants.small_padding_size)
			set_border_width (layout_constants.default_border_size)
			create feature_clause_selector
			extend (feature_clause_selector)
			disable_item_expand (feature_clause_selector)

			create tab
			tab.set_minimum_height (10)
			extend (tab)
			disable_item_expand (tab)

			create hb
			hb.extend (new_tab (1))
			hb.disable_item_expand (hb.last)
			create feature_name_field.make_with_text ("new_feature")
			feature_name_field.change_actions.force_extend (~on_declaration_change)
			feature_name_field.set_minimum_width (70)
			hb.extend (feature_name_field)
			hb.extend (new_label (": "))
			hb.disable_item_expand (hb.last)
			create type_selector
			type_selector.selector.change_actions.extend (~on_declaration_change)
			hb.extend (type_selector)
			hb.extend (create {EV_CELL})
			extend (hb)
			disable_item_expand (hb)
			add_comment_field

			add_label ("invariant", 0)
			create invariant_field
			invariant_field.set_text (Pc_none)
			invariant_field.focus_in_actions.extend (~on_invariant_focus_gain)
			add_indented (invariant_field, 1)

			create procedure_check_box.make_with_text ("Generate set procedure")
--			procedure_check_box.select_actions.extend (~on_set_procedure_select)
			extend (procedure_check_box)
			disable_item_expand (procedure_check_box)

--			extend (create {EV_LABEL}.make_with_text ("Select precondition:"))
--			create precondition_selector
--			precondition_selector.focus_in_actions.extend (~on_precondition_focus_gain)
--			precondition_selector.disable_sensitive
--			extend (precondition_selector)
		end

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		do
			create Result.make (100)
			if feature_name_field.text /= Void then
				Result.append ("%T" + feature_name_field.text + ": " + type_selector.code + "%N")
			else
				Result.append ("%T" + ": " + type_selector.code + "%N")
			end	
			Result.append (comments_code)
			Result.append ("%N")
		end

	precondition: STRING is
			-- Selected precondition for set-procedure.
		local
			f_name: STRING
		do
			Result := invariant_part
			if Result /= Void then
				f_name := feature_name_field.text
				Result.replace_substring_all (f_name, "a_" + f_name)
			end
		--	Result := precondition_selector.text
		--	if Result /= Void then
		--		if Result.is_empty or Result.is_equal (pc_None) then
		--			Result := Void
		--		end
		--	end
		end

	invariant_part: STRING is
			-- Invariant for feature. Void if none.
		do
			Result := invariant_field.text
			if Result /= Void then
				if Result.is_empty or Result.is_equal (pc_None) then
					Result := Void
				end
			end
		end

feature -- Element change

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		do
			name_number := a_number
			if name_number /= 0 then
				feature_name_field.set_text	("new_feature" + "_" + name_number.out)
			end
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
		end

	generate_setter_procedure: BOOLEAN is
			-- Should a set-procedure be generated?
		do
			Result := procedure_check_box.is_selected
		end

	is_attribute: BOOLEAN is True
			-- Is `Current' an attribute editor?

feature {EB_QUERY_COMPOSITION_WIZARD} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		local
			hb_type: EV_HORIZONTAL_BOX
		do
			Precursor
			hb_type ?= type_selector.parent
			check hb_type /= Void end
			hb_type.prune (type_selector)
			hb_type.extend (new_label ("expanded "))
			hb_type.disable_item_expand (hb_type.last)
			hb_type.extend (type_selector)
		end

feature {NONE} -- Implementation

	pc_None: STRING is "(none)"
			-- Mark for no precondition.

--	on_set_procedure_select is
--			-- User selected set-procedure.
--		do
--			if procedure_check_box.is_selected then
--				precondition_selector.enable_sensitive
--			else
--				precondition_selector.disable_sensitive
--			end
--		end

	on_declaration_change is
			-- Update invariant when attribute declaration changes.
		do
			if feature_name_field.text /= Void then
				fill_with_assertions (invariant_field, False)
			else
				invariant_field.wipe_out
				invariant_field.set_text (Pc_none)
			end
		end

	on_invariant_focus_gain is
			-- `invariant_field' gained focus: update.
		do
			fill_with_assertions (invariant_field, False)
		end

	on_precondition_focus_gain is
			-- `precondition_selector' gained focus: update.
		do
			fill_with_assertions (precondition_selector, True)
		end

	fill_with_assertions (b: EV_COMBO_BOX; for_precondition: BOOLEAN) is
			-- Fill `b' with assertions for current attribute.
		local
			pc: LIST [STRING]
			li: EV_LIST_ITEM
			inv, f_name: STRING
		do
			f_name := feature_name_field.text
			b.wipe_out
			create li.make_with_text (pc_None)
			b.extend (li)

			if for_precondition then
				pc := assertions ("a_" + f_name, type_selector.code)
			else
				pc := assertions (f_name, type_selector.code)
			end
			from
				pc.start
			until
				pc.after
			loop
				create li.make_with_text (pc.item)
				b.extend (li)
				pc.forth
			end

			if for_precondition then
				inv := invariant_field.text
				if inv /= Void and then not inv.is_empty then
					inv.replace_substring_all (f_name, "a_" + f_name)
					pc.compare_objects
					if not pc.has (inv) then
						create li.make_with_text (inv)
						b.extend (li)
					end
					b.set_text (inv)
				end
			end
				-- Get rid of the focus_in_actions since it can interfere
				-- with the expected behavior of the combo-box.
			b.focus_in_actions.wipe_out
		end

	invariant_field: EV_COMBO_BOX
			-- Editor that lets the user type an invariant
			-- for current attribute.

	procedure_check_box: EV_CHECK_BUTTON
			-- Selector for automatic generation of set-procedure
			-- for current attribute in "Element change".

	precondition_selector: EV_COMBO_BOX
			-- Edit field where the user can select from
			-- generated preconditions or type her own.

end -- class EB_ATTRIBUTE_EDITOR
