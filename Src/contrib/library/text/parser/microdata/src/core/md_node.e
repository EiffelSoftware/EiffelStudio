note
	description: "Summary description for {MD_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_NODE

inherit
	DEBUG_OUTPUT

feature -- Access

	document: detachable MD_DOCUMENT
			-- Root document, if any.
		do
			if attached {MD_DOCUMENT} Current as curr then
				Result := curr
			elseif attached parent as p then
				if attached {MD_DOCUMENT} p as doc then
					Result := doc
				else
					Result := p.document
				end
			end
		end

	parent: detachable MD_COMPOSITE
			-- Parent of current node;
			-- Void if current node is root

feature {MD_COMPOSITE} -- Change

	set_parent (p: detachable MD_COMPOSITE)
		do
			parent := p
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		deferred
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
