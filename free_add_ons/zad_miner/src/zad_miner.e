indexing
	description: "Launcher"
	author: "Jocelyn FIAT"
	version: "1.2"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ZAD_MINER

inherit
	EV_APPLICATION

	ARGUMENTS
		undefine
			default_create, copy
		end

creation

	make_and_launch


feature {NONE} -- Initialization

	make_and_launch is
			-- Initialize and launch application
		do
			default_create
			prepare
			launch
		end

	prepare is
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		local
			nx,ny: INTEGER
			t: INTEGER
		do
				--| create and initialize the first window.
			create first_window

				--| End the application when the first window is closed.
			first_window.close_request_actions.extend (agent end_application)


				--| get extra setting for x cols and y rows
			nx := get_opt_value ('x')
			ny := get_opt_value ('y')
			
				--| get extra setting for transparency mode or not of the buttons
			t := index_of_character_option ('t')
			
				--| About debug mode
			if index_of_word_option ("debug") > 0 then
				first_window.set_debuggable
			end

				--| initialize the application
			first_window.initialize_with (nx,ny, t /= 0) 


				--| Show the first window.
			first_window.show
		end

feature {NONE} -- Implementation

	first_window: MINER_WINDOW
			-- Main window.
	
	end_application is
			-- End the current application.
		do
			(create {EV_ENVIRONMENT}).application.destroy
		end

	get_opt_value (car: CHARACTER): INTEGER is
			-- Get integer optional value for `car'.
		local
			s: STRING
		do
			s := separate_character_option_value (car)
			if 
				s /= Void 
				and then not s.is_empty 
				and then s.is_integer
			then
				Result := s.to_integer
			end
			if Result < 1 then
					--| minimum is 10.
				Result := 10
			end
		end


end -- class ZAD_MINER

--|-------------------------------------------------------------------------
--| Eiffel Mine Sweeper -- ZaDoR (c) -- 
--| version 1.2 (July 2001)
--|
--| by Jocelyn FIAT
--| email: jocelyn.fiat@ifrance.com
--| 
--| freely distributable
--|-------------------------------------------------------------------------

