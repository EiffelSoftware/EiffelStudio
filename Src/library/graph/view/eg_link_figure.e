note
	description: "Object is a view for an EG_LINK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			recycle,
			process
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current' (synchronize with `model')
		do
			Precursor {EG_FIGURE}
			if attached model as l_model then
				l_model.is_directed_change_actions.extend (agent on_is_directed_change)
			else
				check model_not_void: False end -- Implied by precondition `model_not_void'
			end
		end

feature -- Status report

	is_reflexive: BOOLEAN
			-- Is `Current' reflexive?
		do
			Result := attached source as l_source and then l_source = target
		end

feature -- Access

	source: detachable EG_LINKABLE_FIGURE
			-- source of `Current'.

	target: like source
			-- target of `Current'.

	model: detachable EG_LINK
			-- The model for `Current'.

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		do
			Result := Precursor {EG_FIGURE} (node)
			if attached model as l_model then
				if attached l_model.source.link_name_32 as l_source_link_name then
					Result.add_attribute (once "SOURCE", xml_namespace, l_source_link_name)
				end
				if attached l_model.target.link_name_32 as l_target_link_name then
					Result.add_attribute (once "TARGET", xml_namespace, l_target_link_name)
				end
				Result.put_last (Xml_routines.xml_node (Result, is_directed_string, boolean_representation (l_model.is_directed)))
			else
				check has_model: False end
			end
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		do
			node.forth
			node.forth
			Precursor {EG_FIGURE} (node)
			if attached model as l_model then
				l_model.set_is_directed (xml_routines.xml_boolean (node, is_directed_string))
			else
				check has_model: False end
			end
		end

	is_directed_string: STRING = "IS_DIRECTED"

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := once "EG_LINK_FIGURE"
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EG_FIGURE}
			if attached model as l_model then
				l_model.is_directed_change_actions.extend (agent on_is_directed_change)
			end
		end

feature {EG_FIGURE_WORLD} -- Element change.

	set_source (a_source: like source)
			-- Set `source' to `a_source'.
		require
			a_source_not_void: a_source /= Void
		do
			source := a_source
			request_update
		ensure
			set: a_source = source
		end

	set_target (a_target: like target)
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			request_update
		ensure
			set: a_target = target
		end

feature -- Visitor

	process (v: EG_FIGURE_VISITOR)
			-- Visitor feature.
		do
			v.process_link_figure (Current)
		end

feature {NONE} -- Implementation

	on_is_directed_change
			-- `model'.`is_directed' changed.
		deferred
		end

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
