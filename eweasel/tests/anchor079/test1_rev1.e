class TEST1 [OBJ -> PROXY_PROXIABLE_DATA_IDENTIFIED, V -> BASE_OBJECT_VIEW [ANY, OBJ]]

	
feature

	view: detachable V

	store: like view.store
		do
			check attached_store: attached view as l_v and then attached l_v.store as l_store then
				Result := l_store
			end
		end

end
