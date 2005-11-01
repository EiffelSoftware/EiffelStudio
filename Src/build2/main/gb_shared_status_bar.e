indexing
	description: "Objects that represent shared status bar features.%
		%Should only be inherited."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_STATUS_BAR

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize all action sequences and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create status_bar_label
			status_bar_label.align_text_left
		ensure
			components_set: components = a_components
		end

feature -- Access

	status_text: STRING is
			-- `Result' is text of `status_bar_label'.
		do
			Result := status_bar_label.text
		ensure
			result_not_void: Result /= Void
		end

	widget: EV_WIDGET is
			-- Widget of `Current'.
		do
			Result := status_bar_label
		ensure
			result_not_void: Result /= Void
		end

feature -- Status setting

	set_status_text (a_text: STRING) is
			-- Assign `a_text' to `status_bar_label'.
		require
			a_text_not_void: a_text /= Void
		do
			status_bar_label.set_text (a_text)
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void
			end
		end

	set_timed_status_text (a_text: STRING) is
			-- Assign `a_text' to `status_bar_label' which
			-- will be displayed for a set period of time.
		require
			a_text_not_void: a_text /= Void
		do
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void
			end
			set_status_text (a_text)
			create timed_text_timer.make_with_interval (timed_text_duration)
			timed_text_timer.actions.extend (agent clear_status_bar)
		end

	clear_status_bar is
			-- Clear text of `status_bar_label'.
		do
			status_bar_label.remove_text
			if timed_text_timer /= Void then
				timed_text_timer.destroy
				timed_text_timer := Void
			end
		end

	clear_status_after_transport (a: ANY) is
			-- Clear `status_bar' with an argument of type ANY,
			-- permitting it to be placed in the application wide pick and
			-- drop actions.
		do
			clear_status_bar
		ensure
			status_text_empty: status_text.is_empty
		end

	clear_status_during_transport (an_x, a_y: INTEGER; a_target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Clear status bar if `a_target' is Void. `an_x' and `a_y' are ignored, but the
			-- signature is required for the pick and drop action sequences.
		do
			if a_target = Void then
				clear_status_bar
			end
		ensure
			status_text_empty_if_target_void: a_target = Void implies status_text.is_empty
		end

feature {NONE} -- Implementation

	status_bar_label: EV_LABEL
			-- `Result' is label for status bar.
			-- All status bar text is displayed here.

	timed_text_timer: EV_TIMEOUT
		-- Timer for removing timed texts.

	timed_text_duration: INTEGER is 1000
		-- Length of time for timed texts to be displayed
		-- on status bar.

end -- class GB_STATUS_BAR
