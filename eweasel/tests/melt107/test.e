class TEST

create
	make

feature {NONE} -- Creation
	
	make
		local
			l_type: TYPE [detachable ANY]
		do
			l_type := {detachable ANY}
			if not l_type.has_default or else l_type.default /= Void then
				io.put_string ("Not OK%N")
			end
		end

	$NEW_TYPE

end
