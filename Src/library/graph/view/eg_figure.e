indexing
	description: "Objects that is a view for an EG_ITEM."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_FIGURE

inherit
	EV_MODEL_MOVE_HANDLE
		redefine
			world,
			default_create
		end
		
	EG_XML_STORABLE
		undefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_FIGURE
		do
			Precursor {EV_MODEL_MOVE_HANDLE}
			create name_label
			extend (name_label)
			is_center_valid := True
		end
		
	initialize is
			-- Initialize `Current' (synchronize with model).
		require
			model_not_void: model /= Void
		do
			if model.name /= Void then
				set_name_label_text (model.name)
			else
				name_label.set_text ("")
				name_label.hide
			end
			model.name_change_actions.extend (agent on_name_change)
		end

feature -- Access

	model: EG_ITEM
			-- The model for `Current'
	
	world: EG_FIGURE_WORLD is
			-- The world `Current' is part of.
		do
			Result ?= Precursor {EV_MODEL_MOVE_HANDLE}
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			if model.name /= Void then
				node.add_attribute ("NAME", xml_namespace, model.name)
			end
			node.put_last (Xml_routines.xml_node (node, "IS_SELECTED", is_selected.out))
			node.put_last (Xml_routines.xml_node (node, "IS_LABEL_SHOWN", is_label_shown.out))
			Result := node
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			l_name: STRING
		do
			if node.has_attribute_by_name ("NAME") then
				l_name := node.attribute_by_name ("NAME").value
				if model.name = Void or else not model.name.is_equal (l_name) then
					model.set_name (l_name)
				end
				node.forth
			end
			set_is_selected (xml_routines.xml_boolean (node, "IS_SELECTED"))
			if xml_routines.xml_boolean (node, "IS_LABEL_SHOWN") then
				if not is_label_shown then
					show_label
				end
			else
				if is_label_shown then
					hide_label
				end
			end
		end

	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EG_FIGURE"
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected?

	is_label_shown: BOOLEAN is
			-- Is label shown?
		do
			Result := name_label.is_show_requested
		end
		
	is_update_required: BOOLEAN
			-- Is an update required?
			
feature -- Element change

	recycle is
			-- Free resources of `Current' such that GC can collect it.
			-- Leave it in an unstable state.
		do
			if model /= Void then
				model.name_change_actions.prune_all (agent on_name_change)
			end
		end
		
feature -- Status setting

	enable_selected is
			-- Enable select.
		do
			set_is_selected (True)
		ensure
			selected: is_selected
		end
		
	disable_selected is
			-- Disable select.
		do
			set_is_selected (False)
		ensure
			deselected: not is_selected
		end

	show_label is
			-- Show name label.
		require
			not_shown: not is_label_shown
		do
			name_label.show
			request_update
		ensure
			is_label_shown: is_label_shown
		end
		
	hide_label is
			-- Hide name label.
		require
			shown: is_label_shown
		do
			name_label.hide
			request_update
		ensure
			not_is_lable_shown: not is_label_shown
		end
		
	request_update is
			-- Set `is_update_required' to True.
		do
			is_update_required := True
		ensure
			set: is_update_required
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		deferred
		ensure
			not_is_update_required: not is_update_required
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		deferred
		ensure
			is_selected_assigned: is_selected = an_is_selected
		end

	name_label: EV_MODEL_TEXT
			-- The label for the name.

	on_name_change is
			-- Name was changed in the model.
		do
			if model.name = Void then
				name_label.hide
			else
				if name_label.text.is_equal ("") and not is_label_shown then
					name_label.show
				end
				set_name_label_text (model.name)
			end
			request_update
		end
		
	set_name_label_text (a_text: STRING) is
			-- Set `name_label'.`text' to `a_text'.
			-- | Redefine in subclass if you want make changes to the text.
		require
			a_text_not_void: a_text /= Void
			model_not_void: model /= Void
			a_text_equal_model_text: model.name = a_text
		do
			name_label.set_text (a_text)
		end
		
invariant
	name_label_not_void: name_label /= Void

end -- class EG_FIGURE

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

