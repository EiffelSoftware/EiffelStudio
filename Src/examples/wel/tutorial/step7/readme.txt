IMPORTANT NOTE:

Since Personal ISE Eiffel 3 for Windows does not allow to use Windows
resources (.rc/.res files) we provide two different ways to ask the user
line thickness. The first one, for the Personal version, is based on a window
and the second, for the Professional version, is based on a dialog loaded from
the resources. According the version you use, class MAIN_WINDOW is slightly
different. In order to use the first or second solution, do the following:

Personal Eiffel for Windows user: copy "main_win.per" into "main_win.e".

Professional Eiffel for Windows user: copy "main_win.pro" into "main_win.e".
