indexing
	description: "MIDL feature"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_FEATURE

inherit
	EI_FEATURE

	WIZARD_LANGUAGES_KEYWORDS
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS

create
	make

feature -- Output

	code: STRING is
			-- Code output
		local
			l_comment: STRING
		do
			Result := ("%T%(helpstring (%"")

			l_comment := clone (comment)
			l_comment.prune_all ('%N')
			l_comment.prune_all ('%"')

			Result.append (l_comment)
			Result.append ("%")%) %N%T%THRESULT ")

			Result.append (name)
			Result.append (Space_open_parenthesis)

			if not parameters.is_empty then

				from
					parameters.start
				until
					parameters.after
				loop
					Result.append (parameters.item.code)
					Result.append (Comma_space)
					parameters.forth
				end

				if result_type.is_empty then
					Result.remove (Result.count)
					Result.remove (Result.count)
				end

			end

			if not result_type.is_empty then
				Result.append (Open_bracket)
				Result.append (Out_retval)
				Result.append (Close_bracket)
				Result.append (result_type)
				Result.append (" * ")
				Result.append (Return_value_variable_name)
			end

			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

end -- class EI_MIDL_FEATURE
