indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RENAME_CLAUSE"

deferred external class
	RENAME_CLAUSE

inherit
	INHERITANCE_CLAUSE

feature -- Basic Operations

	empty_string: STRING is
		external
			"IL deferred signature (): STRING use RENAME_CLAUSE"
		alias
			"empty_string"
		end

	as_keyword: STRING is
		external
			"IL deferred signature (): STRING use RENAME_CLAUSE"
		alias
			"as_keyword"
		end

	a_set_target_name (target_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use RENAME_CLAUSE"
		alias
			"_set_target_name"
		end

	target_name: STRING is
		external
			"IL deferred signature (): STRING use RENAME_CLAUSE"
		alias
			"target_name"
		end

	rename_keyword: STRING is
		external
			"IL deferred signature (): STRING use RENAME_CLAUSE"
		alias
			"rename_keyword"
		end

	set_target_name (a_target_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use RENAME_CLAUSE"
		alias
			"set_target_name"
		end

	space: STRING is
		external
			"IL deferred signature (): STRING use RENAME_CLAUSE"
		alias
			"space"
		end

end -- class RENAME_CLAUSE
