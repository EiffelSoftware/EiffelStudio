indexing
	description: "Object which representing a square"
	author: "Jocelyn FIAT"
	version: "1.2"
	date: "$Date$"
	revision: "$Revision$"

class
	MINER_BUTTON

inherit
	EV_BUTTON

	MINER_CONSTANTS
		undefine
			default_create, copy
		end

create
	default_create


feature -- Initialization

	init_mine is
		local
-- 			flag_it:EV_ROUTINE_COMMAND
		do
			reset
-- 			create flag_it.make(~put_a_flag)
-- 			add_button_press_command(3,flag_it,Void)
			pointer_button_press_actions.extend (~put_a_flag_action)
		end

	flagcode:INTEGER is
		do
			if is_flagged then
				Result := 1
			end
		end

	code:INTEGER is
		do
			if is_trapped then
				Result := 1
			end
		end
	is_trapped:BOOLEAN
	is_flagged:BOOLEAN
	is_shown:BOOLEAN

	reset is
		do
			is_trapped := False
			is_flagged := False
			is_shown := False
			set_pixmap (pix_first)
		end

	discover_it is
		do
			if is_flagged and not is_trapped then
 				set_pixmap (pix_mark_nok)
			elseif is_trapped and is_trapped then
 				set_pixmap (pix_mark)
			else
 				show_it
			end
		end

	show_it is
		do
			is_shown := True
 			if is_trapped then
 				set_pixmap(pix_boum)
 			else
-- 				set_pixmap()
 			end
		end


	put_a_flag_action 	(
							z_x, z_y: INTEGER; z_button: INTEGER;
							z_x_tilt, z_y_tilt: DOUBLE; z_pressure: DOUBLE;
							z_screen_x, z_screen_y: INTEGER
						) is
		do
			if z_button = 3 then
				put_a_flag
			end
		end

	put_a_flag is
		do
			if not is_shown then
				set_flag (not is_flagged)
			end
		end

	set_flag (val:BOOLEAN) is
		do
			is_flagged := val
			if val then
				set_pixmap (pix_mark)
			else
				set_pixmap (pix_first)
			end
		end

	set_trapped(val:BOOLEAN) is
		do
			is_trapped := val
		end

end -- class MINER_BUTTON

--|-------------------------------------------------------------------------
--| Eiffel Mine Sweeper -- ZaDoR (c) -- 
--| version 1.2 (July 2001)
--|
--| by Jocelyn FIAT
--| email: jocelyn.fiat@ifrance.com
--| 
--| freely distributable
--|-------------------------------------------------------------------------

