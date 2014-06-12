class TEST1 [OBJ -> PROXY_PROXIABLE_DATA_IDENTIFIED, V -> BASE_OBJECT_VIEW [ANY, OBJ]]

	
feature

	view: detachable V

	store: like view.store
		do
		end

end
