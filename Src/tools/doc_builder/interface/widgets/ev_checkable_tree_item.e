indexing	
	description: 
		"[
			Item for use with EV_CHECKABLE_TREE.  If there is an expand function it is called
			only once.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EV_CHECKABLE_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			parent_tree
		end

create
	default_create,
	make_with_text,
	make_with_text_and_expand_function

feature -- Creation

	make_with_text_and_expand_function (a_text: STRING; a_function: FUNCTION [ANY, TUPLE, ANY]) is
			-- Create `Current' and assign `a_text' to `text'
		local
			l_dummy_node: EV_TREE_ITEM
			l_parent: EV_CHECKABLE_TREE_ITEM
		do
			make_with_text (a_text)
			expand_function := a_function
			expand_actions.extend (agent call_expand_function)
			create l_dummy_node
			extend (l_dummy_node)			
			if parent_tree /= Void and then parent_tree.state_recursive then
				l_parent ?= parent
				if parent /= Void then
					set_recursive_state	(l_parent.is_checked)					
				end
			end				
		end

feature -- Access

	is_checked: BOOLEAN
			-- Is Current currently checked?

feature {EV_CHECKABLE_TREE, EV_CHECKABLE_TREE_ITEM} -- Status Setting

	set_checked is
			-- Check
		do
			if parent_tree /= Void then				
				set_pixmap (parent_tree.checked_pixmap)				
				is_checked := True
				if parent_tree.state_recursive then
					set_recursive_state	(True)				
				end				
			end
		end

	set_unchecked is
			-- Ensure check associated with `tree_item' is
			-- unchecked.
		do
			if parent_tree /= Void then					
				set_pixmap (parent_tree.unchecked_pixmap)								
				is_checked := False
				if parent_tree.state_recursive then
					set_recursive_state (False)	
				end				
			end
		end

feature -- Implementation

	expand_function: FUNCTION [ANY, TUPLE, ANY]
			-- Function to call on expand

	call_expand_function is
			-- Call `expand_function'
		require
			has_expand_function_to_call: expand_function /= Void
		local
			l_children: SEQUENCE [EV_TREE_NODE]
		do
			if not expand_called then	
				expand_called := True
				wipe_out
				l_children ?= expand_function.item (expand_function.operands)
				if l_children /= Void then					
					append (l_children)	
				end
			end
		end		
		
	expand_called: BOOLEAN
			-- Has expand been called?

	parent_tree: EV_CHECKABLE_TREE is
			-- Parent tree
		do
			Result ?= Precursor	
		end	

	set_recursive_state (checked: BOOLEAN) is
			-- Set state recursively
		require
			has_parent_tree: parent_tree /= Void
		local
			l_checkable: EV_CHECKABLE_TREE_ITEM
		do			
				-- Set children.  Check for expand function, since no expand function means no
				-- children.
			if expand_function /= Void then
				from				
					call_expand_function
					start
				until
					after
				loop
					l_checkable ?= item
					if l_checkable /= Void then
						if checked then
							parent_tree.check_item (l_checkable)
						else
							parent_tree.uncheck_item (l_checkable)
						end
					end
					forth
				end
			end
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
end -- class EV_CHECKABLE_TREE_ITEM
