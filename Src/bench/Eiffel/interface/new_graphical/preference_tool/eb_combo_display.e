indexing

	description:
		"A list of resources, stored in a combo box"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMBO_DISPLAY

inherit
	EB_RESOURCE_DISPLAY
		redefine
			implementation
		end

	EV_VERTICAL_BOX
		redefine
			implementation,
			make
		end


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Initialize Current.
		require else
			valid_parent: par /= Void 
		do
			precursor (par)
			Create combo_box.make (Current)
			combo_box.set_expand (False)
			Create resources.make
		end

feature -- Access

	resources: LINKED_LIST [EB_RESOURCE_DISPLAY]
			-- The resources represented in the display

	resource_now_displayed: EB_RESOURCE_DISPLAY

feature -- Status setting

	is_changed: BOOLEAN is
		do
			from	
				resources.start
			until
				resources.after
			loop
				Result := Result or else resources.item.is_changed
				resources.forth
			end
		end

feature -- Validation

	validate is
			-- Validate Current's value.
			-- Store result in `is_valid'.
			--| Actual validation should only happen when
			--| the user specified a new value.
		do
			from
				resources.start
				is_resource_valid := true
			until
				resources.after
			loop
				resources.item.validate
				is_resource_valid := is_resource_valid
					 and then resources.item.is_resource_valid
				resources.forth
			end
		end

	reset is
			-- Reset the contents
		do
			from
				resources.start
			until
				resources.after
			loop
				resources.item.reset
				resources.forth
			end
		end

feature -- Basic Operations

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current in `file'.
		do
			from
				resources.start
			until
				resources.after
			loop
				resources.item.save (file)
				resources.forth
			end
			
		end

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current's value in `file'.
		do
			from
				resources.start
			until
				resources.after
			loop
				resources.item.save_value (file)
				resources.forth
			end
		end

feature -- Implementation

	add_resource_display (rd: EB_RESOURCE_DISPLAY) is
		deferred
		end

feature {NONE} -- Implementation

	combo_box: EV_COMBO_BOX

	implementation: EV_VERTICAL_BOX_I

end -- class EB_COMBO_DISPLAY
