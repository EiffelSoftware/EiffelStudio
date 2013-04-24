note
	description: "[
		Information about a network resource.		
		The structure is returned during enumeration of network resources. 
		It is also specified when making or querying a network connection
		with calls to various Windows Networking functions.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NET_RESOURCE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_NETWORKING_CONSTANTS
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
		do
			structure_make
			initialize
			set_scope(Resource_globalnet)
			set_type(Resource_type_disk)
			set_display_type(Resource_display_type_generic)
			set_usage(Resource_usage_connectable)
		ensure
			scope_set: scope = Resource_globalnet
			type_set: type = Resource_type_disk
			display_type_set: display_type = Resource_display_type_generic
			usage_set: usage = Resource_usage_connectable
			local_name_set: local_name = Void
			remote_name_set: remote_name = Void
			comment_set: comment = Void
			provider_set: provider = Void
		end

feature -- Access

	scope: INTEGER
			-- Value that contains the scope of the enumeration.
		do
			Result := cwel_net_resource_get_scope (item)
		ensure
			valid_result:
				Result = Resource_connected or
				Result = Resource_globalnet or
				Result = Resource_remembered
		end

	type: INTEGER
			-- Value that contains a set of bit flags identifying the
			-- type of resource.
		do
			Result := cwel_net_resource_get_type (item)
		ensure
			valid_result:
				Result = Resource_type_any or
				Result = Resource_type_disk or
				Result = Resource_type_print
		end

	display_type: INTEGER
			-- Value that indicates how the network object should be
			-- displayed in a network browsing user interface.
		do
			Result := cwel_net_resource_get_display_type (item)
		ensure
			valid_result:
				Result = Resource_display_type_domain or
				Result = Resource_display_type_server or
				Result = Resource_display_type_share or
				Result = Resource_display_type_generic
		end


	usage: INTEGER
			-- Value that contains a set of bit flags describing how
			-- the resource can be used.
		do
			Result := cwel_net_resource_get_display_type (item)
		ensure
			valid_result:
				Result = Resource_usage_connectable or
				Result = Resource_usage_container
		end

	local_name: STRING_32
			-- If `scope' is equal to `Resource_connected' or
			-- `Resource_remembered', it specifies the name of a local
			-- device. It is Void if the connection does not use a device.
		local
			l_name: like internal_local_name
		do
			l_name := internal_local_name
			if l_name /= Void then
				Result := l_name.string
			else
				create Result.make_empty
			end
		ensure
			local_name_attached: Result /= Void
			valid_scope: (scope = Resource_connected or scope = Resource_remembered)
		end

	remote_name: STRING_32
			-- If the entry is a network resource, it specifies the remote
			-- network name.
			--
			-- If the entry is a current or persistent connection, it points
			-- to the network name associated with the name pointed to by
			-- `local_name'.
			--
			-- The string can be MAX_PATH characters in length, and it must
			-- follow the network provider's naming conventions.
		local
			l_name: like internal_remote_name
		do
			l_name := internal_remote_name
			if l_name /= Void then
				Result := l_name.string
			else
				create Result.make_empty
			end
		end

	comment: STRING_32
			-- Comment supplied by the network provider.
			-- It can be Void if there is no supplied comment.
		local
			l_name: like internal_comment
		do
			l_name := internal_comment
			if l_name /= Void then
				Result := l_name.string
			else
				create Result.make_empty
			end
		end

	provider: STRING_32
			-- Name of the provider that owns the resource.
			-- It can be Void if the provider name is unknown.
			--
			-- To retrieve the provider name, you can call
			-- `WNetGetProviderName'.
		local
			l_provider: like internal_provider
		do
			l_provider := internal_provider
			if l_provider /= Void then
				Result := l_provider.string
			else
				create Result.make_empty
			end
		end

feature -- Element change

	set_scope (a_value: INTEGER)
			-- Set `scope' to `a_value'
		require
			valid_value:
				a_value = Resource_connected or
				a_value = Resource_globalnet or
				a_value = Resource_remembered
		do
			cwel_net_resource_set_scope (item, a_value)
		ensure
			value_set: scope = a_value
		end

	set_type (a_value: INTEGER)
			-- Set `type' to `a_value'
		require
			valid_value:
				a_value = Resource_type_any or
				a_value = Resource_type_disk or
				a_value = Resource_type_print
		do
			cwel_net_resource_set_type (item, a_value)
		ensure
			value_set: type = a_value
		end

	set_display_type (a_value: INTEGER)
			-- Set `display_type' to `a_value'
		require
			valid_value:
				a_value = Resource_display_type_domain or
				a_value = Resource_display_type_server or
				a_value = Resource_display_type_share or
				a_value = Resource_display_type_generic
		do
			cwel_net_resource_set_display_type (item, a_value)
		ensure
			value_set: display_type = a_value
		end

	set_usage (a_value: INTEGER)
			-- Set `usage' to `a_value'
			--
			-- Note that this member can be specified only if `scope'
			-- is equal to `Resource_globalnet'
		require
			global_scope: scope = Resource_globalnet
			valid_value:
				a_value = Resource_usage_connectable or
				a_value = Resource_usage_container
		do
			cwel_net_resource_set_usage (item, a_value)
		ensure
			value_set: usage = a_value
		end

	set_local_name (a_value: detachable READABLE_STRING_GENERAL)
			-- Set `local_name' to `a_value'
			--
			-- Can only be set if `scope' is equal to `Resource_connected'
			-- or `Resource_remembered'.
		require
			connection_use_device: scope = Resource_connected or scope = Resource_remembered
		local
			string_pointer: POINTER
			l_name: like internal_local_name
		do
			if a_value /= Void then
				create l_name.make (a_value)
				internal_local_name := l_name
				string_pointer := l_name.item
			else
				internal_local_name := Void
			end
			cwel_net_resource_set_local_name (item, string_pointer)
		ensure
			value_set_void: a_value = Void implies local_name.is_empty
			value_set_attached: a_value /= Void implies local_name.same_string_general (a_value)
		end

	set_remote_name (a_value: READABLE_STRING_GENERAL)
			-- Set `remote_name' to `a_value'
			--
			-- The string can be MAX_PATH characters in length, and it must
			-- follow the network provider's naming conventions.
		require
			a_value_not_void: a_value /= Void
			valid_value: a_value.count <= Max_path
		local
			string_pointer: POINTER
			l_name: like internal_remote_name
		do
			create l_name.make (a_value)
			internal_remote_name := l_name
			string_pointer := l_name.item
			cwel_net_resource_set_remote_name (item, string_pointer)
		ensure
			value_set: remote_name.same_string_general (a_value)
		end

	set_comment (a_value: detachable READABLE_STRING_GENERAL)
			-- Set `comment' to `a_value'
		local
			string_pointer: POINTER
			l_name: like internal_comment
		do
			if a_value /= Void then
				create l_name.make (a_value)
				internal_comment := l_name
				string_pointer := l_name.item
			else
				internal_comment := Void
			end
			cwel_net_resource_set_comment (item, string_pointer)
		ensure
			value_set_void: a_value = Void implies comment.is_empty
			value_set_attached: a_value /= Void implies comment.same_string_general (a_value)
		end

	set_provider (a_value: detachable READABLE_STRING_GENERAL)
			-- Set `provider' to `a_value'
		local
			string_pointer: POINTER
			l_provider: like internal_provider
		do
			if a_value /= Void then
				create l_provider.make (a_value)
				internal_provider := l_provider
				string_pointer := l_provider.item
			else
				internal_provider := Void
			end
			cwel_net_resource_set_provider (item, string_pointer)
		ensure
			value_set_void: a_value = Void implies provider.is_empty
			value_set_attached: a_value /= Void implies provider.same_string_general (a_value)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_netresource
		end

