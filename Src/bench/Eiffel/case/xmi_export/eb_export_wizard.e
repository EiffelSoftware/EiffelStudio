indexing
	description: "Guides the user through the options for XMI export."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPORT_WIZARD

inherit
	EB_DOCUMENTATION_WIZARD
	redefine
		go_to_page,
		initialize
	end

create
	default_create

feature -- Initialization

	initialize is
			-- Sets defaults.
		do
			Precursor
			set_title ("XMI Export")
		end

feature {NONE} -- Implementation

	go_to_page (i: INTEGER) is
			-- Show page number `i' of current wizard.
		do
			inspect i when 1 then
				previous_button.disable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_cluster_selection
			when 2 then
				previous_button.enable_sensitive
				next_button.disable_sensitive
				finish_button.enable_sensitive
				set_default_push_button (finish_button)
				show_directory_selection
			end
		end

end -- class EB_EXPORT_WIZARD
