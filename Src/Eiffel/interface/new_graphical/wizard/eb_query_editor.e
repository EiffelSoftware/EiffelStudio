note
	description: "Component to let the user create queries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_QUERY_EDITOR

inherit
	EB_FEATURE_EDITOR
		redefine
			adapt
		end

feature -- Access

	type: STRING
			-- Full type as string.
		do
			Result := type_selector.code
		end

feature -- Element change

	set_type (a_type: STRING)
			-- Set content of `type_field' to `a_type'.
		do
			if a_type.is_empty then
				type_selector.selector.remove_text
			else
				type_selector.set_initial_types (client_type, supplier_type)
				type_selector.selector.set_text (a_type)
				type_selector.update_list_strings (True)
			end
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR)
			-- Set with `other'.
		local
			qe: EB_QUERY_EDITOR
		do
			Precursor (other)
			qe ?= other
			if qe /= Void then
				type_selector.set_from_other (qe.type_selector)
			else
				type_selector.selector.set_text (other.type)
			end
		end

feature -- Status report

	generate_setter_procedure: BOOLEAN
			-- Should a set-procedure be generated?
		do
			Result := syntax_checker.is_valid_feature_name (setter_text.text)
			--| FIXME IEK We need to check that there is not an existing feature.
		end

	setter_name: STRING
			-- Name for setter.
		do
			Result := setter_text.text
		end

feature {EB_FEATURE_EDITOR} -- Implementation

	add_setter
				-- Add setter frame to `Current'.
		local
			l_frame: EV_FRAME
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_frame
			l_frame.set_text (interface_names.l_setter)


			create l_hbox
			l_hbox.set_border_width (layout_constants.default_border_size)
			l_frame.extend (l_hbox)

			create setter_text
			setter_text.set_completing_feature (False)

			create text_completion.make (system.any_class.compiled_class, Void)
			text_completion.set_code_completable (setter_text)

			setter_text.set_completion_possibilities_provider (text_completion)
			setter_text.extend (create {EV_LIST_ITEM}.make_with_text ("(none)"))
			setter_text.extend (create {EV_LIST_ITEM}.make_with_text (feature_name_field.text))

			l_hbox.extend (setter_text)

			l_hbox.extend (create {EV_CELL})
			l_hbox.last.set_minimum_width (layout_constants.default_padding_size)
			l_hbox.disable_item_expand (l_hbox.last)

			create assigner_check_box.make_with_text (interface_names.l_generate_assigner_procedure)
			assigner_check_box.disable_sensitive
			l_hbox.extend (assigner_check_box)
			extend (l_frame)
			disable_item_expand (l_frame)

			setter_text.change_actions.extend (agent setter_name_change)

			feature_name_field.change_actions.extend (agent feature_name_change)
			feature_name_change

			setter_text.first.enable_select
		end

	feature_name_change
			-- Feature name has changed
		local
			l_feat_name: STRING
		do
			l_feat_name := "set_" + feature_name_field.text
			if syntax_checker.is_valid_feature_name (l_feat_name) then
				setter_text.i_th (2).set_text (l_feat_name)
			end
		end

	setter_name_change
			-- Setter name has changed
		do
			if syntax_checker.is_valid_feature_name (setter_text.text) then
				assigner_check_box.enable_sensitive
			else
				assigner_check_box.disable_sensitive
			end
		end

	text_completion: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

	setter_text: EB_CODE_COMPLETABLE_COMBO_BOX
		-- Combo box used to select setter for query if any.

	assigner_check_box: EV_CHECK_BUTTON
			-- Selector for automatic generation of assigner
			-- for current query in "Element change".

	type_selector: EB_TYPE_SELECTOR;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_QUERY_EDITOR
