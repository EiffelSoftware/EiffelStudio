indexing
	description	: "Text Selection Box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			display,
			change_item_widget
		end

create
	make

feature -- Access
	
	change_item_widget: EV_TEXT_FIELD
			-- Widget to change the value of this resource

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			tmpstr: STRING
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			
			tmpstr := new_resource.value
			change_item_widget.change_actions.block
			if tmpstr /= Void and then not tmpstr.is_empty then
				change_item_widget.set_text (tmpstr)
			else
				change_item_widget.remove_text
			end
			change_item_widget.change_actions.resume
		end

feature {NONE} -- Command

	update_changes is
			-- Commit the changes.
		local
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
			success: BOOLEAN
			widget_text: STRING
		do
			check
				resource_exists: resource /= Void
				change_item_widget_created: change_item_widget /= Void
			end
			
			widget_text := change_item_widget.text
			
			int ?= resource
			str ?= resource
			if int /= Void then
				if not widget_text.is_empty then
					if widget_text.is_integer then
						int.set_value (change_item_widget.text)
						success := True
					end
				else
					int.set_value ("0")
					success := True
				end
			elseif str /= Void then
				str.set_value (widget_text)
				success := True
			end
			if success then
				update_resource
				caller.update_selected (resource)
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.change_actions.extend (agent update_changes)
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

end -- class TEXT_SELECTION_BOX
