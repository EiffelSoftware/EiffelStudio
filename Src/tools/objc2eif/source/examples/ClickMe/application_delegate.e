note
	description: "[
					Class to give the user a chance to redefine the optional methods
					implemented by delegates os NSApplication objects.
				  ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_DELEGATE

inherit
	NS_OBJECT
		redefine
			make
		end

	NS_APPLICATION_DELEGATE_PROTOCOL
		redefine
			application_did_finish_launching_
		end


create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
				-- Add Objective-C callbacks here.
			add_objc_callback ("applicationDidFinishLaunching:", agent application_did_finish_launching_)
			add_objc_callback ("clickMeButtonAction:", agent click_me_button_action)
			Precursor
		end

feature -- Access

	window_content_view: NS_VIEW
			-- Return the content view of the main window.
		local
			application: NS_APPLICATION
			windows: NS_ARRAY
			window: NS_WINDOW
		do
			check attached (create {NS_APPLICATION_UTILS}).shared_application as l_application then
				application := l_application
			end
			check attached application.windows as l_windows then
				windows := l_windows
			end
			check attached {NS_WINDOW} windows.object_at_index_ (0) as l_window then
				window := l_window
			end
			check attached {NS_VIEW} window.content_view as content_view then
				Result := content_view
			end
		end

	click_me_button: NS_BUTTON
			-- Return the click me button.
		once
			check attached {NS_BUTTON} window_content_view.view_with_tag_ (1) as button then
				Result := button
			end
		end

	text_field: NS_TEXT_FIELD
			-- Return the text field.
		once
			check attached {NS_TEXT_FIELD} window_content_view.view_with_tag_ (2) as l_text_field then
				Result := l_text_field
			end
		end

feature -- Actions

	click_me_button_action (sender: NS_BUTTON)
			-- Code to be executed when `click_me_button' is pressed.
		do
			text_field.set_string_value_ ("Hello World!")
		end

feature -- NS_APPLICATION_DELEGATE_PROTOCOL

	application_did_finish_launching_ (a_notification: NS_NOTIFICATION)
			-- Sent by the default notification center after the applicationhas been launched
			-- and initialized but before it has received its first event.
		do
			click_me_button.set_target_ (Current)
			click_me_button.set_action_ (create {OBJC_SELECTOR}.make_with_name ("clickMeButtonAction:"))
		end


end
