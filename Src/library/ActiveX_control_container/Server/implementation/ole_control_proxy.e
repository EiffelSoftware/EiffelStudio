indexing
	description: "Proxy of OLE control."
	date: "$Date$"
	revision: "$Revision$"
	
class
	OLE_CONTROL_PROXY
	
feature -- Access

	unknown_control: ECOM_INTERFACE
	
	quick_activate: IQUICK_ACTIVATE_IMPL_PROXY is
			-- IQuickActivate interface of control.
		require
			non_void_control_unknown: unknown_control /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
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
				create Result.make_from_other (unknown_control)
			end
		rescue
			retried := True
			retry
		end

end -- class OLE_CONTROL_PROXY
