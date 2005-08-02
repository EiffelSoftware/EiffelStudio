indexing
	description: "Common functionalities for all views of ES_INHERITANCE_LINKs."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_INHERITANCE_FIGURE

inherit
	EIFFEL_LINK_FIGURE
		rename
			source as descendant,
			target as ancestor
		redefine
			default_create,
			initialize,
			model,
			recycle
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create an inheritance figure.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			create {INHERIT_STONE} pebble.make (Current)
			set_accept_cursor (cursors.cur_inherit_link)
			set_deny_cursor (cursors.cur_x_inherit_link)
		end
		
	initialize is
			-- Initialize `Current' with `model'.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			model.needed_on_diagram_changed_actions.extend (agent on_needed_on_diagram_changed)
		end

feature -- Access

	model: ES_INHERITANCE_LINK
			-- Model for `Current'.

feature -- Element change
	
	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			if model /= Void then
				model.needed_on_diagram_changed_actions.prune_all (agent on_needed_on_diagram_changed)
			end
		end
			
feature {NONE} -- Implementation

	on_needed_on_diagram_changed is
			-- `model'.`is_needed_on_diagram' changed.
		do
			if model.is_needed_on_diagram then
				if world.is_inheritance_links_shown then
					show
					enable_sensitive
				end
			else
				hide
				disable_sensitive
			end
			request_update
		end

end -- class EIFFEL_INHERITANCE_FIGURE
