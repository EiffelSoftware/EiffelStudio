indexing
	description: "implementation for EB_DEBUGGER_MANAGER"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_MANAGER_IMP

create {EB_DEBUGGER_MANAGER}
	default_create

feature {EB_DEBUGGER_MANAGER} -- Access

	ev_window_win32_handle (w: EB_VISION_WINDOW): POINTER is
		local
			w_impl: EV_WINDOW_IMP
		do
			w_impl ?= w.implementation
			if w_impl /= Void then
				Result := w_impl.wel_item
			end
		end

invariant
	is_windows_platform: (create {PLATFORM}).is_windows

end
