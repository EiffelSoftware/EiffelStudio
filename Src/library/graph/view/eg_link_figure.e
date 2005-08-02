indexing
	description: "Object is a view for an EG_LINK"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_LINK_FIGURE

inherit
	EG_FIGURE
		redefine
			initialize,
			model,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			recycle
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' (synchronize with `model')
		do
			Precursor {EG_FIGURE}
			model.is_directed_change_actions.extend (agent on_is_directed_change)
		end
		
feature -- Status report

	is_reflexive: BOOLEAN is
			-- Is `Current' reflexive?
		do
			Result := source /= Void and then source = target
		end
		

feature -- Access

	source: EG_LINKABLE_FIGURE
			-- source of `Current'.
			
	target: like source
			-- target of `Current'.
			
	model: EG_LINK
			-- The model for `Current'.
			
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			Result := Precursor {EG_FIGURE} (node)
			Result.add_attribute ("SOURCE", xml_namespace, model.source.name)
			Result.add_attribute ("TARGET", xml_namespace, model.target.name)
			Result.put_last (Xml_routines.xml_node (Result, "IS_DIRECTED", model.is_directed.out))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			node.forth
			node.forth
			Precursor {EG_FIGURE} (node)
			model.set_is_directed (xml_routines.xml_boolean (node, "IS_DIRECTED"))
		end
		
	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EG_LINK_FIGURE"
		end
		
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EG_FIGURE}
			if model /= Void then
				model.is_directed_change_actions.extend (agent on_is_directed_change)
			end
		end
			
feature {EG_FIGURE_WORLD} -- Element change.

	set_source (a_source: like source) is
			-- Set `source' to `a_source'.
		require
			a_source_not_void: a_source /= Void
		do
			source := a_source
			request_update
		ensure
			set: a_source = source
		end
		
	set_target (a_target: like target) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			request_update
		ensure
			set: a_target = target
		end
		
feature {NONE} -- Implementation

	on_is_directed_change is
			-- `model'.`is_directed' changed.
		deferred
		end

end -- class EG_LINK_FIGURE

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

