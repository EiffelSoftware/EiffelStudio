class FLAT_CONTEXT

feature

	builder: SPECIAL_PARSER;

	set_builder (b: like builder) is
		require
			valid_b: b /= Void
		do
			builder := b;
		end;

	trailing_comment, trailing_comment_before (position: INTEGER): EIFFEL_COMMENTS is
		do
			if builder.comments_server /= void then
				builder.comments_server.go_before (position + 1);
				Result := builder.comments_server.trailing_comment;
			end;
		end;

	trailing_comment_after (position: INTEGER): EIFFEL_COMMENTS is
		do
			if builder.comments_server /= void then
				builder.comments_server.go_after (position);
				Result := builder.comments_server.trailing_comment;
			end;
		end;

	new_adapter: FEAT_ADAPTATION is
		do
			Result := builder.new_adapter;
		end;

	processed_features: LINKED_LIST [INTEGER] is
		do
			Result := builder.processed_features;
		end;

	--assert_server: ASSERT_SERVER is
	--	do
	--		Result := builder.assert_server;
	--	end;

	clear is
			-- Clear Current context.
		do
			builder := Void
		end

end
