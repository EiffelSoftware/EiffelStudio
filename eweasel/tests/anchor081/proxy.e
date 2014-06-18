class PROXY
feature
	proxy: detachable PROXY

	creation_objects: TUPLE
		do
			check False then end
		end 

	current_anchor: detachable like Current

	new_proxy: detachable PROXY

end
