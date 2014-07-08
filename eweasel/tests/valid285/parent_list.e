deferred class
	PARENT_LIST [M -> PROXIABLE_DATA]

feature

	new_creation_objects: like {M}.creation_objects_proxy_anchor
		do
			check False then end
		end

end
