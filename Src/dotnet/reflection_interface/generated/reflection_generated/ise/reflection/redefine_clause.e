indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "REDEFINE_CLAUSE"

deferred external class
	REDEFINE_CLAUSE

inherit
	INHERITANCE_CLAUSE

feature -- Basic Operations

	redefine_keyword: STRING is
		external
			"IL deferred signature (): STRING use REDEFINE_CLAUSE"
		alias
			"redefine_keyword"
		end

end -- class REDEFINE_CLAUSE
