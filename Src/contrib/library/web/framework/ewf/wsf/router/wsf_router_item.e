note
	description: "[
				Entry of WSF_ROUTER
				It contains
					- mapping
					- request methods

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTER_ITEM

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (m: like mapping; r: like request_methods)
		do
			mapping := m
			set_request_methods (r)
		end

feature	-- Access

	mapping: WSF_ROUTER_MAPPING

	request_methods: detachable WSF_REQUEST_METHODS

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		local
			s: STRING_32
		do
			create s.make_from_string_general (mapping.debug_output)
			if attached request_methods as mtds then
				s.append_string (" [ ")
				across
					mtds as c
				loop
					s.append_string_general (c.item)
					s.append_string (" ")
				end
				s.append_string ("]")
			end
			Result := s
		end

feature -- Change

	set_request_methods (r: like request_methods)
			-- Set `request_methods' to `r'
		do
			request_methods := r
		end

invariant
	mapping_attached: mapping /= Void

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
