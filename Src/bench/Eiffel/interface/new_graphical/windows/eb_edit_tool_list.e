indexing
	description: "Abstract notion of a list of edit tools."
	date: "$Date$"

deferred class
	EB_EDIT_TOOL_LIST [G -> EB_EDITOR]

inherit
	LINKED_LIST [G]

--	NEW_EB_CONSTANTS

	EB_RESOURCE_USER
		redefine
			dispatch_modified_resource
		end

feature -- Resource Update

	dispatch_modified_resource (mod_res: EB_MODIFIED_RESOURCE) is
			-- Dispatch modified resource based on
			-- the actual type of `old_res'.
		local
			old_b, new_b: EB_BOOLEAN_RESOURCE
			old_i, new_i: EB_INTEGER_RESOURCE
		do
			old_b ?= mod_res.old_resource
			if old_b /= Void then
				new_b ?= mod_res.new_resource
				update_boolean_resource (old_b, new_b)
			else
				old_i ?= mod_res.old_resource
				if old_i /= Void then
					new_i ?= mod_res.new_resource
					update_integer_resource (old_i, new_i)
				end
			end
		end

	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		do
			from
				start
			until
				after
			loop
--				item.update_boolean_resource (old_res, new_res)
				forth
			end
		end

	update_integer_resource (old_res, new_res: EB_INTEGER_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		do
			from
				start
			until
				after
			loop
--				item.update_integer_resource (old_res, new_res)
				forth
			end
		end

feature -- Fonts

	set_font_to_default is
			-- Set the font of all active editors to the default font.
		do
			from 
				start
			until
				after
			loop
				item.set_font_to_default
				forth
			end
		end

feature -- Tabulations

	set_tab_length (tab_length: INTEGER) is
			-- Set the tab length of all active editors 
			-- to `tab_length'.
		do
			from 
				start
			until
				after
			loop
				item.set_tab_length (tab_length)
				forth
			end
		end

feature -- Synchronization

	update_graphical_resources is
			-- Synchronize active editors.
		do
			from 
				start
			until
				after
			loop
				item.update_graphical_resources
				forth
			end
		end

	synchronize is
			-- Synchronize active editors.
		do
			from 
				start
			until
				after
			loop
				item.synchronize
				forth
			end
		end

	synchronize_to_default is
			-- Synchronize active editors.
			-- Set them back to their default format.
		do
			from 
				start
			until
				after
			loop
--				item.set_default_format
				item.synchronize
				forth
			end
		end

feature -- Modifications

	changed: BOOLEAN is
			-- Has the text of one of the active editor been edited
			-- since last display?
		do
			from
				start
			until
				Result or after
			loop
				Result := item.text_window.changed
				forth
			end
		end

feature {EB_TOOL_SUPERVISOR} -- Implementation

	hide_editors is
			-- Hide all active editors.
		do
			from
				start
			until
				after
			loop
				item.hide
				item.close_windows
				forth
			end
		end

	show_editors is
			-- Show all active editors.
		do
			from
				start
			until
				after
			loop
				item.show
				forth
			end
		end

	remove_editor (ed: G) is
			-- Remove an editor `ed'.
		require
			ed_in_list: has (ed)
		do
			start
			compare_references
			search (ed)
			if
				not after
			then
				remove
			end
			if not ed.destroyed then
				ed.destroy
			end
		ensure
			ed_not_in_list: not has (ed)
			ed_destroyed: ed.destroyed
		end

	raise_editors is
			-- Raise all active editors.
		do
			from
				start
			until
				after
			loop
				item.raise
				forth
			end
		end

	close_editors is
			-- Close all active editors.
		do
			from
				start
			until
				after
			loop
				item.destroy
				remove
			end
		end

end -- class EB_EDIT_TOOL_LIST
