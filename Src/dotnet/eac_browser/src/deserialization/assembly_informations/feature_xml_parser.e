class
	FEATURE_XML_PARSER

inherit
	XML_PARSER
		redefine
			on_start_tag,
			on_content,
			on_end_tag,
			on_default
		end

	TAG_FLAGS

creation
	make

feature -- Access

	members_information: HASH_TABLE [MEMBER_INFORMATION, STRING] is
			-- Members classified by signature.
		once
			create Result.make (50)
		ensure
			non_void_result: Result /= Void
		end

	a_member: MEMBER_INFORMATION is
			-- Temporary attribute.
		once
			create Result.make
		ensure
			non_void_result: Result /= Void
		end
	
	a_parameter: PARAMETER_INFORMATION  is
			-- Temporary attribute.
		once
			create Result.make
		ensure
			non_void_result: Result /= Void
		end
		
	a_temporary_string: CELL [STRING] is
		once
			create Result.put (create {STRING}.make_empty)
		ensure
			non_void_result: Result /= Void
		end
		
	current_tag: ARRAYED_STACK [INTEGER]
			-- Balises XML opened.

	paragraphe_tag: STRING is "<PARA>"

feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		local
			l_name: STRING
			l_attribute: STRING
			l_column, l_line, l_byte: INTEGER
		do
--			print (start_tag.out)
			if start_tag.name.is_equal (see_str) then
				if start_tag.attributes.count > 0 then
					l_attribute := start_tag.attributes.first.value
					if l_attribute.item (2).is_equal (':') then
							-- Is it a reference to a Type or a Method?
						l_attribute.keep_tail (l_attribute.count - 2)
					end
					a_temporary_string.item.append (l_attribute)
				end
				current_tag.put (see)
			elseif start_tag.name.is_equal (para_str) then
				current_tag.put (para)
			elseif start_tag.name.is_equal (param_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					A_parameter.set_name (l_name)
				end
				a_temporary_string.item.wipe_out
				current_tag.put (param)
			elseif start_tag.name.is_equal (returns_str) then
				a_temporary_string.item.wipe_out
				current_tag.put (returns)
			elseif start_tag.name.is_equal (summary_str) then
				a_temporary_string.item.wipe_out
				current_tag.put (summary)
			elseif start_tag.name.is_equal (member_str) then
				A_member.name.wipe_out
				A_member.summary.wipe_out
				A_member.parameters.wipe_out
				A_member.returns.wipe_out
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					l_name.keep_tail (l_name.count - 2)
					A_member.set_name (l_name)
				end
				if current_tag = Void then
					create current_tag.make (10)
				end
				current_tag.put (member)
			elseif start_tag.name.is_equal (param_ref_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					a_temporary_string.item.append (l_name)
				end
				current_tag.put (param_ref)
--			elseif start_tag.name.is_equal (members_str) then
--				current_tag.put (members)
--			elseif start_tag.name.is_equal (name_str) then
--				current_tag.put (name)
--			elseif start_tag.name.is_equal (assembly_str) then
--				current_tag.put (assembly)
--			elseif start_tag.name.is_equal (doc_str) then
--				create current_tag.make (10)
--				current_tag.put (doc)
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
				a_temporary_string.item.append (content.out)
			when Summary then
				a_temporary_string.item.append (content.out)
			when returns then
				a_temporary_string.item.append (content.out)
			else
				a_temporary_string.item.append (content.out)	
			end
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		local
			l_str: STRING
		do
--			print (end_tag.out)
--			l_str := clone (a_temporary_string.item)
--			l_str.replace_substring_all ("%N", "")
--			l_str.replace_substring_all ("   ", " ")
--			l_str.replace_substring_all ("  ", " ")
			inspect 
				current_tag.item
			when Para then
				a_temporary_string.item.append (paragraphe_tag)
			when Param then
				l_str := format_comment (a_temporary_string.item)
				a_parameter.set_description (l_str)
				a_member.add_parameter (deep_clone (a_parameter))
			when Summary then
				l_str := format_comment (a_temporary_string.item)
				a_member.set_summary (l_str)
			when Returns then
				l_str := format_comment (a_temporary_string.item)
				a_member.set_returns (l_str)
			when Member then
				members_information.put (deep_clone (a_member), clone (a_member.name))
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
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("  ", " ")
			Result.replace_substring_all (paragraphe_tag, "%N")
		end
		

end -- class FEATURE_XML_PARSER
