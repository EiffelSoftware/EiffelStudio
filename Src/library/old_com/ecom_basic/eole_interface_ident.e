indexing

	description: "COM interace identifiers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EOLE_INTERFACE_IDENT

feature -- Access
			
	Iid_advise_sink: STRING is "{0000010F-0000-0000-C000-000000000046}"
			-- Enable containers and other objects to receive notifications
			-- of data changes, view changes, and compound-document changes 
			-- occurring in objects of interest.

	Iid_advise_sink2: STRING is "{00000125-0000-0000-C000-000000000046}"
			-- Extension of Iid_advise_sink, adding method OnLinkSrcChange 
			-- to contract to handle change in moniker of linked object

	Iid_class_factory: STRING is "{00000001-0000-0000-C000-000000000046}"
			-- Contain two methods intended to deal with entire class of objects,
			-- and so is implemented on class object for specific class of 
			-- objects (identified by CLSID). 

	Iid_class_factory2: STRING is "{B196B28F-BAB4-101A-B69C-00AA00341D07}"
			-- Enable class factory object, in any sort of object server, to control 
			-- object creation through licensing.

	Iid_connection_point_container: STRING is "{B196B284-BAB4-101A-B69C-00AA00341D07}"
			-- Support connection points for connectable objects. 

	Iid_connection_point: STRING is "{B196B286-BAB4-101A-B69C-00AA00341D07}"
			-- Support connection points for connectable objects. 

	Iid_create_error_info: STRING is "{22F03340-547D-101b-8E65-08002B2BD119}"
			-- Return error information. 

	Iid_create_type_info: STRING is "{00020405-0000-0000-C000-000000000046}"
			-- Provide tools for creating and administering type information
			-- defined through type description. 

	Iid_create_type_lib: STRING is "{00020406-0000-0000-C000-000000000046}"
			-- Provide methods for creating and managing component or 
			-- file that contains type information. 

	Iid_data_advise_holder: STRING is "{00000110-0000-0000-C000-000000000046}"
			-- Contain methods that create and manage advisory connections 
			-- between data object and one or more advise sinks.

	Iid_data_object: STRING is "{0000010E-0000-0000-C000-000000000046}"
			-- Specify methods that enable data transfer and notification 
			-- of changes in data.
			
	Iid_dispatch: STRING is "{00020400-0000-0000-C000-000000000046}"
			-- Means by which applications expose methods and properties
			-- such that other applications can make use of application's
			-- features.

	Iid_drop_source: STRING is "{00000121-0000-0000-C000-000000000046}"
			-- Provide drag-and-drop operations in your application.

	Iid_drop_target: STRING is "{00000122-0000-0000-C000-000000000046}"
			-- Provide drag-and-drop operations in your application.

	Iid_error_info: STRING is "{1CF2B120-547D-101b-8E65-08002B2BD119}"
			-- Return information about error in addition to return code.

	Iid_external_connection: STRING is "{00000019-0000-0000-C000-000000000046}"
			-- Enable embedded object to keep track of external locks on it,
			-- thereby enabling safe and orderly shutdown of object
			-- following silent updates

	Iid_lock_bytes: STRING is "{0000000A-0000-0000-C000-000000000046}"
			-- Used by OLE compound file storage object to give its root 
			-- storage access to physical device.

	Iid_malloc: STRING is "{00000002-0000-0000-C000-000000000046}"
			-- Allocate, free, and manage memory. 

	Iid_marshal: STRING is "{00000003-0000-0000-C000-000000000046}"
			-- Enable COM object to define and manage marshaling 
			-- of its interface pointers.

	Iid_message_filter: STRING is "{00000016-0000-0000-C000-000000000046}"
			-- Provide OLE servers and applications with ability 
			-- to selectively handle incoming and outgoing OLE messages 
			-- while waiting for responses from synchronous calls.

	Iid_moniker: STRING is "{0000000F-0000-0000-C000-000000000046}"
			-- Contain methods that allow you to use moniker object,
			-- which contains information that uniquely identifies COM object

	Iid_ole_advise_holder: STRING is "{00000111-0000-0000-C000-000000000046}"
			-- Contain methods that manage advisory connections and compound
			-- document notifications in object server. 

	Iid_ole_cache: STRING is "{0000011E-0000-0000-C000-000000000046}"
			-- Provide control of presentation data that gets 
			-- cached inside of object.

	Iid_ole_cache2: STRING is "{00000128-0000-0000-C000-000000000046}"
			-- Allow object clients to selectively update each cache.

	Iid_ole_cache_control: STRING is "{00000129-0000-0000-C000-000000000046}"
			-- Provide proper maintenance of caches.

	Iid_ole_client_site: STRING is "{00000118-0000-0000-C000-000000000046}"
			-- Primary means by which embedded object obtains information
			-- about location and extent of its display site, its moniker,
			-- its user interface, and other resources provided by its container.

	Iid_ole_container: STRING is "{0000011B-0000-0000-C000-000000000046}"
			-- Used to enumerate objects in compound document or lock 
			-- container in running state.

	Iid_ole_control: STRING is "{B196B288-BAB4-101A-B69C-00AA00341D07}"
			-- Provide features for supporting keyboard mnemonics,
			-- ambient properties, and events in control objects.

	Iid_ole_control_site: STRING is "{B196B289-BAB4-101A-B69C-00AA00341D07}"
			-- Provide methods that enable site object to manage each 
			-- embedded control within container.
			
	Iid_ole_inplace_active_object: STRING is "{00000117-0000-0000-C000-000000000046}"
			-- Provide direct channel of communication between in-place
			-- object and associated application’s outer-most frame window
			-- and document window within application that contains embedded object. 

	Iid_ole_inplace_frame: STRING is "{00000116-0000-0000-C000-000000000046}"
			-- Control container’s top-level frame window.
			
	Iid_ole_inplace_object: STRING is "{00000113-0000-0000-C000-000000000046}"
			-- Manage activation and deactivation of in-place objects,
			-- and determine how much of in-place object should be visible. 

	Iid_ole_inplace_site: STRING is "{00000119-0000-0000-C000-000000000046}"
			-- Manage interaction between container and object’s in-place client site. 

	Iid_ole_inplace_ui_window: STRING is "{00000115-0000-0000-C000-000000000046}"
			-- Used by object applications to negotiate border space on
			-- document or frame window.

	Iid_ole_item_container: STRING is "{0000011C-0000-0000-C000-000000000046}"
			-- Used by item monikers when they are bound to objects they identify.

	Iid_ole_link: STRING is "{0000011D-0000-0000-C000-000000000046}"
			-- Means by which linked object provides its container with
			-- functions pertaining to linking.

	Iid_ole_object: STRING is "{00000112-0000-0000-C000-000000000046}"
			-- Principal means by which embedded object provides basic 
			-- functionality to, and communicates with, its container.

	Iid_ole_window: STRING is "{00000114-0000-0000-C000-000000000046}"
			-- Obtain handle to various windows that participate in in-place  
			-- activation, and to enter and exit context-sensitive help mode.

	Iid_parse_display_name: STRING is "{0000011A-0000-0000-C000-000000000046}"
			-- Parse displayable name string to convert it into moniker
			-- for custom moniker implementations.

	Iid_per_property_browsing: STRING is "{376BD3AA-3845-101b-84ED-08002B2EC713}"
			-- Access information in property pages offered by object.

	Iid_persist: STRING is "{0000010C-0000-0000-C000-000000000046}"
			-- Supply CLSID of object that can be stored persistently in system.

	Iid_persist_file: STRING is "{0000010B-0000-0000-C000-000000000046}"
			-- Permit object to be loaded from or saved to disk file, 
			-- rather than storage object or stream. 

	Iid_persist_storage: STRING is "{0000010A-0000-0000-C000-000000000046}"
			-- Enable container application to pass storage object to one
			-- of its contained objects and to load and save storage object. 

	Iid_persist_stream: STRING is "{00000109-0000-0000-C000-000000000046}"
			-- Save and load objects that use simple serial stream for their 
			-- storage needs.

	Iid_persist_stream_init: STRING is "{7FD52380-4E07-101b-AE2D-08002B2EC713}"
			-- Replace IPersistStream in order to add initialization method.

	Iid_property_notify_sink: STRING is "{9BFBBC02-EFF1-101A-84ED-00AA00341D07}"
			-- Implemented by sink object to receive notifications about 
			-- property changes from object that supports Iid_property_notify_sink 
			-- as outgoing interface.

	Iid_property_page: STRING is "{B196B28D-BAB4-101A-B69C-00AA00341D07}"
			-- Provide main features of property page object that manages 
			-- particular page within property sheet.

	Iid_property_page2: STRING is "{01E44665-24AC-101b-84ED-08002B2EC713}"
			-- Extend Iid_property_page to support initial selection of property on page. 

	Iid_property_page_site: STRING is "{B196B28C-BAB4-101A-B69C-00AA00341D07}"
			-- Provide main features for property page site object.

	Iid_provide_class_info: STRING is "{B196B283-BAB4-101A-B69C-00AA00341D07}"
			-- Provide single method for accessing type information for object’s 
			-- coclass entry in its type library. 

	Iid_ps_factory: STRING is "{00000009-0000-0000-C000-000000000046}"
			-- Create proxies and stubs.

	Iid_root_storage: STRING is "{00000012-0000-0000-C000-000000000046}"
			-- Contain single method that switches storage object to different
			-- underlying file and saves storage object to that file.

	Iid_rot_data: STRING is "{F29F6BC0-5021-11ce-AA15-00006901293F}"
			-- Enable Running Object Table (ROT) to compare monikers against each other. 

	Iid_rpc_channel_buffer: STRING is "{D5F56B60-593B-101A-B569-08002B2DBF7A}"
			-- Interface through which interface proxies send calls 
			-- through to corresponding interface stub.

	Iid_rpc_proxy_buffer: STRING is "{D5F56A34-593B-101A-B569-08002B2DBF7A}"
			-- Interface by which client-side infrastructure talks to interface
			-- proxy instances that it manages.

	Iid_rpc_stub_buffer: STRING is "{D5F56AFC-593B-101A-B569-08002B2DBF7A}"
			-- Interface used on server side by RPC runtime infrastructure to 
			-- communicate with interface stubs that it dynamically loads into 
			-- server process.

	Iid_runnable_object: STRING is "{00000126-0000-0000-C000-000000000046}"
			-- Enable container to control running of its embedded objects.

	Iid_running_object_table: STRING is "{00000010-0000-0000-C000-000000000046}"
			-- Manage access to Running Object Table (ROT). 

	Iid_simple_frame_site: STRING is "{742B0E01-14E6-101b-914E-00AA00300CAB}"
			-- Support simple frame controls that act as simple containers
			-- for other nested controls. 

	Iid_specify_property_pages: STRING is "{B196B28B-BAB4-101A-B69C-00AA00341D07}"
			-- Indicate that object supports property pages.

	Iid_std_marshal_info: STRING is "{00000018-0000-0000-C000-000000000046}"
			-- Return CLSID identifying handler to be used in destination 
			-- process during standard marshaling. 

	Iid_storage: STRING is "{0000000B-0000-0000-C000-000000000046}"
			-- Support creation and management of structured storage objects.

	Iid_stream: STRING is "{0000000C-0000-0000-C000-000000000046}"
			-- Support reading and writing data to stream objects.

	Iid_support_error_info: STRING is "{DF0B3D60-548F-101b-8E65-08002B2BD119}"
			-- Ensure that error information can be propagated up 
			-- call chain correctly.

	Iid_type_comp: STRING is "{00020403-0000-0000-C000-000000000046}"
			-- Provide fast way to access information that compilers 
			-- need when binding to and instantiating structures
			-- and interfaces.

	Iid_type_info: STRING is "{00020401-0000-0000-C000-000000000046}"
			-- Used for reading information about objects.

	Iid_type_lib: STRING is "{00020402-0000-0000-C000-000000000046}"
			-- Interface to a type library.

	Iid_unknown: STRING is "{00000000-0000-0000-C000-000000000046}"
			-- Let clients get pointers to other interfaces on a given
			-- object, and manage the existence of the object.

	Iid_view_object: STRING is "{0000010D-0000-0000-C000-000000000046}"
			-- Enable object to display itself directly without passing
			-- data object to the caller.

	Iid_view_object2: STRING is "{00000127-0000-0000-C000-000000000046}"
			-- Extend IViewObject interface to return size of drawing
			-- for given view of object. 

	Iid_enum_formatetc: STRING is "{00000103-0000-0000-C000-000000000046}"
			-- Enumerate array of EOLE_FORMATETEC.

	Iid_enum_moniker: STRING is "{00000102-0000-0000-C000-000000000046}"
			-- Enumerate components of moniker or monikers in table of monikers.

	Iid_enum_oleverb: STRING is "{00000104-0000-0000-C000-000000000046}"
			-- Enumerate different verbs available for object in order
			-- of ascending verb number. 

	Iid_enum_statdata: STRING is "{00000105-0000-0000-C000-000000000046}"
			-- Enumerate through array of EOLE_STATDATA, 
			-- which contain advisory connection information for data object.

	Iid_enum_statstg: STRING is "{0000000D-0000-0000-C000-000000000046}"
			-- Enumerate through array of EOLE_STATSTG, 
			-- which contain statistical information about open storage,
			-- stream, or byte array object.

	Iid_enum_variant: STRING is "{00020404-0000-0000-C000-000000000046}"
			-- Enumerate collection of variants, including heterogeneous
			-- collections of objects and intrinsic types. 

	Iid_enum_unknown: STRING is "{00000100-0000-0000-C000-000000000046}"
			-- Enumerate objects with IUnknown interface.

	Iid_enum_connection_points: STRING is "{B196B285-BAB4-101A-B69C-00AA00341D07}"
			-- Enumerate connection points.

	Iid_enum_connections: STRING is "{B196B287-BAB4-101A-B69C-00AA00341D07}"
			-- Enumerate current connections for connectable object.

	Iid_font: STRING is "{BEF6E002-A874-101A-8BBA-00AA00300CAB}"
			-- Wrapper around Windows font object.

	Iid_font_disp: STRING is "{BEF6E003-A874-101A-8BBA-00AA00300CAB}"
			-- Expose font object’s properties through Automation.

	Iid_picture: STRING is "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
			-- Manage picture object and its properties.

	Iid_picture_disp: STRING is "{7BF80981-BF32-101A-8BBB-00AA00300CAB}"
			-- Expose picture object’s properties through Automation.

end -- class EOLE_INTERFACE_IDENT

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
