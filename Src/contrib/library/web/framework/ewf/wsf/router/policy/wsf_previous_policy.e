note

	description: "[
						Policies for deciding if a resource that currently doesn't exist used to do so.
						This default implementation assumes that no resources used to exist.
						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_PREVIOUS_POLICY

feature -- Access

	resource_previously_existed (req: WSF_REQUEST): BOOLEAN
			-- Did `req.path_translated' exist previously?
		require
			req_attached: req /= Void
		do
			-- No. Override if this is not want you want.
		end

	resource_moved_permanently (req: WSF_REQUEST): BOOLEAN
			-- Was `req.path_translated' moved permanently?
		require
			req_attached: req /= Void
			previously_existed: resource_previously_existed (req)
		do
			-- No. Override if this is not want you want.
		end

	resource_moved_temporarily (req: WSF_REQUEST): BOOLEAN
			-- Was `req.path_translated' moved temporarily?
		require
			req_attached: req /= Void
			previously_existed: resource_previously_existed (req)
		do
			-- No. Override if this is not want you want.
		end

	previous_location (req: WSF_REQUEST): LIST [URI]
			-- Previous location(s) for resource named by `req';
		require
			req_attached: req /= Void
			previously_existed: resource_previously_existed (req)
			moved: resource_moved_permanently (req) or resource_moved_temporarily (req)
		do
			create {LINKED_LIST [URI]} Result.make
		ensure
			previous_location_attached: Result /= Void
			non_empty_list: not Result.is_empty
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