feature {NONE} -- Implementation

	internal_local_name: detachable WEL_STRING
			-- WEL_STRING for `local_name'. Void if none.

	internal_remote_name: detachable WEL_STRING
			-- WEL_STRING for `remote_name'. Void if none.

	internal_comment: detachable WEL_STRING
			-- WEL_STRING for `comment'. Void if none.

	internal_provider: detachable WEL_STRING
			-- WEL_STRING for `provider'. Void if none.

feature {NONE} -- Externals

	c_size_of_netresource: INTEGER
		external
			"C [macro <wel_net_resource.h>]"
		alias
			"sizeof (NETRESOURCE)"
		end

	cwel_net_resource_get_scope (ptr: POINTER): INTEGER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_type (ptr: POINTER): INTEGER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_display_type (ptr: POINTER): INTEGER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_usage (ptr: POINTER): INTEGER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_local_name (ptr: POINTER): POINTER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_remote_name (ptr: POINTER): POINTER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_comment (ptr: POINTER): POINTER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_provider (ptr: POINTER): POINTER
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_scope (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_type (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_display_type (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_usage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_local_name (ptr: POINTER; value: POINTER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_remote_name (ptr: POINTER; value: POINTER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_comment (ptr: POINTER; value: POINTER)
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_provider (ptr: POINTER; value: POINTER)
		external
			"C [macro <wel_net_resource.h>]"
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
