note
	description: "Mailer object used to send or retrieve resources"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	MAILER

create
	default_create

feature -- Access

	from_resource: detachable EMAIL_RESOURCE
		-- Resource that will be sent.

	to_resource: detachable EMAIL_RESOURCE
		-- Resource that will receive.

feature -- Status report

	transfer_error: detachable TRANSFER_ERROR
		-- Has the transfer failed?

	error: BOOLEAN
		local
			l_transfer_error: like transfer_error
		do
			l_transfer_error := transfer_error
			Result:= l_transfer_error /= Void and then l_transfer_error.transfer_error
		end

	is_valid_for_transfer: BOOLEAN
			-- Are we allowed to call `transfer'?
		local
			l_from_resource: like from_resource
			l_to_resource: like to_resource
		do
			l_from_resource := from_resource
			l_to_resource := to_resource
			Result := l_from_resource /= Void and then l_to_resource /= Void and then
				((l_from_resource.can_be_sent and then l_to_resource.can_send) or
				(l_from_resource.can_receive and then l_to_resource.can_be_received))
		ensure
			attached_resources: Result implies (from_resource /= Void and to_resource /= Void)
		end

feature -- Settings

	set_from_resource (resource: EMAIL_RESOURCE)
			-- Set 'resource' to from_resource.
		require
			resource_exists: resource /= Void
			valid_from_resource: resource.can_be_sent or resource.can_receive
		do
			disable_transfer_error
			from_resource:= resource
			transfer_error := resource.transfer_error
		end

	set_to_resource (resource: EMAIL_RESOURCE)
			-- Set 'resource' to to_resource.
		require
			resource_exists: resource /= Void
			valid_to_resource: resource.can_send or resource.can_be_received
		do
			disable_transfer_error
			to_resource:= resource
			transfer_error:= resource.transfer_error
		end

feature -- Basic operations

	transfer
			-- transfer data and check for errors.
		require
			is_valid_for_transfer: is_valid_for_transfer
		do
				-- Implied by precondition
			check
				from_resource_attached: attached from_resource as l_from_resource
				to_resource_attached: attached to_resource as l_to_resource
			then
				l_to_resource.transfer (l_from_resource)
			end
		end

feature {NONE} -- Implementation

	disable_transfer_error
			-- Unset error.
		local
			l_transfer_error: like transfer_error
		do
			l_transfer_error := transfer_error
			if l_transfer_error /= Void then
				l_transfer_error.disable_transfer_error
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class MAILER

