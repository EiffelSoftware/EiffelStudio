class
	TEST

create
	make

feature -- Initialization

	make is
		do
		end

	test: B [TUPLE [name: STRING; value: STRING]]
		local
			l_result: A [TUPLE [STRING, STRING]]
		do
			Result := ({B [TUPLE [STRING, STRING]]}) [({A [TUPLE [STRING, STRING]]}) [l_result]]
			Result := ({A [TUPLE [name: STRING; value: STRING]]}) [l_result]
			Result := l_result
		end

end
