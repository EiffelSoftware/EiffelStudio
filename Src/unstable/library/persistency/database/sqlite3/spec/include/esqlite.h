#ifndef _ESQLITE_H_
#define _ESQLITE_H_

#include "eif_eiffel.h"

/* unix-specific */
#ifndef EIF_WINDOWS 
#include <sys/time.h>
#include <unistd.h> 
#endif

#include "sqlite3.h"

#ifdef __cplusplus
extern "C" {
#endif

// Type definition for callback data.
typedef struct _eif_cb_data {
	EIF_OBJECT o;  // Eiffel object to perform callback on.
	void *func; // Function pointer to an Eiffel function.
} eif_cb_data;

#define EIF_CBDATA eif_cb_data
#define EIF_CBDATAP eif_cb_data*

// C callback function for 'int c_esqlite3_commit_callback(void *p_data)'
// Note: This is the function called back from SQLite and should
//       not be directly associated with an Eiffel class.
//
// `p_data': A EIF_CBDATAP struct reference, containing the Eiffel function
//           and Eiffel object to callback.
int c_esqlite3_commit_callback(void *p_data);

// C callback function for 'void *sqlite3_rollback_hook(sqlite3*, void(*)(void *), void*)'
// Note: This is the function called back from SQLite and should
//       not be directly associated with an Eiffel class.
//
// `p_data': A EIF_CBDATAP struct reference, containing the Eiffel function
//           and Eiffel object to callback.
void c_esqlite3_rollback_callback(void *p_data);

// C callback function for 'void *sqlite3_update_hook(sqlite3*, void(*)(void *, int, char const *, char const *, sqlite3_int64), void*)'
// Note: This is the function called back from SQLite and should
//       not be directly associated with an Eiffel class.
//
// `p_data': A EIF_CBDATAP struct reference, containing the Eiffel function
//           and Eiffel object to callback.
extern void c_esqlite3_update_callback (void *p_data, int action, char const *db_name, char const *tb_name, sqlite3_int64 row_id);

// C callback function for 'void *sqlite3_busy_handler(sqlite3*, int(*)(void *, int), void*)'
// Note: This is the function called back from SQLite and should
//       not be directly associated with an Eiffel class.
//
// `p_data': A EIF_CBDATAP struct reference, containing the Eiffel function
//           and Eiffel object to callback.
// `n': Number of times the busy handler has been called.
extern int c_esqlite3_busy_callback (void *p_data, int n);

// C callback function for 'void *sqlite3_progress(sqlite3*, int(*)(void *), void*)'
// Note: This is the function called back from SQLite and should
//       not be directly associated with an Eiffel class.
//
// `p_data': A EIF_CBDATAP struct reference, containing the Eiffel function
//           and Eiffel object to callback.
extern int c_esqlite3_progress_callback (void *p_data);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // _ESQLITE_H_
