indexing
	description: "Wrapper of an EIFFEL_LIST object, used by roundtrip"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LIST_WRAPPER_AS [ G -> EIFFEL_LIST [AST_EIFFEL]]

feature -- Content

	meaningful_content: G is
			-- Meaningful `content'.
			-- If `content' is not void and content is not empty,
			-- `meaningful_content' is attached to `content', otherwise Void.
		do
			Result := content
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		ensure
			good_result: valid_meaningful_content (Result)
		end

	content: G
			-- Wrapped EIFFEL_LIST

feature -- Status reporting

	valid_meaningful_content (a_meaningful_content: like meaningful_content): BOOLEAN is
			-- Is `a_meaningful_content' valid?
		do
			if content /= Void and then not content.is_empty then
				Result := a_meaningful_content = content
			else
				Result := a_meaningful_content = Void
			end
		end

end
