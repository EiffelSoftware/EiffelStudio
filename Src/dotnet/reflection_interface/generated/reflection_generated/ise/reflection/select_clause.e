indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SELECT_CLAUSE"

deferred external class
	SELECT_CLAUSE

inherit
	INHERITANCE_CLAUSE

feature -- Basic Operations

	select_keyword: STRING is
		external
			"IL deferred signature (): STRING use SELECT_CLAUSE"
		alias
			"select_keyword"
		end

end -- class SELECT_CLAUSE
