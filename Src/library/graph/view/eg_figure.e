note
	description: "Objects that is a view for an EG_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_FIGURE

inherit
	EV_MODEL_MOVE_HANDLE
		undefine
			new_filled_list
		redefine
			world,
			default_create
		end

	EG_XML_STORABLE
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create an EG_FIGURE
		do
			Precursor {EV_MODEL_MOVE_HANDLE}
			create name_label
			extend (name_label)
			is_center_valid := True
		end

	initialize
			-- Initialize `Current' (synchronize with model).
		require
			model_not_void: model /= Void
		local
			l_model: like model
		do
			l_model := model
			check l_model /= Void end -- Implied by precondition `model_not_void'
			if attached l_model.name as l_name then
				set_name_label_text (l_name)
			else
				name_label.set_text (once "")
				name_label.hide
			end
			l_model.name_change_actions.extend (agent on_name_change)
		end

feature -- Access

	is_storable: BOOLEAN
			-- Does `Current' need to be persistently stored?
			-- True by default.
		do
			Result := True
		end

	model: detachable EG_ITEM
			-- The model for `Current'

	world: detachable EG_FIGURE_WORLD
			-- The world `Current' is part of.
		do
			Result ?= Precursor {EV_MODEL_MOVE_HANDLE}
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT
			-- Xml node representing `Current's state.
		local
			l_xml_routines: like xml_routines
			l_model: like model
		do
			l_xml_routines := xml_routines
			l_model := model
			check l_model /= Void end -- FIXME: Implied by ...?
			if attached l_model.name as l_name then
				node.add_attribute (name_string, xml_namespace, l_name)
			end
			node.put_last (l_xml_routines.xml_node (node, is_selected_string, boolean_representation (is_selected)))
			node.put_last (l_xml_routines.xml_node (node, is_label_shown_string, boolean_representation (is_label_shown)))
			Result := node
		end

	is_selected_string: STRING = "IS_SELECTED"
	is_label_shown_string: STRING = "IS_LABEL_SHOWN"
	name_string: STRING = "NAME"
		-- XML String constants.

	set_with_xml_element (node: XM_ELEMENT)
			-- Retrive state from `node'.
		local
			l_name: STRING
			l_xml_routines: like xml_routines
			l_model: like model
			l_attribute: detachable XM_ATTRIBUTE
			l_model_name: detachable STRING_8
		do
			l_xml_routines := xml_routines
			if node.has_attribute_by_name (name_string) then
				l_attribute := node.attribute_by_name (name_string)
				check l_attribute /= Void end -- Implied by `has_attribute_by_name'
				l_name := l_attribute.value
				l_model := model
				check l_model /= Void end -- FIXME: Implied by ...?
				l_model_name := l_model.name
				if (l_model_name = Void) or else not (l_model_name ~ (l_name)) then
					l_model.set_name (l_name)
				end
				node.forth
			end
			set_is_selected (l_xml_routines.xml_boolean (node, is_selected_string))
			if l_xml_routines.xml_boolean (node, is_label_shown_string) then
				if not is_label_shown then
					show_label
				end
			else
				if is_label_shown then
					hide_label
				end
			end
		end

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := once "EG_FIGURE"
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected?

	is_label_shown: BOOLEAN
			-- Is label shown?
		do
			Result := name_label.is_show_requested
		end

	is_update_required: BOOLEAN
			-- Is an update required?

feature -- Element change

	recycle
			-- Free resources of `Current' such that GC can collect it.
			-- Leave it in an unstable state.
		do
			if attached model as l_model then
				l_model.name_change_actions.prune_all (agent on_name_change)
			end
		end

feature -- Status setting

	enable_selected
			-- Enable select.
		do
			set_is_selected (True)
		ensure
			selected: is_selected
		end

	disable_selected
			-- Disable select.
		do
			set_is_selected (False)
		ensure
			deselected: not is_selected
		end

	show_label
			-- Show name label.
		require
			not_shown: not is_label_shown
		do
			name_label.show
			request_update
		ensure
			is_label_shown: is_label_shown
		end

	hide_label
			-- Hide name label.
		require
			shown: is_label_shown
		do
			name_label.hide
			request_update
		ensure
			not_is_lable_shown: not is_label_shown
		end

	request_update
			-- Set `is_update_required' to True.
		do
			is_update_required := True
		ensure
			set: is_update_required
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update
			-- Some properties may have changed.
		deferred
		ensure
			not_is_update_required: not is_update_required
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected)
			-- Set `is_selected' to `an_is_selected'.
		deferred
		ensure
			is_selected_assigned: is_selected = an_is_selected
		end

	name_label: EV_MODEL_TEXT
			-- The label for the name.

	on_name_change
			-- Name was changed in the model.
		do
			if (attached model as l_model) and then (attached l_model.name as l_name) then
				if name_label.text.is_equal ("") and not is_label_shown then
					name_label.show
				end
				set_name_label_text (l_name)
			else
				name_label.hide
			end
			request_update
		end

	set_name_label_text (a_text: STRING)
			-- Set `name_label'.`text' to `a_text'.
			-- | Redefine in subclass if you want make changes to the text.
		require
			a_text_not_void: a_text /= Void
			model_not_void: model /= Void
			a_text_equal_model_text: attached model as l_model and then l_model.name = a_text
		do
			name_label.set_text (a_text)
		end

invariant
	name_label_not_void: name_label /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_FIGURE

