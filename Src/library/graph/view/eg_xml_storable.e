note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_XML_STORABLE

inherit
	ANY

	XML_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

feature -- Access

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		require
			node_not_void: node /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		deferred
		ensure
			Result_not_Void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Element change

	set_with_xml_element (node: like xml_element)
			-- Retrieve state from `node'.
		require
			node_not_void: node /= Void
		deferred
		end

feature -- Visitor

	process (v: EG_FIGURE_VISITOR)
			-- Visitor feature.
		require
			v_not_void: v /= Void
		deferred
		end

feature {NONE} -- Implementation

	boolean_representation (a_boolean: BOOLEAN): STRING
			-- Optimized string representation of `a_boolean'.
		do
			if a_boolean then
				Result := once "True"
			else
				Result := once "False"
			end
		end

	xml_namespace: XML_NAMESPACE
		once
			create Result.make_default
		end

	Xml_routines: XML_GRAPH_ROUTINES
			-- Access the common xml routines
		once
			create Result.default_create
		ensure
			non_void_Xml_routines: Xml_routines /= Void
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EG_XML_STORABLE

