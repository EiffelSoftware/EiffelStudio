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
			create name_label
			Precursor {EV_MODEL_MOVE_HANDLE}
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
			if l_model = Void then
				check model_not_void: False end -- Implied by precondition `model_not_void'
				name_label.set_text (once "")
				name_label.hide
			else
				if attached l_model.name_32 as l_name then
					set_name_label_text (l_name)
				else
					name_label.set_text (once "")
					name_label.hide
				end
				l_model.name_change_actions.extend (agent on_name_change)
			end
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
			if attached {like world} Precursor as l_result then
				Result := l_result
			end
		end

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		local
			l_xml_routines: like xml_routines
			l_model: like model
		do
			l_xml_routines := xml_routines
			l_model := model
			if l_model /= Void and then attached l_model.name_32 as l_name then
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

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			l_xml_routines: like xml_routines
			l_name: READABLE_STRING_32
		do
			if attached node.attribute_by_name (name_string) as l_name_attrib then
				if attached model as l_model then
					l_name := l_name_attrib.value
					if
						attached l_model.name_32 as l_model_name implies
						not l_model_name.same_string (l_name)
					then
						l_model.set_name_32 (l_name)
					end
				end
				node.forth
			end

			l_xml_routines := xml_routines
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

feature -- Visitor

	process (v: EG_FIGURE_VISITOR)
			-- Visitor feature.
		do
			v.process_figure (Current)
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
			if attached model as l_model and then attached l_model.name_32 as l_name then
				if name_label.text.count = 0 and then not is_label_shown then
					name_label.show
				end
				set_name_label_text (l_name)
			else
				name_label.hide
			end
			request_update
		end

	set_name_label_text (a_text: READABLE_STRING_32)
			-- Set `name_label'.`text' to `a_text'.
			-- | Redefine in subclass if you want make changes to the text.
		require
			a_text_not_void: a_text /= Void
			model_not_void: model /= Void
			a_text_equal_model_text: attached model as l_model and then l_model.name_32 = a_text
		do
			name_label.set_text (a_text)
		end

invariant
	name_label_not_void: name_label /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
