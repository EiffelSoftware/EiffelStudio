indexing
	description	: "Networking constants"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_NETWORKING_CONSTANTS

feature -- Generic constants

	Max_path: INTEGER is 260
			-- Maximum number of characters in full path
			--
			-- Declared in Windows as MAX_PATH
			
feature -- Connect constants

	Connect_interactive: INTEGER is 8
			-- If this flag is set, the operating system may interact with 
			-- the user for authentication purposes.
			--
			-- Declared in Windows as CONNECT_INTERACTIVE

	Connect_prompt: INTEGER is 16
			-- This flag instructs the system not to use any default settings
			-- for user names or passwords without offering the user the 
			-- opportunity to supply an alternative. This flag is ignored 
			-- unless CONNECT_INTERACTIVE is also set.
			--
			-- Declared in Windows as CONNECT_PROMPT

	Connect_redirect: INTEGER is 128
			-- This flag forces the redirection of a local device when making
			-- the connection.
			--
			-- If the lpLocalName member of NETRESOURCE specifies a local
			-- device to redirect, this flag has no effect, because the
			-- operating system still attempts to redirect the specified 
			-- device. When the operating system automatically chooses a local
			-- device, the lpAccessName parameter must point to a return
			-- buffer and the dwType member must not be equal to 
			-- RESOURCETYPE_ANY.
			--
			-- If this flag is not set, a local device is automatically chosen
			-- for redirection only if the network requires a local device to
			-- be redirected.
			--
			-- Declared in Windows as CONNECT_REDIRECT

	Connect_update_profile: INTEGER is 1
			-- This flag instructs the operating system to store the network
			-- resource connection. 
			--
			-- If this bit flag is set, the operating system automatically
			-- attempts to restore the connection when the user logs on. The
			-- system remembers only successful connections that redirect
			-- local devices. It does not remember connections that are
			-- unsuccessful or deviceless connections. (A deviceless
			-- connection occurs when lpLocalName is NULL or when it points
			-- to an empty string.)
			--
			-- If this bit flag is clear, the operating system does not
			-- automatically restore the connection at logon.
			--
			-- Declared in Windows as CONNECT_UPDATE_PROFILE

	Connect_localdrive: INTEGER is 256
			-- If this flag is set, the connection was made using a local
			-- device redirection. If the lpAccessName parameter points to a
			-- buffer, the local device name is copied to the buffer.
			--
			-- Declared in Windows as CONNECT_LOCALDRIVE

feature -- Net Resource constants

	Resource_connected: INTEGER is 1
			-- Enumerate currently connected resources.
			--
			-- Declared in Windows as RESOURCE_CONNECTED

	Resource_globalnet: INTEGER is 2
			-- Enumerate all resources on the network.
			--
			-- Declared in Windows as RESOURCE_GLOBALNET

	Resource_remembered: INTEGER is 3
			-- Enumerate remembered (persistent) connections.
			--
			-- Declared in Windows as RESOURCE_REMEMBERED

	Resource_type_any: INTEGER is 0
			-- All resources
			--
			-- Declared in Windows as RESOURCETYPE_ANY

	Resource_type_disk: INTEGER is 1
			-- Disk resources
			--
			-- Declared in Windows as RESOURCETYPE_DISK

	Resource_type_print: INTEGER is 2
			-- Print resources
			--
			-- Declared in Windows as RESOURCETYPE_PRINT

	Resource_display_type_domain: INTEGER is 1
			-- The object should be displayed as a domain.
			--
			-- Declared in Windows as RESOURCEDISPLAYTYPE_DOMAIN

	Resource_display_type_server: INTEGER is 2
			-- The object should be displayed as a server.
			--
			-- Declared in Windows as RESOURCEDISPLAYTYPE_SERVER

	Resource_display_type_share: INTEGER is 3
			-- The object should be displayed as a share.
			--
			-- Declared in Windows as RESOURCEDISPLAYTYPE_SHARE

	Resource_display_type_generic: INTEGER is 0
			-- The method used to display the object does not matter.
			--
			-- Declared in Windows as RESOURCEDISPLAYTYPE_GENERIC

	Resource_usage_connectable: INTEGER is 1
			-- The resource is a connectable resource
			--
			-- Declared in Windows as RESOURCEUSAGE_CONNECTABLE

	Resource_usage_container: INTEGER is 2
			-- The resource is a container resource
			--
			-- Declared in Windows as RESOURCEUSAGE_CONTAINER
			
