indexing
	description: "Proxy of OLE control."
	date: "$Date$"
	revision: "$Revision$"
	
class
	OLE_CONTROL_PROXY

inherit
	DVASPECT_ENUM
		export
			{NONE} all
		end

feature -- Access

	unknown_control: ECOM_INTERFACE
	
	dispatch: ECOM_AUTOMATION_INTERFACE is
			-- IDispatch interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_dispatch = Void then
					create m_dispatch.make_from_other (unknown_control)
				end
				Result := m_dispatch
			end
		rescue
			retried := True
			retry
		end

	quick_activate: IQUICK_ACTIVATE_IMPL_PROXY is
			-- IQuickActivate interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_quick_activate = Void then
					create m_quick_activate.make_from_other (unknown_control)
				end
				Result := m_quick_activate
			end
		rescue
			retried := True
			retry
		end
			
	ole_object: IOLE_OBJECT_IMPL_PROXY is
			-- IOleObject interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_object = Void then
					create m_ole_object.make_from_other (unknown_control)
				end
				Result := m_ole_object
			end
		rescue
			retried := True
			retry
		end

	object_with_site: IOBJECT_WITH_SITE_IMPL_PROXY is
			-- IObjectWithSite interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_object_with_site = Void then
					create m_object_with_site.make_from_other (unknown_control)
				end
				Result := m_object_with_site
			end
		rescue
			retried := True
			retry
		end

	persist_memory: IPERSIST_MEMORY_IMPL_PROXY is
			-- IPersistMemory interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_persist_memory = Void then
					create m_persist_memory.make_from_other (unknown_control)
				end
				Result := m_persist_memory
			end
		rescue
			retried := True
			retry
		end

	persist_stream_init: IPERSIST_STREAM_INIT_IMPL_PROXY is
			-- IPersistStreamInit interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_persist_stream_init = Void then
					create m_persist_stream_init.make_from_other (unknown_control)
				end
				Result := m_persist_stream_init
			end
		rescue
			retried := True
			retry
		end

	ole_control: IOLE_CONTROL_IMPL_PROXY is
			-- IOleControl interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_control = Void then
					create m_ole_control.make_from_other (unknown_control)
				end
				Result := m_ole_control
			end
		rescue
			retried := True
			retry
		end
			
	ole_in_place_object: IOLE_IN_PLACE_OBJECT_IMPL_PROXY is
			-- IOleInPlaceObject interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_in_place_object = Void then
					create m_ole_in_place_object.make_from_other (unknown_control)
				end
				Result := m_ole_in_place_object
			end
		rescue
			retried := True
			retry
		end

	ole_in_place_object_windowless: IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_PROXY is
			-- IOleInPlaceObjectWindowless interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_in_place_object_windowless = Void then
					create m_ole_in_place_object_windowless.make_from_other (unknown_control)
				end
				Result := m_ole_in_place_object_windowless
			end
		rescue
			retried := True
			retry
		end

	ole_in_place_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_IMPL_PROXY is
			-- IOleInPlaceActiveObject interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_in_place_active_object = Void then
					create m_ole_in_place_active_object.make_from_other (unknown_control)
				end
				Result := m_ole_in_place_active_object
			end
		rescue
			retried := True
			retry
		end

	ole_cache: IOLE_CACHE_IMPL_PROXY is
			-- IOleCache interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_ole_cache = Void then
					create m_ole_cache.make_from_other (unknown_control)
				end
				Result := m_ole_cache
			end
		rescue
			retried := True
			retry
		end

	view_object: IVIEW_OBJECT_IMPL_PROXY is
			-- IViewObject interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_view_object = Void then
					create m_view_object.make_from_other (unknown_control)
				end
				Result := m_view_object
			end
		rescue
			retried := True
			retry
		end

	view_object2: IVIEW_OBJECT2_IMPL_PROXY is
			-- IViewObject2 interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_view_object2 = Void then
					create m_view_object2.make_from_other (unknown_control)
				end
				Result := m_view_object2
			end
		rescue
			retried := True
			retry
		end

	view_object_ex: IVIEW_OBJECT_EX_IMPL_PROXY is
			-- IViewObjectEx interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_view_object_ex = Void then
					create m_view_object_ex.make_from_other (unknown_control)
				end
				Result := m_view_object_ex
			end
		rescue
			retried := True
			retry
		end

	data_object: IDATA_OBJECT_IMPL_PROXY is
			-- IDataObject interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_data_object = Void then
					create m_data_object.make_from_other (unknown_control)
				end
				Result := m_data_object
			end
		rescue
			retried := True
			retry
		end

	persist_property_bag: IPERSIST_PROPERTY_BAG_IMPL_PROXY is
			-- IPersistPropertyBag interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_persist_property_bag = Void then
					create m_persist_property_bag.make_from_other (unknown_control)
				end
				Result := m_persist_property_bag
			end
		rescue
			retried := True
			retry
		end

	specify_property_pages: ISPECIFY_PROPERTY_PAGES_IMPL_PROXY is
			-- ISpecifyPropertyPages interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_specify_property_pages = Void then
					create m_specify_property_pages.make_from_other (unknown_control)
				end
				Result := m_specify_property_pages
			end
		rescue
			retried := True
			retry
		end

	per_property_browsing: IPER_PROPERTY_BROWSING_IMPL_PROXY is
			-- IPerPropertyBrowsing interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_per_property_browsing = Void then
					create m_per_property_browsing.make_from_other (unknown_control)
				end
				Result := m_per_property_browsing
			end
		rescue
			retried := True
			retry
		end

	persist: IPERSIST_IMPL_PROXY is
			-- IPersist interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_persist = Void then
					create m_persist.make_from_other (unknown_control)
				end
				Result := m_persist
			end
		rescue
			retried := True
			retry
		end

	persist_storage: IPERSIST_STORAGE_IMPL_PROXY is
			-- IPersistStorage interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if m_persist_storage = Void then
					create m_persist_storage.make_from_other (unknown_control)
				end
				Result := m_persist_storage
			end
		rescue
			retried := True
			retry
		end

