class
	DATA

feature

	creation_objects_anchor: TUPLE
		do
			check False then end
		ensure
			do_not_call: False
		end

	creation_objects_proxy_anchor: TUPLE
		do
			check False then end
		ensure
			do_not_call: False
		end

end
