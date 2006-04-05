indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ASSEMBLY_XML_PARSER

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

--	infos: ASSEMBLY_INFORMATION is
--			-- My doc deserialized.
--		once
--			create Result.make
--		ensure
--			non_void_result: Result /= Void
--		end

	members_information: HASH_TABLE [MEMBER_INFORMATION, STRING] is
			-- Members classified by signature.
		once
			create Result.make (10000)
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


feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element.
		local
			l_name: STRING
			l_ref: STRING
		do
			if start_tag.name.is_equal (see_str) then
				if start_tag.attributes.count > 0 then
					l_ref := start_tag.attributes.first.value
					--l_ref.keep_tail (l_ref.count - 2)
					a_temporary_string.item.append (l_ref)
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
				A_member.parameters.wipe_out
				A_member.summary.wipe_out
				A_member.returns.wipe_out
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					A_member.set_name (l_name)
				end
				current_tag.put (member)
			elseif start_tag.name.is_equal (param_ref_str) then
				if start_tag.attributes.count > 0 then
					l_name := start_tag.attributes.first.value
					a_temporary_string.item.append (l_name)
				end
				current_tag.put (param_ref)
			elseif start_tag.name.is_equal (members_str) then
				current_tag.put (members)
			elseif start_tag.name.is_equal (name_str) then
				current_tag.put (name)
			elseif start_tag.name.is_equal (assembly_str) then
				current_tag.put (assembly)
			elseif start_tag.name.is_equal (doc_str) then
				create current_tag.make (10)
				current_tag.put (doc)
			else
				-- Unknow tag...			
				current_tag.put (Unknow)
			end
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data.
		do
			inspect 
				current_tag.item
			when para then
				a_temporary_string.item.append (content.out)
			when Param then
				a_temporary_string.item.append (content.out)
			when Summary then
				a_temporary_string.item.append (content.out)
			when Returns then
				a_temporary_string.item.append (content.out)
--			when Unknow then
--				a_temporary_string.item.append (content.out)
			else
				
			end
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element.
		local
			l_str: STRING
		do
			l_str := clone (a_temporary_string.item)
			l_str.replace_substring_all ("%N", "")
			inspect 
				current_tag.item
			when Param then
				a_parameter.set_description (l_str)
				a_member.add_parameter (deep_clone (a_parameter))
			when Summary then
				a_member.set_summary (l_str)
			when Returns then
				a_member.set_returns (l_str)
			when Member then
				members_information.put (deep_clone (a_member), clone (a_member.name))
			else
			end
			current_tag.remove
		end

	on_default (data: XML_CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ASSEMBLY_XML_PARSER
