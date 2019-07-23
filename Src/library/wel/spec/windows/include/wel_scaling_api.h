/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
				Eiffel Software
				5949 Hollister Ave., Goleta, CA 93117 USA
				Telephone 805-685-1006, Fax 805-685-6869
				Website https://www.eiffel.com
				Customer support https://support.eiffel.com
		]"
*/

#ifndef _wel_scaling_api_h_
#define _wel_scaling_api_h_

#ifndef SCALING_ENUMS_DECLARED

typedef enum {
    DEVICE_PRIMARY = 0,
    DEVICE_IMMERSIVE = 1,
} DISPLAY_DEVICE_TYPE;

typedef enum {
    SCF_VALUE_NONE = 0x00,
    SCF_SCALE = 0x01,
    SCF_PHYSICAL = 0x02,
} SCALE_CHANGE_FLAGS;

#define SCALING_ENUMS_DECLARED
#endif

#ifndef DPI_ENUMS_DECLARED

typedef enum PROCESS_DPI_AWARENESS {
    PROCESS_DPI_UNAWARE = 0,
    PROCESS_SYSTEM_DPI_AWARE = 1,
    PROCESS_PER_MONITOR_DPI_AWARE = 2
} PROCESS_DPI_AWARENESS;

typedef enum MONITOR_DPI_TYPE {
    MDT_EFFECTIVE_DPI = 0,
    MDT_ANGULAR_DPI = 1,
    MDT_RAW_DPI = 2,
    MDT_DEFAULT = MDT_EFFECTIVE_DPI
} MONITOR_DPI_TYPE;

#define DPI_ENUMS_DECLARED
#endif

#endif /* _wel_scaling_api_h_ */