feature -- Net Errors

	Error_access_denied: INTEGER is 5
			-- Access to the network resource was denied.
			--
			-- Declared in Windows as ERROR_ACCESS_DENIED

	Error_already_assigned: INTEGER is 85
			-- The local device specified by the lpLocalName member is 
			-- already connected to a network resource.
			--
			-- Declared in Windows as ERROR_ALREADY_ASSIGNED

	Error_bad_device: INTEGER is 1200
			-- The value specified by lpLocalName is invalid.
			--
			-- Declared in Windows as ERROR_BAD_DEVICE

	Error_bad_net_name: INTEGER is 67
			-- The value specified by the lpRemoteName member is not
			-- acceptable to any network resource provider because the
			-- resource name is invalid, or because the named resource
			-- cannot be located.
			--
			-- Declared in Windows as ERROR_BAD_NET_NAME

	Error_bad_provider: INTEGER is 1204
			-- The value specified by the lpProvider member does not match
			-- any provider.
			--
			-- Declared in Windows as ERROR_BAD_PROVIDER

	Error_cancelled: INTEGER is 1223
			-- The attempt to make the connection was canceled by the user
			-- through a dialog box from one of the network resource
			-- providers, or by a called resource.
			--
			-- Declared in Windows as ERROR_CANCELLED

	Error_extended_error: INTEGER is 1208
			-- A network-specific error occurred. To obtain a description of
			-- the error, call the WNetGetLastError function.
			--
			-- Declared in Windows as ERROR_EXTENDED_ERROR

	Error_invalid_address: INTEGER is 487
			-- The caller passed in a pointer to a buffer that could not be
			-- accessed.
			--
			-- Declared in Windows as ERROR_INVALID_ADDRESS

	Error_invalid_parameter: INTEGER is 87
			-- This error is a result of one of the following conditions: 
			-- 1. The lpRemoteName member is NULL. In addition, lpAccessName
			--    is not NULL, but lpBufferSize is either NULL or points to
			--    zero. 
			-- 2. The dwType member is neither RESOURCETYPE_DISK nor
			--    RESOURCETYPE_PRINT. In addition, either CONNECT_REDIRECT
			--    is set in dwFlags and lpLocalName is NULL, or the
			--    connection is to a network that requires the redirecting
			--    of a local device. 
			--
			-- Declared in Windows as ERROR_INVALID_PARAMETER

	Error_invalid_password: INTEGER is 86
			-- The specified password is invalid and the CONNECT_INTERACTIVE
			-- flag is not set.
			--
			-- Declared in Windows as ERROR_INVALID_PASSWORD

	Error_more_data: INTEGER is 234
			-- The lpAccessName buffer is too small. 
			-- If a local device is redirected, the buffer needs to be large
			-- enough to contain the local device name. Otherwise, the
			-- buffer needs to be large enough to contain either the string
			-- pointed to by lpRemoteName, or the name of the connectable
			-- resource whose alias is pointed to by lpRemoteName. If this
			-- error is returned, then no connection has been made.
			--
			-- Declared in Windows as ERROR_MORE_DATA

	Error_no_more_items: INTEGER is 259
			-- The operating system cannot automatically choose a local
			-- redirection because all the valid local devices are in use.
			--
			-- Declared in Windows as ERROR_NO_MORE_ITEMS

	Error_no_net_or_bad_path: INTEGER is 1203
			-- The operation could not be completed, either because a
			-- network component is not started, or because the specified
			-- resource name is not recognized.
			--
			-- Declared in Windows as ERROR_NO_NET_OR_BAD_PATH

	Error_no_network: INTEGER is 1222
			-- The network is unavailable.
			--
			-- Declared in Windows as ERROR_NO_NETWORK

end -- class WEL_NETWORKING_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

