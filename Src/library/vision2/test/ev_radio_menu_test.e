indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	EV_RADIO_MENU_TEST

inherit
	EV_APPLICATION

creation

	make_and_launch


feature -- Access

	first_window: EV_RADIO_MENU_TEST_WINDOW is
			--
		once
			create Result.make
		end

	prepare is
		do
		--	first_window.show
		--	destroy
			post_launch_actions.extend (~destroy)
		end

end -- class ROOT_CLASS