feature -- Basic Operations

	release_all is
			-- Release all interfaces.
		do
			if 
				unknown_control /= Void and then
				view_object /= Void 
			then
				view_object.set_advise (Dvaspect_content, 0, Void)
			end
			-- Unadvise on IAdviseSink here
			-- TODO
			if 
				unknown_control /= Void and then
				ole_object /= Void 
			then
				
			end
			unknown_control := Void
			m_dispatch := Void
			m_quick_activate := Void	
			m_ole_object := Void
			m_object_with_site := Void
			m_persist_memory := Void
			m_persist_stream_init := Void
			m_ole_control := Void
			m_ole_in_place_object := Void
			m_ole_in_place_object_windowless := Void
			m_ole_in_place_active_object := Void
			m_ole_cache := Void
			m_view_object := Void
			m_view_object2 := Void
			m_view_object_ex := Void
			m_data_object := Void
			m_persist_property_bag := Void
			m_specify_property_pages := Void
			m_per_property_browsing := Void
			m_persist := Void
			m_persist_storage := Void
		end
		
feature {NONE} -- Implementation

	m_dispatch: ECOM_AUTOMATION_INTERFACE 
			-- IDispatch interface of control.

	m_quick_activate: IQUICK_ACTIVATE_IMPL_PROXY 
			-- IQuickActivate interface of control.
			
	m_ole_object: IOLE_OBJECT_IMPL_PROXY 
			-- IOleObject interface of control.

	m_object_with_site: IOBJECT_WITH_SITE_IMPL_PROXY
			-- IObjectWithSite interface of control.
	
	m_persist_memory: IPERSIST_MEMORY_IMPL_PROXY
			-- IPersistMemory interface of control.

	m_persist_stream_init: IPERSIST_STREAM_INIT_IMPL_PROXY
			-- IPersistStreamInit interface of control.

	m_ole_control: IOLE_CONTROL_IMPL_PROXY
			-- IOleControl interface of control.
			
	m_ole_in_place_object: IOLE_IN_PLACE_OBJECT_IMPL_PROXY
			-- IOleInPlaceObject interface of control.

	m_ole_in_place_object_windowless: IOLE_IN_PLACE_OBJECT_WINDOWLESS_IMPL_PROXY
			-- IOleInPlaceObjectWindowless interface of control.

	m_ole_in_place_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_IMPL_PROXY
			-- IOleInPlaceActiveObject interface of control.

	m_ole_cache: IOLE_CACHE_IMPL_PROXY
			-- IOleCache interface of control.

	m_view_object: IVIEW_OBJECT_IMPL_PROXY
			-- IViewObject interface of control.

	m_view_object2: IVIEW_OBJECT2_IMPL_PROXY
			-- IViewObject2 interface of control.

	m_view_object_ex: IVIEW_OBJECT_EX_IMPL_PROXY
			-- IViewObjectEx interface of control.

	m_data_object: IDATA_OBJECT_IMPL_PROXY
			-- IDataObject interface of control.

	m_persist_property_bag: IPERSIST_PROPERTY_BAG_IMPL_PROXY
			-- IPersistPropertyBag interface of control.

	m_specify_property_pages: ISPECIFY_PROPERTY_PAGES_IMPL_PROXY
			-- ISpecifyPropertyPages interface of control.

	m_per_property_browsing: IPER_PROPERTY_BROWSING_IMPL_PROXY
			-- IPerPropertyBrowsing interface of control.

	m_persist: IPERSIST_IMPL_PROXY
			-- IPersist interface of control.

	m_persist_storage: IPERSIST_STORAGE_IMPL_PROXY
			-- IPersistStorage interface of control.

end -- class OLE_CONTROL_PROXY
