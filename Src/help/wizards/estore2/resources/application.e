indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	APPLICATION

inherit

	EV_APPLICATION
		select
			default_create
		end

	EXECUTION_ENVIRONMENT
		rename 
			launch as launch_exec,
			default_create as create_exec
		end

create
	make_and_launch

feature -- Initialization

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

	initiate is do end
			-- Intialize
 
	prepare is
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			first_window.set_title ("EiffelStore Wizard example")
			first_window.show
		end

feature -- Access to windows

	first_window: MAIN_WINDOW is
			-- Root window of the application.
		once
			create Result.make_window (Current)
		end

	select_window: SELECT_WINDOW
			-- Window to carry out a 'select' query.

	select_results_window: SEL_RES_WINDOW
			-- Window to show the 'select' results.
			
	insert_window: INSERT_WINDOW
			-- Window to carry out an 'insert' query.

	error_window: EV_WARNING_DIALOG
			-- Window to explain the proper use of the software

 feature -- Popups

	popup_select_window is
			-- Popup Select Window.
			-- Ensure the unicity of the window at run-time.
		do
			if select_window /= Void and then not select_window.is_destroyed then
				select_window.raise
			else
				create select_window.make_window (Current)
				select_window.set_title ("Select")
				select_window.show
			end
		end

	popup_select_results_window ( to_display : ARRAYED_LIST [DB_TABLE] ; row_titles : ARRAY [STRING] ) is
			-- Popup Select Results Window 'to_display' with feature names 'row_titles'
			-- Ensure the unicity of the window at run-time.
		do
			if select_results_window /= Void and then not select_results_window.is_destroyed then
				select_results_window.raise
			else
				create select_results_window.make_window (Current, to_display, row_titles)
				select_results_window.set_title ("Select results")
				select_results_window.show
			end
		end

	popup_insert_window is
			-- Popup Insert Window.
			-- Ensure the unicity of the window at run-time.
		do
			if insert_window /= Void and then not insert_window.is_destroyed then
				insert_window.raise
			else
				create insert_window.make_window (Current)
				insert_window.set_title ("Insert")
				insert_window.show
			end
		end

	popup_error_window ( error_text: STRING) is
			-- Popup Error Window.
		do
			create error_window.make_with_text  (error_text)
			error_window.show_modal
		end

	destroy_select_results_window  is
			-- Destroy Select Results Window.
		do
			if select_results_window /= Void and then not select_results_window.is_destroyed then
				select_results_window.destroy
			end
		end

	destroy_windows is
			-- Destroys all windows popped up through APPLICATION	
		do
			destroy
--			if first_window /= Void and then not first_window.is_destroyed then
--				first_window.destroy
--			end
--			if select_window /= Void and then not select_window.is_destroyed then
--				select_window.destroy
--			end
--			if select_results_window /= Void and then not select_results_window.is_destroyed then
--				select_results_window.destroy
--			end
--			if insert_window /= Void and then not insert_window.is_destroyed then
--				insert_window.destroy
--			end
		end

end -- class APPLICATION
