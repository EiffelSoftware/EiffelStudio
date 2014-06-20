deferred class TEST2 [M -> PARENT]
feature
	new_creation_objects: like {M}.creation_objects_proxy_anchor
			-- Objects necessary for new list object.
		do
			create Result
		end
end
