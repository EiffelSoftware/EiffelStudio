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

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

	first_window: EV_RADIO_MENU_TEST_WINDOW

	prepare is
		do
		--	first_window.show
		--	destroy
			create first_window.make
			post_launch_actions.extend (~destroy)
		end

end -- class EV_RADIO_MENU_TEST
