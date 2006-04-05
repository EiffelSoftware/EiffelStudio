indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_FORMAT_FILTER

inherit
	XML_FORMAT_FILTER
		redefine
			make,
			on_start_tag,
			on_end_tag,
			on_attribute
		end
	
	SHARED_OBJECTS		
		
create 
	make			
		
feature -- Creation

	make (a_rich_text: EV_RICH_TEXT) is
			-- 
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_filter: OUTPUT_FILTER
		do
			Precursor (a_rich_text)
			output_stack.wipe_out
			l_filters := shared_project.filter_manager.filters
			if l_filters /= Void and not l_filters.is_empty then
				from
					create output_list.make (l_filters.count)
					output_list.compare_objects
					l_filters.start
				until
					l_filters.after
				loop
					l_filter ?= l_filters.item_for_iteration
					if l_filter /= Void and then l_filter.highlighting_enabled then
						output_list.extend (l_filter.primary_output_flag)
					end
					l_filters.forth
				end
			end
		end

feature -- Status Setting

	set_control (a_rich_text: EV_RICH_TEXT) is
			-- Make
		do
			rich_text := a_rich_text	
		end		
			
	set_outputs (a_output_list: ARRAYED_LIST [STRING]) is
			-- Set `output_list'
		do
			output_list := a_output_list
		end		

feature {NONE} -- Processing

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Process `e'
		do
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Process `e'
		do			
			if a_local_part.is_equal (output_string_tag) then
				if not output_stack.is_empty then
					output_stack.remove
					if not output_stack.is_empty and then output_list.has (output_stack.item.primary_output_flag) then
						current_filter := output_stack.item
						internal_background_color := (current_filter.color)
					else						
						internal_background_color := white	
					end
				end				
			end
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Process `att'
		local
			l_filter: OUTPUT_FILTER
		do	
			if a_local_part.is_equal (output_string_tag) then
				l_filter ?= shared_project.filter_manager.output_filter_by_primary_flag (a_value)
				if l_filter /= Void then					
					output_stack.extend (l_filter)
					if output_list.has (a_value) then	
						current_filter := output_stack.item
						internal_background_color := (output_stack.item.color)
					end
				end	
			end
			Precursor (a_namespace, a_prefix, a_local_part, a_value)
		end	

feature {NONE} -- Implementation

	output_count: INTEGER
			-- No outputs tags being processed
			
	output_list: ARRAYED_LIST [STRING]
			-- Outputs to highlight

	output_string_tag: STRING is "output"

	output_stack: ARRAYED_STACK [OUTPUT_FILTER] is
			-- Output stack
		once
			create Result.make (1)
			Result.compare_objects
		end		

	current_filter: OUTPUT_FILTER;
			-- Current filter

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
end -- class OUTPUT_FORMAT_FILTER
