indexing
	description: "[
		Information about a network resource.		
		The structure is returned during enumeration of network resources. 
		It is also specified when making or querying a network connection
		with calls to various Windows Networking functions.
		]"
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

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
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

	scope: INTEGER is
			-- Value that contains the scope of the enumeration.
		do
			Result := cwel_net_resource_get_scope (item)
		ensure
			valid_Result:
				Result = Resource_connected or
				Result = Resource_globalnet or
				Result = Resource_remembered
		end

	type: INTEGER is
			-- Value that contains a set of bit flags identifying the 
			-- type of resource.
		do
			Result := cwel_net_resource_get_type (item)
		ensure
			valid_Result:
				Result = Resource_type_any or
				Result = Resource_type_disk or
				Result = Resource_type_print
		end
		
	display_type: INTEGER is
			-- Value that indicates how the network object should be
			-- displayed in a network browsing user interface.
		do
			Result := cwel_net_resource_get_display_type (item)
		ensure
			valid_Result:
				Result = Resource_display_type_domain or
				Result = Resource_display_type_server or
				Result = Resource_display_type_share or
				Result = Resource_display_type_generic
		end
		
		
	usage: INTEGER is
			-- Value that contains a set of bit flags describing how
			-- the resource can be used.
		do
			Result := cwel_net_resource_get_display_type (item)
		ensure
			valid_Result:
				Result = Resource_usage_connectable or
				Result = Resource_usage_container
		end

	local_name: STRING is
			-- If `scope' is equal to `Resource_connected' or 
			-- `Resource_remembered', it specifies the name of a local
			-- device. It is Void if the connection does not use a device.
		local
			string_pointer: POINTER
			null_pointer: POINTER
		do
			string_pointer := cwel_net_resource_get_local_name (item)
			if string_pointer /= null_pointer then
				create Result.make (0)
				Result.from_c (string_pointer)
			end
		ensure
			valid_result: (Result /= Void) = (scope = Resource_connected or scope = Resource_remembered)
		end
		
	remote_name: STRING is
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
			string_pointer: POINTER
			null_pointer: POINTER
		do
			string_pointer := cwel_net_resource_get_remote_name (item)
			if string_pointer /= null_pointer then
				create Result.make (0)
				Result.from_c (string_pointer)
			end
		end
		
	comment: STRING is
			-- Comment supplied by the network provider.
			-- It can be Void if there is no supplied comment.
		local
			string_pointer: POINTER
			null_pointer: POINTER
		do
			string_pointer := cwel_net_resource_get_comment (item)
			if string_pointer /= null_pointer then
				create Result.make (0)
				Result.from_c (string_pointer)
			end
		end
		
	provider: STRING is
			-- Name of the provider that owns the resource.
			-- It can be Void if the provider name is unknown.
			--
			-- To retrieve the provider name, you can call
			-- `WNetGetProviderName'.
		local
			string_pointer: POINTER
			null_pointer: POINTER
		do
			string_pointer := cwel_net_resource_get_provider (item)
			if string_pointer /= null_pointer then
				create Result.make (0)
				Result.from_c (string_pointer)
			end
		end
		
feature -- Element change

	set_scope (a_value: INTEGER) is
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

	set_type (a_value: INTEGER) is
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

	set_display_type (a_value: INTEGER) is
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

	set_usage (a_value: INTEGER) is
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

	set_local_name (a_value: STRING) is
			-- Set `local_name' to `a_value'
			--
			-- Can only be set if `scope' is equal to `Resource_connected'
			-- or `Resource_remembered'.
		require
			connection_use_device: scope = Resource_connected or scope = Resource_remembered
		local
			string_pointer: POINTER
		do
			if a_value /= Void then
				create internal_local_name.make (a_value)
				string_pointer := internal_local_name.item
			else
				internal_local_name := Void
			end
			cwel_net_resource_set_local_name (item, string_pointer)
		ensure
			value_set: equal (local_name, a_value)
		end
		
	set_remote_name (a_value: STRING) is
			-- Set `remote_name' to `a_value'
			--
			-- The string can be MAX_PATH characters in length, and it must
			-- follow the network provider's naming conventions.
		require
			valid_value: a_value.count <= Max_path 
		local
			string_pointer: POINTER
		do
			if a_value /= Void then
				create internal_remote_name.make (a_value)
				string_pointer := internal_remote_name.item
			else
				internal_remote_name := Void
			end
			cwel_net_resource_set_remote_name (item, string_pointer)
		ensure
			value_set: equal (remote_name, a_value)
		end
		
	set_comment (a_value: STRING) is
			-- Set `comment' to `a_value'
		local
			string_pointer: POINTER
		do
			if a_value /= Void then
				create internal_comment.make (a_value)
				string_pointer := internal_comment.item
			else
				internal_comment := Void
			end
			cwel_net_resource_set_comment (item, string_pointer)
		ensure
			value_set: equal (comment, a_value)
		end
		
	set_provider (a_value: STRING) is
			-- Set `provider' to `a_value'
		local
			string_pointer: POINTER
		do
			if a_value /= Void then
				create internal_provider.make (a_value)
				string_pointer := internal_provider.item
			else
				internal_provider := Void
			end
			cwel_net_resource_set_provider (item, string_pointer)
		ensure
			value_set: equal (provider, a_value)
		end
		
feature {NONE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_netresource
		end

feature {NONE} -- Implementation

	internal_local_name: WEL_STRING
			-- WEL_STRING for `local_name'. Void if none.

	internal_remote_name: WEL_STRING
			-- WEL_STRING for `remote_name'. Void if none.

	internal_comment: WEL_STRING
			-- WEL_STRING for `comment'. Void if none.

	internal_provider: WEL_STRING
			-- WEL_STRING for `provider'. Void if none.

feature {NONE} -- Externals

	c_size_of_netresource: INTEGER is
		external
			"C [macro <wel_net_resource.h>]"
		alias
			"sizeof (NETRESOURCE)"
		end

	cwel_net_resource_get_scope (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_type (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_display_type (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_usage (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_local_name (ptr: POINTER): POINTER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_remote_name (ptr: POINTER): POINTER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_comment (ptr: POINTER): POINTER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_get_provider (ptr: POINTER): POINTER is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_scope (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_type (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_display_type (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_usage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_local_name (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_remote_name (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_comment (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

	cwel_net_resource_set_provider (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wel_net_resource.h>]"
		end

end -- class WEL_NET_RESOURCE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
