class BODY_MERGER

feature

--	merge_comments (old_tmp, user, new_tmp: BODY_AS) is
--		local
--			content_merger: CONTENT_MERGER
--		do
--		end;

	merge3 (old_tmp, user, new_tmp: BODY_AS) is
			-- Merge bodies `old_tmp', `user' and `new_tmp'.
		local
			old_tmp_content: CONTENT_AS;
			arguments_merger: ARGUMENTS_MERGER;
			content_merger: CONTENT_MERGER
		do
			!! merge_result

			-- First merge arguments of `user' and
			-- `new_tmp'. `old_tmp' will not be taken
			-- in consideration.
			!! arguments_merger;
			arguments_merger.merge2 (user.arguments, new_tmp.arguments)

			merge_result.set_arguments (arguments_merger.merge_result)
			merge_result.set_type (new_tmp.type)

			if old_tmp /= Void then
				old_tmp_content := old_tmp.content
			end

debug ("MERGER")
	io.error.putstring ("%Tcontent: ");
end;

			-- Now merge contents
			!! content_merger;
			content_merger.merge3 (old_tmp_content, user.content, new_tmp.content)
			merge_result.set_content (content_merger.merge_result)

debug ("MERGER")
	io.error.putstring ("finished content%N");
end;
		end;

	merge_result: BODY_AS

end -- class BODY_MERGER
