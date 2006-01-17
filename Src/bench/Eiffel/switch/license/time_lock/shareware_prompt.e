indexing 
	description: "SHAREWARE_PROMPT class created by Resource Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class 
	SHAREWARE_PROMPT

inherit
	WEL_MODAL_DIALOG
		redefine
			setup_dialog,
			notify,
			on_ok,
			on_cancel,
			on_timer
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_BN_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (license: LICENSE; is_beta: BOOLEAN; duration, time_left, max: INTEGER) is
			-- Create the dialog.
		local
			dispatcher: WEL_DISPATCHER
		do
				-- In order to initialize the WEL message handling.
			create dispatcher.make 

				-- Creation of the dialog.
			if is_beta then
				make_by_id (Void, Idd_beta_constant)
			else
				make_by_id (Void, Idd_prompt_constant)
			end
			create id_ok.make_by_id (Current, Idok)
			create id_cancel.make_by_id (Current, Idcancel)
			create idc_register.make_by_id (Current, Idc_register_constant)
			create idc_progress.make_by_id (Current, Idc_progress_constant)
			create idc_min_days.make_by_id (Current, Idc_min_days_constant)
			create idc_max_days.make_by_id (Current, Idc_max_days_constant)
			
			remaining_time := time_left

				-- Storing license information
			license_info := license

				-- Setting duration
			nb_seconds := duration

				-- Setting evaluation time
			max_days := max
		end

feature -- Behavior

	setup_dialog is
		do
			idc_progress.set_range (0, max_days)
			registered_user := False
			id_ok.set_text (nb_seconds.out)
			id_ok.disable
			id_cancel.disable
			idc_max_days.set_text (max_days.out)
			set_timer (id_ok.id, Timer_interval)	
			if remaining_time >= 0 then
				idc_progress.set_position (max_days - remaining_time)
			else
				idc_progress.set_position (max_days)
			end
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		local
			loc_register_dialog: REGISTER_PROMPT
		do
			if control = idc_register and then notify_code = Bn_clicked then
				create loc_register_dialog.make (Current, license_info)
				loc_register_dialog.activate
				if registered_user then
						-- We have successfully been registered
						-- We now close the window
					destroy
				end
			end
		end

	on_timer (timer_id: INTEGER) is
		do
			nb_seconds := nb_seconds - 1
			if nb_seconds <= 0 then
				kill_timer (id_ok.id)
				if remaining_time >= 0 then
					id_ok.set_text ("OK")
				else
					id_ok.set_text ("Quit")
				end
				id_ok.enable
				id_cancel.enable
			else
				id_ok.set_text (nb_seconds.out)
			end
		end

	on_ok is
		do
			if remaining_time = -1 then
				license_info.set_demo_mode (False)
			else
				license_info.set_demo_mode (True)
			end
			destroy
		end

	on_cancel is
		do
			license_info.set_demo_mode (False)
			destroy
		end

feature -- Access

	id_ok: WEL_PUSH_BUTTON
	id_cancel: WEL_PUSH_BUTTON
	idc_register: WEL_PUSH_BUTTON
	
	idc_min_days, idc_max_days: WEL_STATIC

	idc_progress: WEL_PROGRESS_BAR

	remaining_time: INTEGER

	license_info: LICENSE

	registered_user: BOOLEAN
			-- Has the user click on `idc_register' and enter his information?

feature -- Settings

	set_registered_user (v: BOOLEAN) is
			-- Set `v' to `registered_user'.
		do
			registered_user := v
		ensure
			registered_user_set: v = registered_user
		end

feature {NONE} -- Implementation

	Timer_interval: INTEGER is 1000
			-- The timer will be launched every second.

	nb_seconds: INTEGER
			-- Number of seconds after which the product can be launched.
	
	max_days: INTEGER;
			-- Number of days where the user can try the product.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SHAREWARE_PROMPT

