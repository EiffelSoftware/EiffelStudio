indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	FEATURE_FILTER

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_start_tag,
			on_attribute,
			on_content,
			on_end_tag
		end

	TAG_FLAGS

create
	make
	
feature -- Initialization

	make is
			-- Initialization.
		do
			create a_member.make
			create a_parameter.make
			create current_comment.make_empty
			create current_tag.make (10)
		ensure then
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

	current_tag: ARRAYED_LIST [STRING]
			-- Balises XML opened.

	paragraphe_tag: STRING is "<PARA>"

feature

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- called whenever the parser findes a start element
		local
			retried: BOOLEAN
		do
			if not retried then
				current_tag.extend (a_local_part)
			end
		rescue
			retried := True
			retry
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
		local
			l_name: STRING
			retried: BOOLEAN
			index: INTEGER
		do
			if not retried then
				if current_tag.last.is_equal (See_str) then
					l_name := a_value
					if a_local_part.is_equal (Cref_str) then
						l_name.keep_tail (l_name.count - 2)
						index := l_name.index_of ('(', 1)
						if index > 0 then
							l_name.keep_head (index - 1)
						end
						current_comment.append (l_name)
					end	
					if a_local_part.is_equal (lang_str) then
						current_comment.append (a_value)						
					end
				elseif current_tag.last.is_equal (member_str) then
					a_member.reset
					l_name := a_value
					if a_local_part.is_equal (Name_str) then
						l_name.keep_tail (l_name.count - 2)
					end
					a_member.set_name (l_name)
				elseif current_tag.last.is_equal (Param_str) then
					check
						a_local_part.is_equal (Name_str)
					end
					a_parameter.set_name (name_formatter.formatted_variable_name (a_value))
				elseif current_tag.last.is_equal (Param_ref_str) then
					check
						a_local_part.is_equal (Name_str)
					end
					if not a_value.is_empty then
						current_comment.append_character ('`')
						current_comment.append (name_formatter.formatted_variable_name (a_value))
						current_comment.append_character ('%'')
					end
				elseif current_tag.last.is_equal (See_also_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Exception_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Permission_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Include_str) then
					check
						a_local_part.is_equal (File_str) or a_local_part.is_equal (Path_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (list_str) then
					check
						a_local_part.is_equal (type_str)
					end
					current_comment.append (a_value)
				else
					check
						Attribute_doesnot_belong_to_current_member: False
					end
				end
			end
		rescue
			retried := True
			retry
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- called whenever the parser findes an end element
		local
			l_str: STRING
			retried: BOOLEAN
		do
			if not retried then
				if current_tag.last.is_equal (Param_str) then
					l_str := format_comment (current_comment)
					a_parameter.set_description (l_str)
					a_member.add_parameter (a_parameter.deep_twin)
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Summary_str) then
					l_str := format_comment (current_comment)
					a_member.set_summary (l_str)
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Returns_str) then
					l_str := format_comment (current_comment)
					a_member.set_returns (l_str)
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Para_str) then
					-- Do nothing
				else
					-- Do nothing
				end
				current_tag.go_i_th (current_tag.count - 1)
				current_tag.remove_right
			end
		rescue
			retried := True
			retry
		end

feature -- Content

	on_content (a_content: STRING) is
			-- called whenever the parser findes character data
		local
			retried: BOOLEAN
		do
			if not retried then
				if current_tag.last.is_equal (Para_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Returns_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Summary_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Param_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Member_str) then
					-- Not implemented
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Basic Operation

	format_comment (a_comment: STRING): STRING is
			-- format `a_comment'.
		require
			non_void_a_comment: a_comment /= Void
			not_empty_a_comment: not a_comment.is_empty
		do
			Result := a_comment.twin
			Result.replace_substring_all ("%N", " ")
			Result.prune_all_leading (' ')
			Result.prune_all_trailing (' ')
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("  ", " ")
			Result.replace_substring_all (paragraphe_tag, "%N")
		end

feature {NONE} -- Formatter

	name_formatter: NAME_FORMATTER is
			-- Used to format argument names
		once
			create Result
		end
		
invariant
	non_void_a_member: a_member /= Void
	non_void_a_parameter: a_parameter /= Void
	non_void_current_comment: current_comment /= Void
	non_void_current_tag: current_tag /= Void

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


end -- class FEATURE_FILTER
