indexing
	description: "General notion of wizard dialog.  Inherit for custom functionality."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DIALOG

inherit
	EV_DIALOG
	
	WIZARD_INFORMATION
		undefine
			copy,
			is_equal,
			default_create
		end

feature -- Initialization		

	make (a_next, a_previous: WIZARD_DIALOG) is
			-- Make with `a_next' and `a_previous'
		require
			next_not_void: a_next /= Void
			previous_not_void: a_previous /= Void
			next_and_previous_valid: a_next /= a_previous
		do
			default_create
			next_dialog := a_next
			previous_dialog := a_previous
		ensure
			next_set: next_dialog /= Void
			previous_set: previous_dialog /= Void
		end

	make_with_next (a_next: WIZARD_DIALOG) is
			-- Make with `a_next'
		require
			next_not_void: a_next /= Void
		do
			default_create
			next_dialog := a_next
		ensure
			next_set: next_dialog /= Void
		end		

	make_with_previous (a_previous: WIZARD_DIALOG) is
			-- Make with `a_previous'
		require
			previous_not_void: a_previous /= Void
		do
			default_create
			previous_dialog := a_previous
		ensure
			previous_set: previous_dialog /= Void
		end		

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			disable_user_resize
		end

feature -- Display

	show_next is
			-- Show Current and hide `previous_dialog'
		do
			if previous_dialog /= Void then
				set_x_position (previous_dialog.x_position)
				set_y_position (previous_dialog.y_position)
				previous_dialog.hide
			end
			show
		end

	show_previous is
			-- Show Current `next_dialog'
		do
			if next_dialog /= Void then
				set_x_position (next_dialog.x_position)
				set_y_position (next_dialog.y_position)
				next_dialog.hide
			end
			show
		end		

	show_error is
			-- Show validation error
		local
			error_dlg: EV_INFORMATION_DIALOG
		do
			if validation_error /= Void and then not validation_error.is_empty then
				create error_dlg.make_with_text (validation_error)
				error_dlg.show_modal_to_window (Current)
			end
		end

feature -- Status setting

	set_summary is
			-- Set summary information based on chosen options
		deferred
		end		

	remove_summary is
			-- Remove summary data for Current (because of
			-- a back operation)
		local
			deleted: BOOLEAN
		do
			from
				Summary_list.start
			until
				Summary_list.after or deleted
			loop		
				if Summary_list.item.title.is_equal (summary.title) then
					Summary_list.item.wipe_out
					Summary_list.remove
					deleted := True
				else
					Summary_list.forth
				end
			end
		end		

	set_validation_error (a_error: STRING) is
			-- Set `validation_error'
		require
			a_error_not_void: a_error /= Void
			a_error_not_empty: not a_error.is_empty
		do
			validation_error := a_error
		ensure
			has_error: validation_error /= Void and (not validation_error.is_empty)
		end	
	
feature -- Commands

	cancel is
			-- Destroy Current
		do
			if next_dialog /= Void then
				next_dialog.destroy
			end
			if previous_dialog /= Void then
				previous_dialog.destroy
			end
			if not is_destroyed then
				destroy
			end
		end		

feature -- Traversal

	move_next is
			-- Move to `next_dialog'.  Redefine in children for
			-- custom behaviour
		do
			if is_valid then
				set_summary
				next_dialog.show_next
				hide
			else
				show_error
			end
		end

	move_previous is
			-- Move to `previous_dialog'
		require
			has_previous: previous_dialog /= Void 
		do
			remove_summary
			previous_dialog.show_previous
			hide
		end		

	set_next (a_next: WIZARD_DIALOG) is
			-- Set `next_dialog'
		require
			next_not_void: a_next /= Void
		do
			next_dialog := a_next
		ensure
			next_set: next_dialog /= Void
		end
		
	set_previous (a_previous: WIZARD_DIALOG) is
			-- Set `previous_dialog'
		require
			previous_not_void: a_previous /= Void
		do
			previous_dialog := a_previous
		ensure
			previous_set: previous_dialog /= Void
		end	

feature -- Implementation
	
	summary: SUMMARY_BOX is
			-- Title used for summary
		deferred
		end
	
	next_dialog: WIZARD_DIALOG
			-- Next Dialog	

	previous_dialog: WIZARD_DIALOG
			-- Previous Dialog

feature {NONE} -- Implementation

	is_valid: BOOLEAN is
			-- Are contents valid?  True by default, redefine
			-- for custom checking
		do
			Result := True
		end

	validation_error: STRING
			-- Error for invalid content

	add_option (a_option: STRING) is
			-- Set `a_option'
		require
			a_option: a_option /= Void
			a_option: not a_option.is_empty
		do
			summary.extend (a_option)
		end

end -- class WIZARD_DIALOG
