note
	description: "[
					Class to give the user a chance to redefine the optional methods
					implemented by delegates of NSApplication objects.
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

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			add_objc_callback ("applicationWillFinishLaunching:", agent application_will_finish_launching)
			Precursor
		end

feature -- NS_APPLICATION_DELEGATE_PROTOCOL

	application_will_finish_launching (a_notification: detachable NS_NOTIFICATION)
			--
		do
			setup_and_glue_gui
		end

feature {NONE} -- Implementation

	setup_and_glue_gui
			-- Create missing GUI elements, lay them out and connect them with the code.
		local
			circle_view: CIRCLE_VIEW
			frame: NS_RECT
			window: NS_WINDOW
		do
			check attached (create {NS_APPLICATION_UTILS}).shared_application as application then
					-- Retrieve the application window
				check attached application.windows as windows then
					check attached {NS_WINDOW} windows.object_at_index_ (0) as attached_window then
						window := attached_window
					end
				end
					-- Create the circle view and position it in the window
				create frame.make_with_coordinates (20, 116, 800, 661)
				create circle_view.make_with_frame_ (frame)
				circle_view.set_autoresizing_mask_ ((2 + 16).to_natural_64)
				check attached {NS_VIEW} window.content_view as content_view then
						content_view.add_subview_ (circle_view)
						-- Glue GUI to code
					check attached {NS_COLOR_WELL} content_view.view_with_tag_ (3) as control then
						control.set_action_ (create {OBJC_SELECTOR}.make_with_name ("takeColorFrom:"))
						control.set_target_ (circle_view)
					end
					check attached {NS_SLIDER} content_view.view_with_tag_ (1) as control then
						control.set_action_ (create {OBJC_SELECTOR}.make_with_name ("takeRadiusFrom:"))
						control.set_target_ (circle_view)
						control.set_continuous_ (True)
					end
					check attached {NS_SLIDER} content_view.view_with_tag_ (2) as control then
						control.set_action_ (create {OBJC_SELECTOR}.make_with_name ("takeStartingAngleFrom:"))
						control.set_target_ (circle_view)
						control.set_continuous_ (True)
					end
					check attached {NS_TEXT_FIELD} content_view.view_with_tag_ (5) as control then
						control.set_action_ (create {OBJC_SELECTOR}.make_with_name ("takeStringFrom:"))
						control.set_target_ (circle_view)
					end
					check attached {NS_BUTTON} content_view.view_with_tag_ (4) as control then
						control.set_action_ (create {OBJC_SELECTOR}.make_with_name ("toggleAnimation:"))
						control.set_target_ (circle_view)
					end

				end
			end
		end

end
