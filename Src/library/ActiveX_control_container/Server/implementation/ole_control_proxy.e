indexing
	description: "Proxy of OLE control."
	date: "$Date$"
	revision: "$Revision$"
	
class
	OLE_CONTROL_PROXY
	
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
				Result := m_dispatch
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_quick_activate
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_object
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_persist_memory
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_persist_stream_init
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_control
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_in_place_object
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_in_place_object_windowless
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_in_place_active_object
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_ole_cache
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_view_object
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_view_object2
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_view_object_ex
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_data_object
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_persist_property_bag
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_specify_property_pages
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_per_property_browsing
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_persist
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
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
				Result := m_persist_storage
				if Result = Void then
					create Result.make_from_other (unknown_control)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	m_dispatch: ECOM_AUTOMATION_INTERFACE 
			-- IDispatch interface of control.

	m_quick_activate: IQUICK_ACTIVATE_IMPL_PROXY 
			-- IQuickActivate interface of control.
			
	m_ole_object: IOLE_OBJECT_IMPL_PROXY 
			-- IOleObject interface of control.

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
