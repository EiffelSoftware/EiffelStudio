class
	FEATURE_XML_PARSER

inherit
	XML_PARSER
		redefine
			make,
			on_start_tag,
			on_content,
			on_end_tag,
			on_default
		end

	TAG_FLAGS

creation
	make
	
feature -- Initialization

	make is
			-- Initialization.
		do
			Precursor {XML_PARSER}
			create a_member.make
			create a_parameter.make
			create current_comment.make_empty
			create current_tag.make (10)
		ensure
			non_void_a_member: a_member /= Void
			non_void_a_parameter: a_parameter /= Void
			non_void_current_comment: current_comment /= Void
			non_void_current_tag: current_tag /= Void
		end
		

feature -- Access

	a_member: MEMBER_INFORMATION
			-- Temporary attribute.


feature {NONE} -- Access
	
	a_parameter: PARAMETER_INFORMATION
			-- Temporary attribute.

	current_comment: STRING
			-- Current comment.
		
	current_tag: ARRAYED_STACK [INTEGER]
			-- Balises XML opened.

	paragraphe_tag: STRING is "<PARA>"

feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		local
			l_name: STRING
			l_attribute: STRING
		do
--			print (start_tag.out)
			if start_tag.name.is_equal (see_str) then
				if start_tag.attributes.count > 0 then
					l_attribute := start_tag.attributes.first.value
					if l_attribute.item (2).is_equal (':') then
							-- Is it a reference to a Type or a Feature (M: or P: etc)?
						l_attribute.keep_tail (l_attribute.count - 2)
					end
					current_comment.append (l_attribute)
				end
				current_tag.put (see)
			elseif start_tag.name.is_equal (para_str) then
				current_tag.put (para)
			elseif start_tag.name.is_equal (param_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					A_parameter.set_name (l_name)
				end
				current_comment.wipe_out
				current_tag.put (param)
			elseif start_tag.name.is_equal (returns_str) then
				current_comment.wipe_out
				current_tag.put (returns)
			elseif start_tag.name.is_equal (summary_str) then
				current_comment.wipe_out
				current_tag.put (summary)
			elseif start_tag.name.is_equal (member_str) then
				A_member.reset
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					l_name.keep_tail (l_name.count - 2)
					A_member.set_name (l_name)
				end
				current_tag.put (member)
			elseif start_tag.name.is_equal (param_ref_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					current_comment.append (l_name)
				end
				current_tag.put (param_ref)
			else
				if current_tag = Void then
					create current_tag.make (10)
				end
				-- Unknow tag...
				current_tag.put (Unknow)
			end
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		do
--			print (content.out)
			inspect 
				current_tag.item
			when param then
				current_comment.append (content.out)
			when Summary then
				current_comment.append (content.out)
			when returns then
				current_comment.append (content.out)
			else
				current_comment.append (content.out)	
			end
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		local
			l_str: STRING
		do
--			print (end_tag.out)
			inspect 
				current_tag.item
--			when Para then
--				current_comment.append (paragraphe_tag)
			when Param then
				l_str := format_comment (current_comment)
				a_parameter.set_description (l_str)
				a_member.add_parameter (deep_clone (a_parameter))
			when Summary then
				l_str := format_comment (current_comment)
				a_member.set_summary (l_str)
			when Returns then
				l_str := format_comment (current_comment)
				a_member.set_returns (l_str)
			else
			end
			current_tag.remove
		end

	on_default (data: XML_CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler
		do
		end
		
feature -- Basic Operation

	format_comment (a_comment: STRING): STRING is
			-- format `a_comment'.
		require
			non_void_a_comment: a_comment /= Void
			not_empty_a_comment: not a_comment.is_empty
		do
			Result := clone (a_comment)
			Result.replace_substring_all ("%N", "")
			Result.prune_all_leading (' ')
			Result.prune_all_trailing (' ')
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("  ", " ")
			Result.replace_substring_all (paragraphe_tag, "%N")
		end


invariant
	non_void_a_member: a_member /= Void
	non_void_a_parameter: a_parameter /= Void
	non_void_current_comment: current_comment /= Void
	non_void_current_tag: current_tag /= Void
	

end -- class FEATURE_XML_PARSER
