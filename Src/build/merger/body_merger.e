class BODY_MERGER

feature

	merge_comments (b1, b2, b3: BODY_AS) is
		local
			content_merger: CONTENT_MERGER
		do
		end;

	merge3 (b1, b2, b3: BODY_AS) is
			-- Merge bodies `b1', `b2' and `b3'.
		local
			b1_content: CONTENT_AS;
			arguments_merger: ARGUMENTS_MERGER;
			content_merger: CONTENT_MERGER
		do
			!! merge_result

			!! arguments_merger;
			arguments_merger.merge2 (b2.arguments, b3.arguments)

			merge_result.set_arguments (arguments_merger.merge_result)
			merge_result.set_type (b3.type)

			if b1 /= Void then
				b1_content := b1.content
			end

			debug ("MERGER")
				io.error.putstring ("%Tcontent: ");
			end;
			!! content_merger;
			content_merger.merge3 (b1_content, b2.content, b3.content)
			merge_result.set_content (content_merger.merge_result)
			debug ("MERGER")
				io.error.putstring ("finished content%N");
			end;
		end;

	merge_result: BODY_AS

end -- class BODY_MERGER
